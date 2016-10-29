library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serdes is
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
end entity serdes;

architecture rtl of serdes is

begin

  process
  begin
    while True loop
      wait until rising_edge(clk);
      output <= input_0;
      wait for 1.25 ns;
      output <= input_1;
      wait for 1.25 ns;
      output <= input_2;
      wait for 1.25 ns;
      output <= input_3;
      wait for 1.25 ns;
      output <= input_4;
      wait for 1.25 ns;
      output <= input_5;
      wait for 1.25 ns;
      output <= input_6;
      wait for 1.25 ns;
      output <= input_7;
      wait for 1.25 ns;
    end loop;
    wait;
  end process;

end rtl;
