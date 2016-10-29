-------------------------------------------------------------------------------
---
---  CHIPS - 2.0 Simple Web App Demo
---
---  :Author: Jonathan P Dawson
---  :Date: 04/04/2014
---  :email: chips@jondawson.org.uk
---  :license: MIT
---  :Copyright: Copyright (C) Jonathan P Dawson 2014
---
--------------------------------------------------------------------------------
---
---           +--------------+
---           | CLOCK TREE   |
---           +--------------+
---           |              >-- CLK1   (50MHz) ---> CLK
--- CLK_IN >-->              |
---           |              >-- CLK2   (100MHz)
---           |              |                     +-------+
---           |              +-- CLK3   (125MHz) ->+ ODDR2 +-->[GTXCLK]
---           |              |                     |       |
---           |              +-- CLK3_N (125MHZ) ->+       |
---           |              |                     +-------+
--- RST >----->              >-- CLK4   (200MHz)
---           |              |
---           |              |
---           |              |  CLK >--+--------+
---           |              |         |        |
---           |              |      +--v-+   +--v-+
---           |              |      |    |   |    |
---           |       LOCKED >------>    >--->    >-------> INTERNAL_RESET
---           |              |      |    |   |    |
---           +--------------+      +----+   +----+
---
---              +-------------+               
---              | USER DESIGN |
---              +-------------+
---              |             |
---              |             <-------< SWITCHES
---              |             |
---              |             >-------> LEDS
---              |             |               
---              |             <-------< BUTTONS
---              |             |
---              |             >-------> SEVEN_SEGMENT_CATHODE
---              |             |
---              |             >-------> SEVEN_SEGMENT_ANNODE
---              |             |
---              |             |     +--------------+
---              |             |     | UART         |
---              |             |     +--------------+
---              |             >----->              >-----> RS232-TX
---              |             |     |              |
---              |             |     |              <-------< RS232-RX
---              +---v-----^---+     +--------------+          
---                  |     |
---                  |     |
---              +---v-----^---+           
---              | ETHERNET    |           
---              | MAC         |           
---              +-------------+           
---              |             +------> [PHY_RESET]           
---              |             |           
---[RXCLK] ----->+             +------> [TXCLK]           
---              |             |           
---              |             |                       
---              |             |           
---  [RXD] ----->+             +------> [TXD]
---              |             |           
--- [RXDV] ----->+             +------> [TXEN]           
---              |             |           
--- [RXER] ----->+             +------> [TXER]           
---              |             |           
---              |             |
---              +-------------+
---

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity bsp is
  port(
   clk_in                : in    std_logic;       
   rst                   : in    std_logic;       

   --phy interface
   eth_clk               : out   std_logic;     
   phy_reset_n           : out   std_logic;       

   rxdv                  : in    std_logic;       
   rxer                  : in    std_logic;       
   rxd                   : in    std_logic_vector(1 downto 0);

   txd                   : out   std_logic_vector(1 downto 0);
   txen                  : out   std_logic;      

   --i2c
   sda                   : inout std_logic;
   scl                   : inout std_logic;

   --ps2 keyboard interface
   kd                    : in  std_logic;
   kc                    : in  std_logic;

   rf_out                : out std_logic;

   --audio interface
   audio                 : out std_logic;
   audio_en              : out std_logic;

   --vga interface
   vga_r                 : out std_logic_vector(3 downto 0);
   vga_g                 : out std_logic_vector(3 downto 0);
   vga_b                 : out std_logic_vector(3 downto 0);
   hsynch                : out std_logic;
   vsynch                : out std_logic;

   --leds
   gpio_leds             : out std_logic_vector(15 downto 0);   
   gpio_switches         : in  std_logic_vector(15 downto 0);   
   gpio_buttons          : in  std_logic_vector(4 downto 0);   

   --rgb led
   led_r_pwm             : out std_logic;
   led_g_pwm             : out std_logic;
   led_b_pwm             : out std_logic;

   seven_segment_cathode : out std_logic_vector(6 downto 0);
   seven_segment_annode  : out std_logic_vector(7 downto 0);

   --rs232 interface
   rs232_rx              : in std_logic;
   rs232_tx              : out std_logic
  );
