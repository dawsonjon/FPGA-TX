library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity nco is
  generic(
    width : integer := 32
  );
  port(
    clk : in std_logic;
    rst : in std_logic;

    frequency : in std_logic_vector(31 downto 0);

    lo_i_0 : out std_logic_vector(width - 1 downto 0);
    lo_i_1 : out std_logic_vector(width - 1 downto 0);
    lo_i_2 : out std_logic_vector(width - 1 downto 0);
    lo_i_3 : out std_logic_vector(width - 1 downto 0);
    lo_i_4 : out std_logic_vector(width - 1 downto 0);
    lo_i_5 : out std_logic_vector(width - 1 downto 0);
    lo_i_6 : out std_logic_vector(width - 1 downto 0);
    lo_i_7 : out std_logic_vector(width - 1 downto 0);

    lo_q_0 : out std_logic_vector(width - 1 downto 0);
    lo_q_1 : out std_logic_vector(width - 1 downto 0);
    lo_q_2 : out std_logic_vector(width - 1 downto 0);
    lo_q_3 : out std_logic_vector(width - 1 downto 0);
    lo_q_4 : out std_logic_vector(width - 1 downto 0);
    lo_q_5 : out std_logic_vector(width - 1 downto 0);
    lo_q_6 : out std_logic_vector(width - 1 downto 0);
    lo_q_7 : out std_logic_vector(width - 1 downto 0)
  );
end entity nco;

architecture rtl of nco is

  constant sin_bits : integer := width;
  constant sin_scale : real := 2.0**real(sin_bits);
  constant sin_output_scale : real := ((2.0**real(sin_bits-1))-1.0) / sqrt(2.0);
  constant sin_input_scale : real := ((2.0 * math_pi)/sin_scale);

  type sin_array_type is array (0 to (2**sin_bits)-1) of std_logic_vector(sin_bits-1 downto 0);

  function initialise_sin_array return sin_array_type is
    variable x : sin_array_type;
  begin
    for i in 0 to (2**sin_bits)-1 loop
      x(i) := std_logic_vector(to_signed(-integer(round(sin_output_scale * sin(real(i) * sin_input_scale))), sin_bits));
    end loop;
    return x;
  end function;

  function initialise_cos_array return sin_array_type is
    variable x : sin_array_type;
  begin
    for i in 0 to (2**sin_bits)-1 loop
      x(i) := std_logic_vector(to_signed(integer(round(sin_output_scale * cos(real(i) * sin_input_scale))), sin_bits));
    end loop;
    return x;
  end function;

  constant sin_array : sin_array_type := initialise_sin_array;
  constant cos_array : sin_array_type := initialise_cos_array;

  signal w_0 : unsigned(31 downto 0);
  signal w_1 : unsigned(31 downto 0);
  signal w_2 : unsigned(31 downto 0);
  signal w_3 : unsigned(31 downto 0);
  signal w_4 : unsigned(31 downto 0);
  signal w_5 : unsigned(31 downto 0);
  signal w_6 : unsigned(31 downto 0);
  signal w_7 : unsigned(31 downto 0);

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

      w_0 <= tree_000;
      w_1 <= tree_001;
      w_2 <= tree_010;
      w_3 <= tree_011;
      w_4 <= tree_100;
      w_5 <= tree_101;
      w_6 <= tree_110;
      w_7 <= tree_111;

      lo_q_0 <= sin_array(to_integer(w_0(31 downto 32-sin_bits)));
      lo_q_1 <= sin_array(to_integer(w_1(31 downto 32-sin_bits)));
      lo_q_2 <= sin_array(to_integer(w_2(31 downto 32-sin_bits)));
      lo_q_3 <= sin_array(to_integer(w_3(31 downto 32-sin_bits)));
      lo_q_4 <= sin_array(to_integer(w_4(31 downto 32-sin_bits)));
      lo_q_5 <= sin_array(to_integer(w_5(31 downto 32-sin_bits)));
      lo_q_6 <= sin_array(to_integer(w_6(31 downto 32-sin_bits)));
      lo_q_7 <= sin_array(to_integer(w_7(31 downto 32-sin_bits)));

      lo_i_0 <= cos_array(to_integer(w_0(31 downto 32-sin_bits)));
      lo_i_1 <= cos_array(to_integer(w_1(31 downto 32-sin_bits)));
      lo_i_2 <= cos_array(to_integer(w_2(31 downto 32-sin_bits)));
      lo_i_3 <= cos_array(to_integer(w_3(31 downto 32-sin_bits)));
      lo_i_4 <= cos_array(to_integer(w_4(31 downto 32-sin_bits)));
      lo_i_5 <= cos_array(to_integer(w_5(31 downto 32-sin_bits)));
      lo_i_6 <= cos_array(to_integer(w_6(31 downto 32-sin_bits)));
      lo_i_7 <= cos_array(to_integer(w_7(31 downto 32-sin_bits)));

  end process;



end rtl;
