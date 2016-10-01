library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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

  signal rf_d1 : std_logic;
  signal rf_d2 : std_logic;
  signal s_audio_stb : std_logic;
  signal lo : std_logic;
  signal lo_times_rf : std_logic;
  signal t : unsigned(31 downto 0) := (others => '0');
  signal wt : unsigned(31 downto 0) := (others => '0');
  signal frequency_reg  : unsigned(31 downto 0) := (others => '0');
  signal average_samples : unsigned(31 downto 0) := (others => '0');
  signal average_samples_reg : unsigned(31 downto 0) := (others => '0');
  signal sample_count : unsigned(31 downto 0) := (others => '0');

begin

  process
  begin

    wait until rising_edge(clk);

    rf_d1 <= rf;
    rf_d2 <= rf_d1;

    t <= t + 1;
    wt <= t * frequency_reg;
    lo <= wt(31);
    lo_times_rf <= rf_d1 xor lo;
    
    if sample_count = average_samples_reg - 1 then
      average <= (others => '0');
      audio <= average;
      s_audio_stb <= '1';
      sample_count <= 0;
    else
      average <= average + lo_times_rf;
      sample_count <= sample_count + 1;
    end if;

    if frequency_stb = '1' then
      frequency_reg <= unsigned(frequency);
    end if;

    if average_samples_stb = '1' then
      average_samples_reg <= unsigned(average_samples);
    end if;

    if s_audio_stb = '1' and audio_ack = '1' then
      s_audio_stb <= '0';
    end if;

    if rst = '1' then
      s_audio_stb <= '0';
    end if;

  end process;

  audio_stb <= s_audio_stb;
  frequency_ack <= '1';
  average_samples_ack <= '1';
  lo_out <= lo;
  mixer_out <= lo_times_rf;

end rtl;
