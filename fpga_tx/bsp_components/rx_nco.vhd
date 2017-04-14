library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity rx_nco is
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
    lo_i_0 : out std_logic;

    lo_q_1 : out std_logic;
    lo_q_2 : out std_logic;
    lo_q_3 : out std_logic;
    lo_q_4 : out std_logic;
    lo_q_5 : out std_logic;
    lo_q_6 : out std_logic;
    lo_q_7 : out std_logic;
    lo_q_0 : out std_logic

  );
end entity rx_nco;

architecture rtl of rx_nco is

  signal w_1 : unsigned(31 downto 0);
  signal w_2 : unsigned(31 downto 0);
  signal w_3 : unsigned(31 downto 0);
  signal w_4 : unsigned(31 downto 0);
  signal w_5 : unsigned(31 downto 0);
  signal w_6 : unsigned(31 downto 0);
  signal w_7 : unsigned(31 downto 0);
  signal w_8 : unsigned(31 downto 0);

  signal frequency_d1 : unsigned(31 downto 0) := (others => '0');
  signal frequency_d2 : unsigned(31 downto 0) := (others => '0');
  signal frequency_d3 : unsigned(31 downto 0) := (others => '0');
  signal accum : unsigned(31 downto 0) := (others => '0');
  signal tree_0 : unsigned(31 downto 0) := (others => '0');
  signal tree_1 : unsigned(31 downto 0) := (others => '0');
  signal tree_00 : unsigned(31 downto 0) := (others => '0');
  signal tree_01 : unsigned(31 downto 0) := (others => '0');
  signal tree_10 : unsigned(31 downto 0) := (others => '0');
  signal tree_11 : unsigned(31 downto 0) := (others => '0');
  signal tree_000 : unsigned(31 downto 0) := (others => '0');
  signal tree_001 : unsigned(31 downto 0) := (others => '0');
  signal tree_010 : unsigned(31 downto 0) := (others => '0');
  signal tree_011 : unsigned(31 downto 0) := (others => '0');
  signal tree_100 : unsigned(31 downto 0) := (others => '0');
  signal tree_101 : unsigned(31 downto 0) := (others => '0');
  signal tree_110 : unsigned(31 downto 0) := (others => '0');
  signal tree_111 : unsigned(31 downto 0) := (others => '0');

begin

  process
  begin
    wait until rising_edge(clk);

      frequency_d1 <= unsigned(frequency);
      frequency_d2 <= frequency_d1;
      frequency_d3 <= frequency_d2;

      accum  <= accum + (unsigned(frequency(28 downto 0)) & "000");

      tree_0 <= accum;
      tree_1 <= accum + (frequency_d1(29 downto 0) & "00");

      tree_00 <= tree_0;
      tree_01 <= tree_0 + (frequency_d2(30 downto 0) & '0');
      tree_10 <= tree_1;
      tree_11 <= tree_1 + (frequency_d2(30 downto 0) & '0');

      tree_000 <= tree_00;
      tree_001 <= tree_00 + frequency_d3;
      tree_010 <= tree_01;
      tree_011 <= tree_01 + frequency_d3;
      tree_100 <= tree_10;
      tree_101 <= tree_10 + frequency_d3;
      tree_110 <= tree_11;
      tree_111 <= tree_11 + frequency_d3;

      w_1 <= tree_000;
      w_2 <= tree_001;
      w_3 <= tree_010;
      w_4 <= tree_011;
      w_5 <= tree_100;
      w_6 <= tree_101;
      w_7 <= tree_110;
      w_8 <= tree_111;

      lo_i_1 <= not(w_1(31) xor w_1(30));
      lo_i_2 <= not(w_2(31) xor w_2(30));
      lo_i_3 <= not(w_3(31) xor w_3(30));
      lo_i_4 <= not(w_4(31) xor w_4(30));
      lo_i_5 <= not(w_5(31) xor w_5(30));
      lo_i_6 <= not(w_6(31) xor w_6(30));
      lo_i_7 <= not(w_7(31) xor w_7(30));
      lo_i_8 <= not(w_8(31) xor w_8(30));

      lo_q_1 <= not w_1(31);
      lo_q_2 <= not w_2(31);
      lo_q_3 <= not w_3(31);
      lo_q_4 <= not w_4(31);
      lo_q_5 <= not w_5(31);
      lo_q_6 <= not w_6(31);
      lo_q_7 <= not w_7(31);
      lo_q_8 <= not w_8(31);

  end process;

end rtl;
