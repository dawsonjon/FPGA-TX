
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity serial_tb is
end entity serial_tb;

architecture rtl of serial_tb is

  component serial_input is
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
  end component serial_input;

  component serial_output is
    generic(
      CLOCK_FREQUENCY : integer;
      BAUD_RATE       : integer
    );
    port(
      CLK     : in std_logic;
      RST     : in  std_logic;
      TX      : out std_logic := '1';
     
      IN1     : in std_logic_vector(7 downto 0);
      IN1_STB : in std_logic;
      IN1_ACK : out std_logic := '1'
    );
  end component serial_output;

  signal clk      : std_logic;
  signal rst      : std_logic;
  signal rx       : std_logic;
  signal out1     : std_logic_vector(7 downto 0);
  signal out1_stb : std_logic;
  signal out1_ack : std_logic;
  signal IN1     : std_logic_vector(7 downto 0);
  signal IN1_STB : std_logic;
  signal IN1_ACK : std_logic;

begin

  in1 <= X"5A";
in1_stb <= '1';

  process
  begin
    clk <= '0';
    while True loop
      wait for 5 ns;
      clk <= not clk;
    end loop;
    wait;
  end process;

  process
  begin
    rst <= '0';
    wait for 20 ns;
    rst <= '1';
  end process;

  process
  begin
    out1_ack <= '0';
    wait for 1 ms;
    out1_ack <= '1';
    wait;
  end process;

  uut1 : serial_input 
    generic map(
      clock_frequency => 100000000,
      baud_rate => 230400
    ) port map (
      clk => clk,
      rst => rst,
      rx => rx,
     
      out1 => out1,
      out1_stb => out1_stb,
      out1_ack => out1_ack
    );

  uut2 : serial_output
    generic map(
      CLOCK_FREQUENCY => 100000000,
      BAUD_RATE => 230400
    ) port map(
      CLK => CLK,
      RST => RST,
      TX => rx,
     
      IN1 => IN1,
      IN1_STB => IN1_STB,
      IN1_ACK => IN1_ACK
    );

end architecture rtl;