end entity bsp;

architecture rtl of bsp is

  component rmii_ethernet is
    port(

      clk         : in  std_logic;
      rst         : in  std_logic;

      eth_clk     : in  std_logic;
      phy_reset   : out std_logic; 

      --mii if
      txd         : out std_logic_vector(1 downto 0);
      txer        : out std_logic;
      txen        : out std_logic;

      rxd         : in  std_logic_vector(1 downto 0);
      rxer        : in  std_logic;
      rxdv        : in  std_logic;

      --rx stream
      tx          : in  std_logic_vector(15 downto 0);
      tx_stb      : in  std_logic;
      tx_ack      : out std_logic;

      --rx stream
      rx          : out std_logic_vector(15 downto 0);
      rx_stb      : out std_logic;
      rx_ack      : in  std_logic
    );
  end component rmii_ethernet;

  component transmitter is
    port(
      clk : in std_logic;
      rst : in std_logic;
      frequency : in std_logic_vector(31 downto 0);
      i_input : in std_logic_vector(7 downto 0);
      i_input_stb : in std_logic;
      i_input_ack : out std_logic;
      q_input : in std_logic_vector(7 downto 0);
      q_input_stb : in std_logic;
      q_input_ack : out std_logic;
      rf : out std_logic
    );
  end component transmitter;

  component charsvga is
    port ( 

    clk        : in  std_logic;
    data       : in  std_logic_vector(31 downto 0);
    data_ack   : out std_logic;
    data_stb   : in  std_logic;
    
    --vga interface
    vgaclk     : in  std_logic;
    rst        : in  std_logic;
    r          : out std_logic;
    g          : out std_logic;
    b          : out std_logic;
    hsynch     : out std_logic;
    vsynch     : out std_logic
    );
  end component charsvga;

  component pwm is
    generic(
      max_val : integer := 256;
      clock_divider : integer := 256
    );
    port(
      clk : in std_logic;

      data : in std_logic_vector(31 downto 0);
      data_stb : in std_logic;
      data_ack : out std_logic;

      out_bit : out std_logic
    );
  end component pwm;

  component keyboard is
    port (
    clk      : in  std_logic;
    rst      : in  std_logic;

    data_stb : out std_logic;
    data_ack : in  std_logic;
    data     : out std_logic_vector (31 downto 0);
    
    kd      : in  std_logic;
    kc      : in  std_logic
    );
  end component keyboard;

  component i2c is
    generic(
      clocks_per_second : integer := 100000000;
      speed : integer := 100000
    );
    port(
      clk : in std_logic;
      rst : in std_logic;
 
      sda : inout std_logic;
      scl : inout std_logic;

      i2c_in : in std_logic_vector(31 downto 0);
      i2c_in_stb : in std_logic;
      i2c_in_ack : out std_logic;
 
      i2c_out : out std_logic_vector(31 downto 0);
      i2c_out_stb : out std_logic;
      i2c_out_ack : in std_logic
    );
  end component i2c;

  component user_design is
    port(
      clk : in std_logic;
      rst : in std_logic;
    
      output_leds : out std_logic_vector(31 downto 0);
      output_leds_stb : out std_logic;
      output_leds_ack : in std_logic;

      input_switches : in std_logic_vector(31 downto 0);
      input_switches_stb : in std_logic;
      input_switches_ack : out std_logic;

      input_buttons : in std_logic_vector(31 downto 0);
      input_buttons_stb : in std_logic;
      input_buttons_ack : out std_logic;

      output_vga : out  std_logic_vector(31 downto 0);
      output_vga_ack : in std_logic;
      output_vga_stb : out  std_logic;

      output_audio : out std_logic_vector(31 downto 0);
      output_audio_stb : out std_logic;
      output_audio_ack : in std_logic;

      output_tx_freq : out std_logic_vector(31 downto 0);
      output_tx_freq_stb : out std_logic;
      output_tx_freq_ack : in std_logic;

      output_tx_am : out std_logic_vector(31 downto 0);
      output_tx_am_stb : out std_logic;
      output_tx_am_ack : in std_logic;

      output_led_r : out std_logic_vector(31 downto 0);
      output_led_r_stb : out std_logic;
      output_led_r_ack : in std_logic;
      output_led_g : out std_logic_vector(31 downto 0);
      output_led_g_stb : out std_logic;
      output_led_g_ack : in std_logic;
      output_led_b : out std_logic_vector(31 downto 0);
      output_led_b_stb : out std_logic;
      output_led_b_ack : in std_logic;

      output_seven_segment_cathode : out std_logic_vector(31 downto 0);
      output_seven_segment_cathode_stb : out std_logic;
      output_seven_segment_cathode_ack : in std_logic;

      output_seven_segment_annode : out std_logic_vector(31 downto 0);
      output_seven_segment_annode_stb : out std_logic;
      output_seven_segment_annode_ack : in std_logic;

      input_ps2 : in std_logic_vector(31 downto 0);
      input_ps2_stb : in std_logic;
      input_ps2_ack : out std_logic;

      input_i2c : in std_logic_vector(31 downto 0);
      input_i2c_stb : in std_logic;
      input_i2c_ack : out std_logic;
      output_i2c : out std_logic_vector(31 downto 0);
      output_i2c_stb : out std_logic;
      output_i2c_ack : in std_logic;

      --eth rx stream
      input_eth_rx : in std_logic_vector(31 downto 0);
      input_eth_rx_stb : in std_logic;
      input_eth_rx_ack : out std_logic;

      --eth tx stream
      output_eth_tx : out std_logic_vector(31 downto 0);
      output_eth_tx_stb : out std_logic;
      output_eth_tx_ack : in std_logic;

      --rs232 rx stream
      input_rs232_rx : in std_logic_vector(31 downto 0);
      input_rs232_rx_stb : in std_logic;
      input_rs232_rx_ack : out std_logic;

      --rs232 tx stream
      output_rs232_tx : out std_logic_vector(31 downto 0);
      output_rs232_tx_stb : out std_logic;
      output_rs232_tx_ack : in std_logic


    );
  end component;

  component serial_input is
    generic(
      clock_frequency : integer;
      baud_rate       : integer
    );
    port(
      clk      : in std_logic;
      rst      : in std_logic;
      rx       : in std_logic;
     
      out1     : out std_logic_vector(7 downto 0);
      out1_stb : out std_logic;
      out1_ack : in  std_logic
    );
  end component serial_input;

  component serial_output is
    generic(
      clock_frequency : integer;
      baud_rate       : integer
    );
    port(
      clk     : in std_logic;
      rst     : in  std_logic;
      tx      : out std_logic;
     
      in1     : in std_logic_vector(7 downto 0);
      in1_stb : in std_logic;
      in1_ack : out std_logic
    );
  end component serial_output;

  component pwm_audio is
    generic(
      clock_frequency : integer := 100000000;
      sample_rate : integer := 6104;
      audio_bits : integer := 8
    );
    port(
      clk : in std_logic;
      rst : in std_logic;

      data_in : in std_logic_vector(31 downto 0);
      data_in_stb : in std_logic;
      data_in_ack : out std_logic;

      audio : out std_logic

    );
  end component pwm_audio;

  --chips signals
  signal clk : std_logic;

  --clock tree signals
  signal clkin1            : std_logic;
  -- output clock buffering
  signal clkfb             : std_logic;
  signal clk0              : std_logic;
  signal clk2x             : std_logic;
  signal clkfx             : std_logic;
  signal clkfx180          : std_logic;
  signal clkdv             : std_logic;
  signal clkfbout          : std_logic;
  signal locked_internal   : std_logic;
  signal status_internal   : std_logic_vector(7 downto 0);
  signal clk_out1          : std_logic;
  signal clk_out2          : std_logic;
  signal clk_out3          : std_logic;
  signal clk_out3_n        : std_logic;
  signal clk_out4          : std_logic;
  signal not_locked        : std_logic;
  signal rst_inv           : std_logic;
  signal internal_rst      : std_logic;


  --gpio signals
  signal output_leds : std_logic_vector(31 downto 0);
  signal output_leds_stb : std_logic;
  signal output_leds_ack : std_logic;

  signal input_switches : std_logic_vector(31 downto 0);
  signal input_switches_stb : std_logic;
  signal input_switches_ack : std_logic;
  signal gpio_switches_d : std_logic_vector(15 downto 0);

  signal input_buttons : std_logic_vector(31 downto 0);
  signal input_buttons_stb : std_logic;
  signal input_buttons_ack : std_logic;
  signal gpio_buttons_d : std_logic_vector(4 downto 0);

  --seven segment display stream
  signal output_seven_segment_cathode : std_logic_vector(31 downto 0);
  signal output_seven_segment_cathode_stb : std_logic;
  signal output_seven_segment_cathode_ack : std_logic;
  signal output_seven_segment_annode : std_logic_vector(31 downto 0);
  signal output_seven_segment_annode_stb : std_logic;
  signal output_seven_segment_annode_ack : std_logic;

  --audio
  signal output_audio : std_logic_vector(31 downto 0);
  signal output_audio_stb : std_logic;
  signal output_audio_ack :  std_logic;

  --tx interface
  signal  output_tx_freq : std_logic_vector(31 downto 0);
  signal  output_tx_freq_reg : std_logic_vector(31 downto 0);
  signal  output_tx_freq_stb : std_logic;
  signal  output_tx_freq_ack : std_logic;
  signal  output_tx_am : std_logic_vector(31 downto 0);
  signal  output_tx_am_stb : std_logic;
  signal  output_tx_am_ack : std_logic;

  --interface for svga
  signal vgaclk : std_logic;
  signal vga_rr : std_logic;
  signal vga_gg : std_logic;
  signal vga_bb : std_logic;
  signal output_vga : std_logic_vector(31 downto 0);
  signal output_vga_ack : std_logic;
  signal output_vga_stb : std_logic;

  --ps2 interface for kb/mouse
  signal ps2_stb : std_logic;
  signal ps2_ack : std_logic;
  signal ps2 : std_logic_vector (31 downto 0);

  --i2c interface for temperature monitor
  signal input_i2c : std_logic_vector(31 downto 0);
  signal input_i2c_stb : std_logic;
  signal input_i2c_ack : std_logic;
  signal output_i2c : std_logic_vector(31 downto 0);
  signal output_i2c_stb : std_logic;
  signal output_i2c_ack : std_logic;

  --eth tx stream
  signal eth_tx          : std_logic_vector(31 downto 0);
  signal eth_tx_stb      : std_logic;
  signal eth_tx_ack      : std_logic;
  
  --eth rx stream
  signal eth_rx          : std_logic_vector(31 downto 0);
  signal eth_rx_stb      : std_logic;
  signal eth_rx_ack      : std_logic;

  --rs232 rx stream
  signal input_rs232_rx : std_logic_vector(31 downto 0);
  signal input_rs232_rx_stb : std_logic;
  signal input_rs232_rx_ack : std_logic;

  --rs232 tx stream
  signal output_rs232_tx : std_logic_vector(31 downto 0);
  signal output_rs232_tx_stb : std_logic;
  signal output_rs232_tx_ack : std_logic;

  --tri color led signals
  signal led_r : std_logic_vector(31 downto 0);
  signal led_r_stb : std_logic;
  signal led_r_ack : std_logic;
  signal led_g : std_logic_vector(31 downto 0);
  signal led_g_stb : std_logic;
  signal led_g_ack : std_logic;
  signal led_b : std_logic_vector(31 downto 0);
  signal led_b_stb : std_logic;
  signal led_b_ack : std_logic;

