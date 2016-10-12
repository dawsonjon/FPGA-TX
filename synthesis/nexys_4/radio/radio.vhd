library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library UNISIM;
use UNISIM.vcomponents.all;

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

  signal rf_0 : std_logic;
  signal rf_1 : std_logic;
  signal rf_0_d1 : std_logic;
  signal rf_0_d2 : std_logic;
  signal rf_1_d1 : std_logic;
  signal rf_1_d2 : std_logic;
  signal s_audio_stb : std_logic;
  signal rect_stb : std_logic;
  signal magnitude_stb : std_logic;
  signal lo_i_0 : signed(9 downto 0) := (others => '0');
  signal lo_q_0 : signed(9 downto 0) := (others => '0');
  signal lo_i_1 : signed(9 downto 0) := (others => '0');
  signal lo_q_1 : signed(9 downto 0) := (others => '0');
  signal i_0 : signed(11 downto 0);
  signal i_1 : signed(11 downto 0);
  signal q_0 : signed(11 downto 0);
  signal q_1 : signed(11 downto 0);
  signal i : signed(11 downto 0);
  signal q : signed(11 downto 0);
  signal rf_0_signed : signed(1 downto 0);
  signal rf_1_signed : signed(1 downto 0);
  signal t : unsigned(31 downto 0) := (others => '0');
  signal t_0 : unsigned(31 downto 0) := (others => '0');
  signal t_1 : unsigned(31 downto 0) := (others => '0');
  signal wt_0 : unsigned(63 downto 0) := (others => '0');
  signal wt_1 : unsigned(63 downto 0) := (others => '0');
  signal frequency_reg  : unsigned(31 downto 0) := (others => '0');
  signal average_i : std_logic_vector(30 downto 0) := (others => '0');
  signal average_q : std_logic_vector(30 downto 0) := (others => '0');
  signal rect_i : std_logic_vector(30 downto 0) := (others => '0');
  signal rect_q : std_logic_vector(30 downto 0) := (others => '0');
  signal magnitude : std_logic_vector(31 downto 0) := (others => '0');
  signal phase : std_logic_vector(31 downto 0) := (others => '0');
  signal average_samples_reg : unsigned(31 downto 0) := (others => '0');
  signal sample_count : unsigned(31 downto 0) := (others => '0');

begin

  process
  begin

    wait until rising_edge(clk);

    rf_0_d1 <= rf_0;
    rf_0_d2 <= rf_0_d1;
    rf_1_d1 <= rf_1;
    rf_1_d2 <= rf_1_d1;

    rf_0_signed <= rf_0_d2 & '1';
    rf_1_signed <= rf_1_d2 & '1';

    t <= t + 1;
    t_0 <= t(30 downto 0) & '0';
    t_1 <= t(30 downto 0) & '1';
    wt_0 <= t_0 * frequency_reg;
    wt_1 <= t_1 * frequency_reg;
    lo_i_0 <= sin_array(to_integer(unsigned(wt_0(31 downto 22))));
    lo_q_0 <= cos_array(to_integer(unsigned(wt_0(31 downto 22))));
    lo_i_1 <= sin_array(to_integer(unsigned(wt_1(31 downto 22))));
    lo_q_1 <= cos_array(to_integer(unsigned(wt_1(31 downto 22))));
    i_0 <= rf_0_signed * lo_i_0;
    q_0 <= rf_0_signed * lo_q_0;
    i_1 <= rf_1_signed * lo_i_1;
    q_1 <= rf_1_signed * lo_q_1;
    i <= i_0 + i_1;
    q <= q_0 + q_1;

    if sample_count = average_samples_reg - 1 then
      average_i <= (others => '0');
      average_q <= (others => '0');
      sample_count <= (others => '0');
      rect_i <= average_i;
      rect_q <= average_q;
      rect_stb <= '1';
    else
      average_i <= std_logic_vector(signed(average_i) + i);
      average_q <= std_logic_vector(signed(average_q) + q);
      sample_count <= sample_count + 1;
      rect_stb <= '0';
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
      stb_in => rect_stb,
      stb_out => magnitude_stb,
      i => rect_i,
      q => rect_q,
      phase => phase,
      magnitude => magnitude
  );

  audio_stb <= s_audio_stb;
  frequency_ack <= '1';
  average_samples_ack <= '1';
  lo_out <= '0';
  mixer_out <= '0';

  IDDR_inst : IDDR
  generic map (
    DDR_CLK_EDGE => "SAME_EDGE_PIPELINED", -- "OPPOSITE_EDGE", "SAME_EDGE"
    INIT_Q1 => '0',
    INIT_Q2 => '0',
    SRTYPE => "SYNC")
  port map (
    Q1 => rf_1,
    Q2 => rf_0, --Q2 is earlier in time
    C => clk, -- 1-bit clock input
    CE => '1', -- 1-bit clock enable input
    D => rf, -- 1-bit DDR data input
    R => '0', -- 1-bit reset
    S => '0' -- 1-bit set
 );

end rtl;
