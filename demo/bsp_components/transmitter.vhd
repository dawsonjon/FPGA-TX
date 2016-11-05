--input 48.828125 kHz 8 bit audio
--interpolated to 2048 * 8 * 48.828125 = 800 MHz sampling rate 19-bits
--upconverted to lo


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity transmitter is
  port(
    clk : in std_logic;
    rst : in std_logic;
    frequency : in std_logic_vector(31 downto 0);
    frequency_stb : in std_logic;
    frequency_ack : out std_logic;
    control : in std_logic_vector(31 downto 0);
    control_stb : in std_logic;
    control_ack : out std_logic;
    amplitude : in std_logic_vector(31 downto 0);
    amplitude_stb : in std_logic;
    amplitude_ack : out std_logic;
    rf : out std_logic
  );
end entity transmitter;

architecture rtl of transmitter is

  component interpolate is
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
  end component interpolate;

  component nco is
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
  end component nco;

  component dac_interface is
    generic(
      width     : integer
    );
    port(
      clk : in std_logic;
      rst : in std_logic;

      dithering : in std_logic;

      input_0 : in std_logic_vector(width - 1 downto 0);
      input_1 : in std_logic_vector(width - 1 downto 0);
      input_2 : in std_logic_vector(width - 1 downto 0);
      input_3 : in std_logic_vector(width - 1 downto 0);
      input_4 : in std_logic_vector(width - 1 downto 0);
      input_5 : in std_logic_vector(width - 1 downto 0);
      input_6 : in std_logic_vector(width - 1 downto 0);
      input_7 : in std_logic_vector(width - 1 downto 0);

      output : out std_logic
    );
  end component dac_interface;

   signal i_full_rate_0 : std_logic_vector(23 downto 0) := (others => '0');
   signal i_full_rate_1 : std_logic_vector(23 downto 0) := (others => '0');
   signal i_full_rate_2 : std_logic_vector(23 downto 0) := (others => '0');
   signal i_full_rate_3 : std_logic_vector(23 downto 0) := (others => '0');
   signal i_full_rate_4 : std_logic_vector(23 downto 0) := (others => '0');
   signal i_full_rate_5 : std_logic_vector(23 downto 0) := (others => '0');
   signal i_full_rate_6 : std_logic_vector(23 downto 0) := (others => '0');
   signal i_full_rate_7 : std_logic_vector(23 downto 0) := (others => '0');

   signal q_full_rate_0 : std_logic_vector(23 downto 0) := (others => '0');
   signal q_full_rate_1 : std_logic_vector(23 downto 0) := (others => '0');
   signal q_full_rate_2 : std_logic_vector(23 downto 0) := (others => '0');
   signal q_full_rate_3 : std_logic_vector(23 downto 0) := (others => '0');
   signal q_full_rate_4 : std_logic_vector(23 downto 0) := (others => '0');
   signal q_full_rate_5 : std_logic_vector(23 downto 0) := (others => '0');
   signal q_full_rate_6 : std_logic_vector(23 downto 0) := (others => '0');
   signal q_full_rate_7 : std_logic_vector(23 downto 0) := (others => '0');

   signal lo_i_0 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_i_1 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_i_2 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_i_3 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_i_4 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_i_5 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_i_6 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_i_7 : std_logic_vector(9 downto 0) := (others => '0');

   signal lo_q_0 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_q_1 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_q_2 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_q_3 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_q_4 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_q_5 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_q_6 : std_logic_vector(9 downto 0) := (others => '0');
   signal lo_q_7 : std_logic_vector(9 downto 0) := (others => '0');

   signal i_out_0 : signed(33 downto 0) := (others => '0');
   signal i_out_1 : signed(33 downto 0) := (others => '0');
   signal i_out_2 : signed(33 downto 0) := (others => '0');
   signal i_out_3 : signed(33 downto 0) := (others => '0');
   signal i_out_4 : signed(33 downto 0) := (others => '0');
   signal i_out_5 : signed(33 downto 0) := (others => '0');
   signal i_out_6 : signed(33 downto 0) := (others => '0');
   signal i_out_7 : signed(33 downto 0) := (others => '0');

   signal q_out_0 : signed(33 downto 0) := (others => '0');
   signal q_out_1 : signed(33 downto 0) := (others => '0');
   signal q_out_2 : signed(33 downto 0) := (others => '0');
   signal q_out_3 : signed(33 downto 0) := (others => '0');
   signal q_out_4 : signed(33 downto 0) := (others => '0');
   signal q_out_5 : signed(33 downto 0) := (others => '0');
   signal q_out_6 : signed(33 downto 0) := (others => '0');
   signal q_out_7 : signed(33 downto 0) := (others => '0');

   signal out_0 : std_logic_vector(31 downto 0) := (others => '0');
   signal out_1 : std_logic_vector(31 downto 0) := (others => '0');
   signal out_2 : std_logic_vector(31 downto 0) := (others => '0');
   signal out_3 : std_logic_vector(31 downto 0) := (others => '0');
   signal out_4 : std_logic_vector(31 downto 0) := (others => '0');
   signal out_5 : std_logic_vector(31 downto 0) := (others => '0');
   signal out_6 : std_logic_vector(31 downto 0) := (others => '0');
   signal out_7 : std_logic_vector(31 downto 0) := (others => '0');

   signal dithering : std_logic := '0';
   signal frequency_reg : std_logic_vector(31 downto 0) := (others => '0');

