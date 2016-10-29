library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity nco is
  generic(
    width : integer
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
      x(i) := std_logic_vector(to_signed(integer(round(sin_output_scale * sin(real(i) * sin_input_scale))), sin_bits));
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

  signal t_0 : unsigned(31 downto 0);
  signal t_1 : unsigned(31 downto 0);
  signal t_2 : unsigned(31 downto 0);
  signal t_3 : unsigned(31 downto 0);
  signal t_4 : unsigned(31 downto 0);
  signal t_5 : unsigned(31 downto 0);
  signal t_6 : unsigned(31 downto 0);
  signal t_7 : unsigned(31 downto 0);

  signal w_0 : unsigned(63 downto 0);
  signal w_1 : unsigned(63 downto 0);
  signal w_2 : unsigned(63 downto 0);
  signal w_3 : unsigned(63 downto 0);
  signal w_4 : unsigned(63 downto 0);
  signal w_5 : unsigned(63 downto 0);
  signal w_6 : unsigned(63 downto 0);
  signal w_7 : unsigned(63 downto 0);

  signal count : unsigned(31 downto 0) := (others => '0');

begin


  process
  begin
    wait until rising_edge(clk);

      count <= count + 1;

      t_0 <= count(28 downto 0) & to_unsigned(0, 3);
      t_1 <= count(28 downto 0) & to_unsigned(1, 3);
      t_2 <= count(28 downto 0) & to_unsigned(2, 3);
      t_3 <= count(28 downto 0) & to_unsigned(3, 3);
      t_4 <= count(28 downto 0) & to_unsigned(4, 3);
      t_5 <= count(28 downto 0) & to_unsigned(5, 3);
      t_6 <= count(28 downto 0) & to_unsigned(6, 3);
      t_7 <= count(28 downto 0) & to_unsigned(7, 3);

      w_0 <= t_0 * unsigned(frequency);
      w_1 <= t_1 * unsigned(frequency);
      w_2 <= t_2 * unsigned(frequency);
      w_3 <= t_3 * unsigned(frequency);
      w_4 <= t_4 * unsigned(frequency);
      w_5 <= t_5 * unsigned(frequency);
      w_6 <= t_6 * unsigned(frequency);
      w_7 <= t_7 * unsigned(frequency);

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
