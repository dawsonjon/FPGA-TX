--------------------------------------------------------------------------------
---
---  SERIAL INPUT
---
---  :Author: Jonathan P Dawson
---  :Date: 17/10/2013
---  :email: chips@jondawson.org.uk
---  :license: MIT
---  :Copyright: Copyright (C) Jonathan P Dawson 2013
---
---  A Serial Input Component
---
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity serial_input is

  generic(
    clock_frequency : integer;
    baud_rate       : integer
  );
  port(
    clk      : in std_logic;
    rst      : in std_logic;
    rx       : in std_logic;
   
    out1     : out std_logic_vector(7 downto 0);
    out1_stb : out std_logic;
    out1_ack : in  std_logic
  );

end entity serial_input;

architecture rtl of serial_input is

  component fifo is
    generic(
      width : integer;
      depth : integer
    );
    port(
      clk : in std_logic;
      rst : in std_logic;

      input : in std_logic_vector(width-1 downto 0);
      input_stb : in std_logic;
      input_ack : out std_logic;

      output : out std_logic_vector(width-1 downto 0);
      output_stb : out std_logic;
      output_ack : in std_logic
    );
  end component fifo;

  constant bit_clocks     : integer := integer(round(real(clock_frequency)/real(baud_rate)))-1;
  constant bit_clocks_1_5 : integer := integer(round(real(clock_frequency)/real(baud_rate) * 1.5))-1;

  signal bit_count : integer range 0 to 8;
  signal bit_spacing : integer range 0 to bit_clocks_1_5;

  type serial_in_state_type is (idle, get_byte, output_data, wait_done);
  signal state : serial_in_state_type;
  signal rx_d, rx_d2 : std_logic;
  signal data : std_logic_vector(8 downto 0);

  signal int_out1     : std_logic_vector(7 downto 0);
  signal int_out1_stb : std_logic;
  signal int_out1_ack : std_logic;

begin

  fifo_1 : fifo generic map(
      width => 8,
      depth => 8192
  ) port map(
      clk => clk,
      rst => rst,

      input => int_out1,
      input_stb => int_out1_stb,
      input_ack => int_out1_ack,

      output => out1,
      output_stb => out1_stb,
      output_ack => out1_ack
  );

  process
  begin
    wait until rising_edge(clk);
    rx_d <= rx;
    rx_d2 <= rx_d;
    
    case state is

      when idle =>
        if rx_d2 = '0' then
          state <= get_byte;
          bit_spacing <= bit_clocks_1_5;
          bit_count <= 8;
        end if;

      when get_byte =>
        if bit_spacing = 0 then
          data <= rx_d2 & data(8 downto 1);
          if bit_count = 0 then
            int_out1_stb <= '1';
            state <= output_data;
          else
            bit_spacing <= bit_clocks;
            bit_count <= bit_count - 1;
          end if;
        else
          bit_spacing <= bit_spacing - 1;
        end if; 

      when output_data =>
        if int_out1_ack = '1' then
          int_out1_stb <= '0';
          state <= wait_done;
        end if;

      when wait_done =>
        if rx_d2 = '1' then
          state <= idle;
        end if;

      when others =>
        state <= idle;
    end case;

    if rst = '1' then
      state <= idle;
      int_out1_stb <= '0';
    end if; 

  end process;
  int_out1 <= data(7 downto 0);

end architecture rtl;
