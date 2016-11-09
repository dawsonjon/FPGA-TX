library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dac_interface is
  generic(
    width     : integer := 32
  );
  port(
    clk : in std_logic;
    rst : in std_logic;

    input_0 : in std_logic_vector(width - 1 downto 0);
    input_1 : in std_logic_vector(width - 1 downto 0);
    input_2 : in std_logic_vector(width - 1 downto 0);
    input_3 : in std_logic_vector(width - 1 downto 0);
    input_4 : in std_logic_vector(width - 1 downto 0);
    input_5 : in std_logic_vector(width - 1 downto 0);
    input_6 : in std_logic_vector(width - 1 downto 0);
    input_7 : in std_logic_vector(width - 1 downto 0);
    dithering : in std_logic;

    output : out std_logic
  );
end entity dac_interface;

architecture rtl of dac_interface is

  function to_std(x : boolean) return std_logic is
  begin
    if x then
      return '1';
    else
      return '0';
    end if;
  end function;

  component serdes is
    port(
      clk : in std_logic;
      rst : in std_logic;

      input_0 : in std_logic;
      input_1 : in std_logic;
      input_2 : in std_logic;
      input_3 : in std_logic;
      input_4 : in std_logic;
      input_5 : in std_logic;
      input_6 : in std_logic;
      input_7 : in std_logic;

      output : out std_logic
    );
  end component serdes;

  signal rand_0 : unsigned(31 downto 0) := X"A000b001";
  signal rand_1 : unsigned(31 downto 0) := X"B0000002"; 
  signal rand_2 : unsigned(31 downto 0) := X"C000e003";
  signal rand_3 : unsigned(31 downto 0) := X"D0000004";
  signal rand_4 : unsigned(31 downto 0) := X"E0004005";
  signal rand_5 : unsigned(31 downto 0) := X"F0000006";
  signal rand_6 : unsigned(31 downto 0) := X"00f00007";
  signal rand_7 : unsigned(31 downto 0) := X"0000e008";

  signal dithered_0 : std_logic;
  signal dithered_1 : std_logic;
  signal dithered_2 : std_logic;
  signal dithered_3 : std_logic;
  signal dithered_4 : std_logic;
  signal dithered_5 : std_logic;
  signal dithered_6 : std_logic;
  signal dithered_7 : std_logic;

  signal dac_0 : std_logic;
  signal dac_1 : std_logic;
  signal dac_2 : std_logic;
  signal dac_3 : std_logic;
  signal dac_4 : std_logic;
  signal dac_5 : std_logic;
  signal dac_6 : std_logic;
  signal dac_7 : std_logic;

begin


  process
  begin

    wait until rising_edge(clk);

    rand_0 <= resize(rand_0 * unsigned'(X"41c64e6d") + unsigned'(X"3039"), 32);
    rand_1 <= resize(rand_1 * unsigned'(X"41c64e6d") + unsigned'(X"3039"), 32);
    rand_2 <= resize(rand_2 * unsigned'(X"41c64e6d") + unsigned'(X"3039"), 32);
    rand_3 <= resize(rand_3 * unsigned'(X"41c64e6d") + unsigned'(X"3039"), 32);
    rand_4 <= resize(rand_4 * unsigned'(X"41c64e6d") + unsigned'(X"3039"), 32);
    rand_5 <= resize(rand_5 * unsigned'(X"41c64e6d") + unsigned'(X"3039"), 32);
    rand_6 <= resize(rand_6 * unsigned'(X"41c64e6d") + unsigned'(X"3039"), 32);
    rand_7 <= resize(rand_7 * unsigned'(X"41c64e6d") + unsigned'(X"3039"), 32);

    dithered_0 <= to_std(signed(input_0) > signed(rand_0(width-1 downto 0)));
    dithered_1 <= to_std(signed(input_1) > signed(rand_1(width-1 downto 0)));
    dithered_2 <= to_std(signed(input_2) > signed(rand_2(width-1 downto 0)));
    dithered_3 <= to_std(signed(input_3) > signed(rand_3(width-1 downto 0)));
    dithered_4 <= to_std(signed(input_4) > signed(rand_4(width-1 downto 0)));
    dithered_5 <= to_std(signed(input_5) > signed(rand_5(width-1 downto 0)));
    dithered_6 <= to_std(signed(input_6) > signed(rand_6(width-1 downto 0)));
    dithered_7 <= to_std(signed(input_7) > signed(rand_7(width-1 downto 0)));

    if dithering = '1' then
      dac_0 <= dithered_0;
      dac_1 <= dithered_1;
      dac_2 <= dithered_2;
      dac_3 <= dithered_3;
      dac_4 <= dithered_4;
      dac_5 <= dithered_5;
      dac_6 <= dithered_6;
      dac_7 <= dithered_7;
    else
      dac_0 <= input_0(width -1);
      dac_1 <= input_1(width -1);
      dac_2 <= input_2(width -1);
      dac_3 <= input_3(width -1);
      dac_4 <= input_4(width -1);
      dac_5 <= input_5(width -1);
      dac_6 <= input_6(width -1);
      dac_7 <= input_7(width -1);
    end if;

  end process;

  serdes_inst_1 : serdes port map(
      clk => clk,
      rst => rst,
      input_0 => dac_0,
      input_1 => dac_1,
      input_2 => dac_2,
      input_3 => dac_3,
      input_4 => dac_4,
      input_5 => dac_5,
      input_6 => dac_6,
      input_7 => dac_7,
      output => output
  );

end rtl;
