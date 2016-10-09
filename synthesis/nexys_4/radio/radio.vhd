library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity radio is
  port(
    clk : in std_logic;
    rst : in std_logic;
    
    rf : in std_logic;
    lo_out : out std_logic;
    mixer_out : out std_logic;

    --Frequency control input
    frequency : in std_logic_vector(31 downto 0);
    frequency_stb : in std_logic;
    frequency_ack : out std_logic;

    --Average samples
    average_samples : in std_logic_vector(31 downto 0);
    average_samples_stb : in std_logic;
    average_samples_ack : out std_logic;

    --Audio output
    audio : out std_logic_vector(31 downto 0);
    audio_stb : out std_logic;
    audio_ack : in std_logic
  );
end entity radio;

architecture rtl of radio is

  type sin_array_type is array (0 to 1023) of signed(9 downto 0);

  function initialise_sin_array return sin_array_type is
    variable x : sin_array_type;
  begin
    for i in 0 to 1023 loop
      x(i) := to_signed(integer(round(512.0 * sin(real(i) * ((2.0 * math_pi)/1024.0)))), 10);
    end loop;
    return x;
  end function;

  function initialise_cos_array return sin_array_type is
    variable x : sin_array_type;
  begin
    for i in 0 to 1023 loop
      x(i) := to_signed(integer(round(512.0 * cos(real(i) * ((2.0 * math_pi)/1024.0)))), 10);
    end loop;
    return x;
  end function;

  component rectangular_to_polar is
    generic(
      width : integer
    );
    port(
      clk : in std_logic;
      rst : in std_logic;
      stb_in : in std_logic;
      stb_out : out std_logic;
      i   : in std_logic_vector(width-1 downto 0);
      q   : in std_logic_vector(width-1 downto 0);
      phase : out std_logic_vector(width downto 0);
      magnitude : out std_logic_vector(width downto 0)
    );
  end component rectangular_to_polar;

  constant sin_array : sin_array_type := initialise_sin_array;
  constant cos_array : sin_array_type := initialise_cos_array;

  signal rf_d1 : std_logic;
  signal rf_d2 : std_logic;
  signal s_audio_stb : std_logic;
  signal average_stb : std_logic;
  signal magnitude_stb : std_logic;
  signal lo_i : signed(9 downto 0) := (others => '0');
  signal lo_q : signed(9 downto 0) := (others => '0');
  signal i : signed(11 downto 0);
  signal q : signed(11 downto 0);
  signal rf_signed : signed(1 downto 0);
  signal t : unsigned(31 downto 0) := (others => '0');
  signal wt : unsigned(63 downto 0) := (others => '0');
  signal frequency_reg  : unsigned(31 downto 0) := (others => '0');
  signal average_i : std_logic_vector(30 downto 0) := (others => '0');
  signal average_q : std_logic_vector(30 downto 0) := (others => '0');
  signal magnitude : std_logic_vector(31 downto 0) := (others => '0');
  signal phase : std_logic_vector(31 downto 0) := (others => '0');
  signal average_samples_reg : unsigned(31 downto 0) := (others => '0');
  signal sample_count : unsigned(31 downto 0) := (others => '0');

begin

  process
  begin

    wait until rising_edge(clk);

    rf_d1 <= rf;
    rf_d2 <= rf_d1;
    rf_signed <= rf_d2 & '1';

    t <= t + 1;
    wt <= t * frequency_reg;
    lo_i <= sin_array(to_integer(unsigned(wt(31 downto 22))));
    lo_q <= cos_array(to_integer(unsigned(wt(31 downto 22))));
    i <= rf_signed * lo_i;
    q <= rf_signed * lo_q;

    if sample_count = average_samples_reg - 1 then
      average_i <= (others => '0');
      average_q <= (others => '0');
      sample_count <= (others => '0');
      average_stb <= '1';
    else
      average_i <= std_logic_vector(signed(average_i) + i);
      average_q <= std_logic_vector(signed(average_q) + q);
      sample_count <= sample_count + 1;
      average_stb <= '0';
    end if;

    if frequency_stb = '1' then
      frequency_reg <= unsigned(frequency);
    end if;

    if average_samples_stb = '1' then
      average_samples_reg <= unsigned(average_samples);
    end if;

    if magnitude_stb = '1' then
      s_audio_stb <= '1';
      audio <= magnitude;
    end if;

    if s_audio_stb = '1' and audio_ack = '1' then
      s_audio_stb <= '0';
    end if;

    if rst = '1' then
      s_audio_stb <= '0';
    end if;

  end process;

  rectangular_to_polar_inst_1 : rectangular_to_polar generic map(
      width => 31
  ) port map(
      clk => clk,
      rst => rst,
      stb_in => average_stb,
      stb_out => magnitude_stb,
      i => average_i,
      q => average_q,
      phase => phase,
      magnitude => magnitude
  );

  audio_stb <= s_audio_stb;
  frequency_ack <= '1';
  average_samples_ack <= '1';
  lo_out <= '0';
  mixer_out <= '0';

end rtl;
