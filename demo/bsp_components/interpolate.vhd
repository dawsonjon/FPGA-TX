library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity interpolate is
  generic(
    interpolation_factor : integer;
    output_width : integer;
    width        : integer
  );
  port(
    clk : in std_logic;
    rst : in std_logic;

    input : in std_logic_vector(width - 1 downto 0);
    input_stb : in std_logic;
    input_ack : out std_logic;

    output_0 : out std_logic_vector(output_width - 1 downto 0);
    output_1 : out std_logic_vector(output_width - 1 downto 0);
    output_2 : out std_logic_vector(output_width - 1 downto 0);
    output_3 : out std_logic_vector(output_width - 1 downto 0);
    output_4 : out std_logic_vector(output_width - 1 downto 0);
    output_5 : out std_logic_vector(output_width - 1 downto 0);
    output_6 : out std_logic_vector(output_width - 1 downto 0);
    output_7 : out std_logic_vector(output_width - 1 downto 0)
  );
end entity interpolate;

architecture rtl of interpolate is

    signal count : integer range 0 to interpolation_factor - 1 := 0;
    signal last_input : signed(output_width - 1 downto 0) := (others => '0');
    signal delta : signed(output_width - 1 downto 0) := (others => '0');
    signal delta_d1 : signed(output_width - 1 downto 0) := (others => '0');
    signal delta_d2 : signed(output_width - 1 downto 0) := (others => '0');
    signal delta_d3 : signed(output_width - 1 downto 0) := (others => '0');
    signal accum : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_0 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_1 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_00 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_01 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_10 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_11 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_000 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_001 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_010 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_011 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_100 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_101 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_110 : signed(output_width - 1 downto 0) := (others => '0');
    signal tree_111 : signed(output_width - 1 downto 0) := (others => '0');

begin


  process
  begin
    wait until rising_edge(clk);

    if count = 0 then
      count <= interpolation_factor-1;
      last_input <= resize(signed(input), output_width);
      delta <= resize(signed(input), output_width) - last_input;
      input_ack <= '1';
    else
      count <= count - 1;
      input_ack <= '0';
    end if;

    delta_d1 <= delta;
    delta_d2 <= delta_d1;
    delta_d3 <= delta_d2;

    accum  <= accum + (delta(output_width-4 downto 0) & "000");

    tree_0 <= accum;
    tree_1 <= accum + (delta_d1(output_width-3 downto 0) & "00");

    tree_00 <= tree_0;
    tree_01 <= tree_0 + (delta_d2(output_width-2 downto 0) & '0');
    tree_10 <= tree_1;
    tree_11 <= tree_1 + (delta_d2(output_width-2 downto 0) & '0');

    tree_000 <= tree_00;
    tree_001 <= tree_00 + delta_d3;
    tree_010 <= tree_01;
    tree_011 <= tree_01 + delta_d3;
    tree_100 <= tree_10;
    tree_101 <= tree_10 + delta_d3;
    tree_110 <= tree_11;
    tree_111 <= tree_11 + delta_d3;

    output_0 <= std_logic_vector(tree_000);
    output_1 <= std_logic_vector(tree_001);
    output_2 <= std_logic_vector(tree_010);
    output_3 <= std_logic_vector(tree_011);
    output_4 <= std_logic_vector(tree_100);
    output_5 <= std_logic_vector(tree_101);
    output_6 <= std_logic_vector(tree_110);
    output_7 <= std_logic_vector(tree_111);

  end process;

end rtl;
