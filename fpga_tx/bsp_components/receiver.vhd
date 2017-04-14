
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity receiver is
  port(
    clk : in std_logic;
    rst : in std_logic;
    frequency : in std_logic_vector(31 downto 0);
    frequency_stb : in std_logic;
    frequency_ack : out std_logic;
    i : inout std_logic;
    i_n : inout std_logic;
    q : inout std_logic;
    q_n : inout std_logic
  );
end entity receiver;

architecture rtl of receiver is

  signal frequency_reg : std_logic_vector(31 downto 0) := (others => '0');

  component rx_nco is
    port(
      clk : in std_logic;
      rst : in std_logic;

      frequency : in std_logic_vector(31 downto 0);

      lo_i_1 : out std_logic;
      lo_i_2 : out std_logic;
      lo_i_3 : out std_logic;
      lo_i_4 : out std_logic;
      lo_i_5 : out std_logic;
      lo_i_6 : out std_logic;
      lo_i_7 : out std_logic;
      lo_i_8 : out std_logic;

      lo_q_1 : out std_logic;
      lo_q_2 : out std_logic;
      lo_q_3 : out std_logic;
      lo_q_4 : out std_logic;
      lo_q_5 : out std_logic;
      lo_q_6 : out std_logic;
      lo_q_7 : out std_logic;
      lo_q_8 : out std_logic

    );
  end component rx_nco;

  component rx_serdes is
    port(
      clk : in std_logic;
      rst : in std_logic;

      i_1 : in std_logic;
      i_2 : in std_logic;
      i_3 : in std_logic;
      i_4 : in std_logic;
      i_5 : in std_logic;
      i_6 : in std_logic;
      i_7 : in std_logic;
      i_8 : in std_logic;

      q_1 : in std_logic;
      q_2 : in std_logic;
      q_3 : in std_logic;
      q_4 : in std_logic;
      q_5 : in std_logic;
      q_6 : in std_logic;
      q_7 : in std_logic;
      q_8 : in std_logic;

      i : inout std_logic;
      i_n : inout std_logic;
      q : inout std_logic;
      q_n : inout std_logic

    );
  end component rx_serdes;

begin

  process
  begin
    wait until rising_edge(clk);

    if frequency_stb = '1' then
      frequency_reg <= frequency;
    end if;

  end process;
  frequency_ack <= '1';

  rx_nco_inst_1 : rx_nco port map(

      clk => clk,
      rst => rst,

      frequency  => frequency_reg,

      lo_i_1 => i_1,
      lo_i_2 => i_2,
      lo_i_3 => i_3,
      lo_i_4 => i_4,
      lo_i_5 => i_5,
      lo_i_6 => i_6,
      lo_i_7 => i_7,
      lo_i_8 => i_8,
                   
      lo_q_1 => q_1,
      lo_q_2 => q_2,
      lo_q_3 => q_3,
      lo_q_4 => q_4,
      lo_q_5 => q_5,
      lo_q_6 => q_6,
      lo_q_7 => q_7,
      lo_q_8 => q_8

  );

  rx_serdes_inst_1 : rx_serdes port map(
      clk => clk,
      rst => rst,

      i_1 => i_1,
      i_2 => i_2,
      i_3 => i_3,
      i_4 => i_4,
      i_5 => i_5,
      i_6 => i_6,
      i_7 => i_7,
      i_8 => i_8,

      q_1 => q_1,
      q_2 => q_2,
      q_3 => q_3,
      q_4 => q_4,
      q_5 => q_5,
      q_6 => q_6,
      q_7 => q_7,
      q_8 => q_8,

      i => i,
      i_n => i_n,
      q => q,
      q_n => q_n
  );

end rtl;