begin

  process
  begin
    wait until rising_edge(clk);

    if control_stb = '1' then
      dithering <= control(0);
    end if;

    if frequency_stb = '1' then
      frequency_reg <= frequency;
    end if;

  end process;
  control_ack <= '1';
  frequency_ack <= '1';

  nco_inst_1 : nco generic map(
      width => 10
  ) port map (
      clk => clk,
      rst => rst,

      frequency => frequency_reg,

      lo_i_0 => lo_i_0,
      lo_i_1 => lo_i_1,
      lo_i_2 => lo_i_2,
      lo_i_3 => lo_i_3,
      lo_i_4 => lo_i_4,
      lo_i_5 => lo_i_5,
      lo_i_6 => lo_i_6,
      lo_i_7 => lo_i_7,

      lo_q_0 => lo_q_0,
      lo_q_1 => lo_q_1,
      lo_q_2 => lo_q_2,
      lo_q_3 => lo_q_3,
      lo_q_4 => lo_q_4,
      lo_q_5 => lo_q_5,
      lo_q_6 => lo_q_6,
      lo_q_7 => lo_q_7
  );

  interpolate_inst_1 : interpolate generic map(
      interpolation_factor => 8192,
      output_width => 13 + 3 + 8,
      width => 8
  ) port map (
      clk => clk,
      rst => rst,

      input => amplitude(23 downto 16),
      input_stb => amplitude_stb,
      input_ack => amplitude_ack,

      output_0 => i_full_rate_0,
      output_1 => i_full_rate_1,
      output_2 => i_full_rate_2,
      output_3 => i_full_rate_3,
      output_4 => i_full_rate_4,
      output_5 => i_full_rate_5,
      output_6 => i_full_rate_6,
      output_7 => i_full_rate_7
  );

  interpolate_inst_2 : interpolate generic map(
      interpolation_factor => 8192,
      output_width => 13 + 3 + 8,
      width => 8
  ) port map (
      clk => clk,
      rst => rst,

      input => amplitude(7 downto 0),
      input_stb => amplitude_stb,
      input_ack => open,

      output_0 => q_full_rate_0,
      output_1 => q_full_rate_1,
      output_2 => q_full_rate_2,
      output_3 => q_full_rate_3,
      output_4 => q_full_rate_4,
      output_5 => q_full_rate_5,
      output_6 => q_full_rate_6,
      output_7 => q_full_rate_7
  );

  process
    variable temp_0 : signed(34 downto 0);
    variable temp_1 : signed(34 downto 0);
    variable temp_2 : signed(34 downto 0);
    variable temp_3 : signed(34 downto 0);
    variable temp_4 : signed(34 downto 0);
    variable temp_5 : signed(34 downto 0);
    variable temp_6 : signed(34 downto 0);
    variable temp_7 : signed(34 downto 0);
  begin
    wait until rising_edge(clk);

    i_out_0 <= signed(i_full_rate_0) * signed(lo_i_0); 
    i_out_1 <= signed(i_full_rate_1) * signed(lo_i_1); 
    i_out_2 <= signed(i_full_rate_2) * signed(lo_i_2); 
    i_out_3 <= signed(i_full_rate_3) * signed(lo_i_3); 
    i_out_4 <= signed(i_full_rate_4) * signed(lo_i_4); 
    i_out_5 <= signed(i_full_rate_5) * signed(lo_i_5); 
    i_out_6 <= signed(i_full_rate_6) * signed(lo_i_6); 
    i_out_7 <= signed(i_full_rate_7) * signed(lo_i_7); 

    q_out_0 <= signed(q_full_rate_0) * signed(lo_q_0); 
    q_out_1 <= signed(q_full_rate_1) * signed(lo_q_1); 
    q_out_2 <= signed(q_full_rate_2) * signed(lo_q_2); 
    q_out_3 <= signed(q_full_rate_3) * signed(lo_q_3); 
    q_out_4 <= signed(q_full_rate_4) * signed(lo_q_4); 
    q_out_5 <= signed(q_full_rate_5) * signed(lo_q_5); 
    q_out_6 <= signed(q_full_rate_6) * signed(lo_q_6); 
    q_out_7 <= signed(q_full_rate_7) * signed(lo_q_7); 

    temp_0 := resize(i_out_0, 35) + q_out_0; 
    temp_1 := resize(i_out_1, 35) + q_out_1; 
    temp_2 := resize(i_out_2, 35) + q_out_2; 
    temp_3 := resize(i_out_3, 35) + q_out_3; 
    temp_4 := resize(i_out_4, 35) + q_out_4; 
    temp_5 := resize(i_out_5, 35) + q_out_5; 
    temp_6 := resize(i_out_6, 35) + q_out_6; 
    temp_7 := resize(i_out_7, 35) + q_out_7; 

    out_0 <= std_logic_vector(temp_0(32 downto 1)); 
    out_1 <= std_logic_vector(temp_1(32 downto 1)); 
    out_2 <= std_logic_vector(temp_2(32 downto 1)); 
    out_3 <= std_logic_vector(temp_3(32 downto 1)); 
    out_4 <= std_logic_vector(temp_4(32 downto 1)); 
    out_5 <= std_logic_vector(temp_5(32 downto 1)); 
    out_6 <= std_logic_vector(temp_6(32 downto 1)); 
    out_7 <= std_logic_vector(temp_7(32 downto 1)); 

  end process;

  dac_interface_inst_1 : dac_interface generic map(
      width => 32
  ) port map (
      clk => clk,
      rst => rst,

      dithering => dithering,
      input_0 => out_0,
      input_1 => out_1,
      input_2 => out_2,
      input_3 => out_3,
      input_4 => out_4,
      input_5 => out_5,
      input_6 => out_6,
      input_7 => out_7,

      output => rf
  );

end rtl;