begin


  ethernet_inst_1 : rmii_ethernet port map(
      clk         => clk,
      rst         => internal_rst,

      --gmii if
      eth_clk     => clk_out1,

      txd         => txd,
      txer        => open,
      txen        => txen,

      phy_reset   => phy_reset_n,

      rxd         => rxd,
      rxer        => rxer,
      rxdv        => rxdv,

      --rx stream
      tx          => eth_tx(15 downto 0),
      tx_stb      => eth_tx_stb,
      tx_ack      => eth_tx_ack,

      --rx stream
      rx          => eth_rx(15 downto 0),
      rx_stb      => eth_rx_stb,
      rx_ack      => eth_rx_ack
    );

  charsvga_inst_1 : charsvga port map( 

    clk => clk,
    data => output_vga,
    data_ack => output_vga_ack,
    data_stb => output_vga_stb,
    
    --vga interface
    vgaclk => vgaclk,
    rst => internal_rst,
    r => vga_rr,
    g => vga_gg,
    b => vga_bb,
    hsynch => hsynch,
    vsynch => vsynch
  );

  generate_vga : for i in 0 to 3 generate
    vga_r(i) <= vga_rr;
    vga_g(i) <= vga_gg;
    vga_b(i) <= vga_bb;
  end generate;

  process
  begin
    wait until rising_edge(clk);
    if output_tx_freq_stb = '1' then
      output_tx_freq_reg <= output_tx_freq;
    end if;
  end process;
  output_tx_freq_ack <= '1';

  transmitter_inst_1 :  transmitter port map(
      clk => clk,
      rst => internal_rst,
      frequency => output_tx_freq_reg,
      i_input => output_tx_am(7 downto 0),
      i_input_stb => output_tx_am_stb,
      i_input_ack => output_tx_am_ack,
      q_input => output_tx_am(23 downto 16),
      q_input_stb => output_tx_am_stb,
      q_input_ack => open,
      rf => rf_out
  );

  pwm_audio_inst_1 : pwm_audio 
  generic map(
      clock_frequency => 100000000,
      sample_rate => 12207,
      audio_bits => 10
  ) port map (
      clk => clk,
      rst => internal_rst,

      data_in => output_audio,
      data_in_stb => output_audio_stb,
      data_in_ack => output_audio_ack,

      audio => audio

  );
  audio_en <= '1';

  user_design_inst_1 : user_design port map(
      clk => clk,
      rst => internal_rst,
    
      --gpio interfaces
      output_leds => output_leds,
      output_leds_stb => output_leds_stb,
      output_leds_ack => output_leds_ack,

      input_switches => input_switches,
      input_switches_stb => input_switches_stb,
      input_switches_ack => input_switches_ack,

      input_buttons => input_buttons,
      input_buttons_stb => input_buttons_stb,
      input_buttons_ack => input_buttons_ack,

      --vga interfave
      output_vga => output_vga,
      output_vga_ack => output_vga_ack,
      output_vga_stb => output_vga_stb,

      --tri color led interface
      output_led_r => led_r,
      output_led_r_stb => led_r_stb,
      output_led_r_ack => led_r_ack,
      output_led_g => led_g,
      output_led_g_stb => led_g_stb,
      output_led_g_ack => led_g_ack,
      output_led_b => led_b,
      output_led_b_stb => led_b_stb,
      output_led_b_ack => led_b_ack,

      --rs232 rx stream
      input_rs232_rx => input_rs232_rx,
      input_rs232_rx_stb => input_rs232_rx_stb,
      input_rs232_rx_ack => input_rs232_rx_ack,

      --rs232 tx stream
      output_rs232_tx => output_rs232_tx,
      output_rs232_tx_stb => output_rs232_tx_stb,
      output_rs232_tx_ack => output_rs232_tx_ack,

      --audio out
      output_audio => output_audio,
      output_audio_stb => output_audio_stb,
      output_audio_ack => output_audio_ack,

      --transmit interface
      output_tx_freq     => output_tx_freq,
      output_tx_freq_stb => output_tx_freq_stb,
      output_tx_freq_ack => output_tx_freq_ack,

      output_tx_am       => output_tx_am,
      output_tx_am_stb   => output_tx_am_stb,
      output_tx_am_ack   => output_tx_am_ack,

      --seven segment display interface
      output_seven_segment_cathode => output_seven_segment_cathode,
      output_seven_segment_cathode_stb => output_seven_segment_cathode_stb,
      output_seven_segment_cathode_ack => output_seven_segment_cathode_ack,
      output_seven_segment_annode => output_seven_segment_annode,
      output_seven_segment_annode_stb => output_seven_segment_annode_stb,
      output_seven_segment_annode_ack => output_seven_segment_annode_ack,
     
      --ps2 keyboad interface
      input_ps2_stb => ps2_stb,
      input_ps2_ack => ps2_ack,
      input_ps2 => ps2,

      --i2c interface for temperature monitor
      input_i2c      => output_i2c,
      input_i2c_stb  => output_i2c_stb,
      input_i2c_ack  => output_i2c_ack,
      output_i2c     => input_i2c,
      output_i2c_stb => input_i2c_stb,
      output_i2c_ack => input_i2c_ack,

      --eth rx stream
      input_eth_rx => eth_rx,
      input_eth_rx_stb => eth_rx_stb,
      input_eth_rx_ack => eth_rx_ack,

      --eth tx stream
      output_eth_tx => eth_tx,
      output_eth_tx_stb => eth_tx_stb,
      output_eth_tx_ack => eth_tx_ack

  );

  serial_output_inst_1 : serial_output generic map(
      clock_frequency => 100000000,
      baud_rate       => 115200
  )port map(
      clk     => clk,
      rst     => internal_rst,
      tx      => rs232_tx,
     
      in1     => output_rs232_tx(7 downto 0),
      in1_stb => output_rs232_tx_stb,
      in1_ack => output_rs232_tx_ack
  );

  serial_input_inst_1 : serial_input generic map(
      clock_frequency => 100000000,
      baud_rate       => 115200
  ) port map (
      clk      => clk,
      rst      => internal_rst,
      rx       => rs232_rx,
     
      out1     => input_rs232_rx(7 downto 0),
      out1_stb => input_rs232_rx_stb,
      out1_ack => input_rs232_rx_ack
  );

  input_rs232_rx(15 downto 8) <= (others => '0');

  i2c_inst_1 : i2c generic map(
      clocks_per_second => 100000000,
      speed => 10000
  ) port map (
      clk => clk,
      rst => internal_rst,
 
      sda => sda,
      scl => scl,

      i2c_in => input_i2c,
      i2c_in_stb => input_i2c_stb,
      i2c_in_ack =>input_i2c_ack,
 
      i2c_out => output_i2c,
      i2c_out_stb => output_i2c_stb,
      i2c_out_ack => output_i2c_ack
  );

  pwm_inst_1 : pwm generic map(
      max_val => 255,
      clock_divider => 1000
  ) port map (
      clk => clk,

      data => led_r,
      data_stb => led_r_stb,
      data_ack => led_r_ack,

      out_bit => led_r_pwm
  );

  pwm_inst_2 : pwm generic map(
      max_val => 255,
      clock_divider => 1000
  ) port map (
      clk => clk,

      data => led_g,
      data_stb => led_g_stb,
      data_ack => led_g_ack,

      out_bit => led_g_pwm
  );

  pwm_inst_3 : pwm generic map(
      max_val => 255,
      clock_divider => 1000
  ) port map (
      clk => clk,

      data => led_b,
      data_stb => led_b_stb,
      data_ack => led_b_ack,

      out_bit => led_b_pwm
  );

  keyboard_inst1 : keyboard port map(
    clk => clk,
    rst => internal_rst,

    data_stb => ps2_stb,
    data_ack => ps2_ack,
    data => ps2,
    
    kd => kd,
    kc => kc
  );

  process
  begin
    wait until rising_edge(clk);
    not_locked <= not locked_internal;
    internal_rst <= not_locked;
   
    if output_leds_stb = '1' then
       gpio_leds <= output_leds(15 downto 0);
    end if;
    output_leds_ack <= '1';

    if output_seven_segment_annode_stb = '1' then
       seven_segment_annode <= not output_seven_segment_annode(7 downto 0);
    end if;
    output_seven_segment_annode_ack <= '1';

    if output_seven_segment_cathode_stb = '1' then
       seven_segment_cathode <= not output_seven_segment_cathode(6 downto 0);
    end if;
    output_seven_segment_cathode_ack <= '1';

    input_switches_stb <= '1';
    gpio_switches_d <= gpio_switches;
    input_switches <= (others => '0');
    input_switches(15 downto 0) <= gpio_switches_d;

    input_buttons_stb <= '1';
    gpio_buttons_d <= gpio_buttons;
    input_buttons <= (others => '0');
    input_buttons(4 downto 0) <= gpio_buttons_d;

  end process;


  -------------------------
  -- output     output     
  -- clock     freq (mhz)  
  -------------------------
  -- clk_out1    50.000    
  -- clk_out2   100.000    
  -- clk_out3   125.000    
  -- clk_out4   200.000    

  ----------------------------------
  -- input clock   input freq (mhz) 
  ----------------------------------
  -- primary         100.000        


  -- input buffering
  --------------------------------------
  clkin1_buf : ibufg
  port map
   (o  => clkin1,
    i  => clk_in);


  -- clocking primitive
  --------------------------------------
  -- instantiation of the dcm primitive
  --    * unused inputs are tied off
  --    * unused outputs are labeled unused
  dcm_sp_inst: dcm_sp
  generic map
   (clkdv_divide          => 2.000,
    clkfx_divide          => 4,
    clkfx_multiply        => 5,
    clkin_divide_by_2     => false,
    clkin_period          => 10.0,
    clkout_phase_shift    => "none",
    clk_feedback          => "1x",
    deskew_adjust         => "system_synchronous",
    phase_shift           => 0,
    startup_wait          => false)
  port map
   -- input clock
   (clkin                 => clkin1,
    clkfb                 => clkfb,
    -- output clocks
    clk0                  => clk0,
    clk90                 => open,
    clk180                => open,
    clk270                => open,
    clk2x                 => clk2x,
    clk2x180              => open,
    clkfx                 => clkfx,
    clkfx180              => clkfx180,
    clkdv                 => clkdv,
   -- ports for dynamic phase shift
    psclk                 => '0',
    psen                  => '0',
    psincdec              => '0',
    psdone                => open,
   -- other control and status signals
    locked                => locked_internal,
    status                => status_internal,
    rst                   => rst_inv,
   -- unused pin, tie low
    dssen                 => '0');

  -- output buffering
  -------------------------------------
  clkfb <= clk_out2;

  bufg_inst1 : bufg
  port map
   (o   => clk_out1,
    i   => clkdv);

  bufg_inst2 : bufg
  port map
   (o   => clk_out2,
    i   => clk0);

  bufg_inst3 : bufg
  port map
   (o   => clk_out3,
    i   => clkfx);
  
  bufg_inst4 : bufg
  port map
   (o   => clk_out3_n,
    i   => clkfx180);

  bufg_inst5 : bufg
  port map
   (o   => clk_out4,
    i   => clk2x);
    
  rst_inv <= not rst;
  eth_clk <= clk_out1;
  vgaclk <= clk_out1;
  

  -- chips clk frequency selection
  -------------------------------------
  --clk <= clk_out1; --50 mhz
  clk <= clk_out2; --100 mhz
  --clk <= clk_out3; --125 mhz
  --clk <= clk_out4; --200 mhz

end architecture rtl;
