library ieee;
use ieee.std_logic_1164.all;

entity fifo is
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
end entity fifo;

architecture rtl of fifo is
  signal s_output_stb, s_input_ack, full, empty, read, write : std_logic;
  signal a_out, a_in : integer range 0 to depth - 1 := 0;
  type memory_type is array (0 to depth - 1) of std_logic_vector(width -1 downto 0);
  signal memory : memory_type;
begin

  process
  begin
    wait until rising_edge(clk);
    if write = '1' then
      memory(a_in) <= input;
    end if;
    if read = '1' then
      output <= memory(a_out);
    end if;
  end process;

  process
  begin
    wait until rising_edge(clk);

    s_output_stb <= '0';
    if read = '1' then
      --data is available on clock following read
      s_output_stb <= '1';
      if a_out = (depth - 1) then
        a_out <= 0;
      else
        a_out <= a_out + 1;
      end if;
    end if;

    --if data has not been read, extend strobe
    if s_output_stb = '1' and output_ack = '0' then
      s_output_stb <= '1';
    end if;

    if write = '1' then
      if a_in = (depth - 1) then
        a_in <= 0;
      else
        a_in <= a_in + 1;
      end if;
    end if;

    if rst = '1' then
      a_out <= 0;
      a_in <= 0;
      s_output_stb <= '0';
    end if;

  end process;

  full <= '1' when (a_out-1) = a_in else
          '1' when (a_out = 0) and (a_in = depth - 1) else
          '0';
  empty <= '1' when a_out = a_in else '0';

  s_input_ack <= not full;
  output_stb <= s_output_stb;
  input_ack <= s_input_ack;

  write <= s_input_ack and input_stb;
  read  <= ((not s_output_stb) or output_ack) and (not empty);


end rtl;

