-------------------------------------------------------------------------------
---
---  FPGA TX - FPGA Based Radio Transmitter
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
---           +-------------+               
---           | USER DESIGN |
---           +-------------+
---           |             |
---           |             >-------> RF OUT
---           |             |
---           |             |     +--------------+
---           |             |     | UART         |
---           |             |     +--------------+
---           |             >----->              >-----> RS232-TX
---           |             |     |              |
---           |             |     |              <-------< RS232-RX
---           +-------------+     +--------------+          

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity bsp is
  port(
   clk_in                : in std_logic;       
   rst                   : in std_logic;       

   rf_out                : out std_logic;

   leds                  : out std_logic_vector(7 downto 0);

   gps_tx                : in  std_logic;
   gps_rx                : out std_logic;
   pps                   : in  std_logic;
   tx_rx                 : out std_logic;
   tx_pa                 : out std_logic;

   --rs232 interface
   rs232_rx              : in std_logic;
   rs232_tx              : out std_logic
  );
end entity bsp;

architecture rtl of bsp is

  component transmitter is
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
      rf : out std_logic;
      tx_rx : out std_logic;
      tx_pa : out std_logic
    );
  end component transmitter;

  component user_design is
    port(
      clk : in std_logic;
      rst : in std_logic;
    
      output_tx_freq : out std_logic_vector(31 downto 0);
      output_tx_freq_stb : out std_logic;
      output_tx_freq_ack : in std_logic;

      output_tx_am : out std_logic_vector(31 downto 0);
      output_tx_am_stb : out std_logic;
      output_tx_am_ack : in std_logic;

      output_tx_ctl : out std_logic_vector(31 downto 0);
      output_tx_ctl_stb : out std_logic;
      output_tx_ctl_ack : in std_logic;

      output_leds : out std_logic_vector(31 downto 0);
      output_leds_stb : out std_logic;
      output_leds_ack : in std_logic;

      --gps pps count
      input_gps_count : in std_logic_vector(31 downto 0);
      input_gps_count_stb : in std_logic;
      input_gps_count_ack : out std_logic;

      --gps rx stream
      input_gps_rx : in std_logic_vector(31 downto 0);
      input_gps_rx_stb : in std_logic;
      input_gps_rx_ack : out std_logic;

      --gps tx stream
      output_gps_tx : out std_logic_vector(31 downto 0);
      output_gps_tx_stb : out std_logic;
      output_gps_tx_ack : in std_logic;

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

  component gps_pps
    port(
      clk : in std_logic;
      pps : in std_logic;
      pps_count : out std_logic_vector(31 downto 0);
      pps_count_stb : out std_logic;
      pps_count_ack : in std_logic);
  end component gps_pps;


  --clock tree signals
  signal clk               : std_logic;
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

  --tx interface
  signal output_tx_freq : std_logic_vector(31 downto 0);
  signal output_tx_freq_stb : std_logic;
  signal output_tx_freq_ack : std_logic;
  signal output_tx_am : std_logic_vector(31 downto 0);
  signal output_tx_am_stb : std_logic;
  signal output_tx_am_ack : std_logic;
  signal output_tx_ctl : std_logic_vector(31 downto 0);
  signal output_tx_ctl_stb : std_logic;
  signal output_tx_ctl_ack : std_logic;

  signal input_gps_count : std_logic_vector(31 downto 0);
  signal input_gps_count_stb : std_logic;
  signal input_gps_count_ack : std_logic;

  --rs232 rx stream
  signal input_rs232_rx : std_logic_vector(31 downto 0);
  signal input_rs232_rx_stb : std_logic;
  signal input_rs232_rx_ack : std_logic;

  --rs232 tx stream
  signal output_rs232_tx : std_logic_vector(31 downto 0);
  signal output_rs232_tx_stb : std_logic;
  signal output_rs232_tx_ack : std_logic;

  --gps rx stream
  signal input_gps_rx : std_logic_vector(31 downto 0);
  signal input_gps_rx_stb : std_logic;
  signal input_gps_rx_ack : std_logic;

  --gps tx stream
  signal output_gps_tx : std_logic_vector(31 downto 0);
  signal output_gps_tx_stb : std_logic;
  signal output_gps_tx_ack : std_logic;

  signal s_test_1 : std_logic := '0';
  signal s_test_2 : std_logic := '0';

  signal output_leds : std_logic_vector(31 downto 0);
  signal output_leds_stb : std_logic;
  signal output_leds_ack : std_logic;

begin

  transmitter_inst_1 :  transmitter port map(
      clk => clk,
      rst => internal_rst,

      frequency => output_tx_freq,
      frequency_stb => output_tx_freq_stb,
      frequency_ack => output_tx_freq_ack,

      control => output_tx_ctl,
      control_stb => output_tx_ctl_stb,
      control_ack => output_tx_ctl_ack,

      amplitude => output_tx_am,
      amplitude_stb => output_tx_am_stb,
      amplitude_ack => output_tx_am_ack,

      tx_rx => tx_rx,
      tx_pa => tx_pa,
      rf => rf_out
  );
  process
  begin
    wait until rising_edge(clk);
    if output_tx_freq_stb = '1' then
      s_test_1 <= not s_test_1;
    end if;
    if output_tx_am_stb = '1' then
      s_test_2 <= not s_test_2;
    end if;
  end process;

  user_design_inst_1 : user_design port map(
      clk => clk,
      rst => internal_rst,
    
      --rs232 rx stream
      input_rs232_rx => input_rs232_rx,
      input_rs232_rx_stb => input_rs232_rx_stb,
      input_rs232_rx_ack => input_rs232_rx_ack,

      --rs232 tx stream
      output_rs232_tx => output_rs232_tx,
      output_rs232_tx_stb => output_rs232_tx_stb,
      output_rs232_tx_ack => output_rs232_tx_ack,

      --gps rx stream
      input_gps_rx => input_gps_rx,
      input_gps_rx_stb => input_gps_rx_stb,
      input_gps_rx_ack => input_gps_rx_ack,

      --gps tx stream
      output_gps_tx => output_gps_tx,
      output_gps_tx_stb => output_gps_tx_stb,
      output_gps_tx_ack => output_gps_tx_ack,

      input_gps_count => input_gps_count,
      input_gps_count_stb => input_gps_count_stb,
      input_gps_count_ack => input_gps_count_ack,

      output_leds => output_leds,
      output_leds_stb => output_leds_stb,
      output_leds_ack => output_leds_ack,

      --transmit interface
      output_tx_freq => output_tx_freq,
      output_tx_freq_stb => output_tx_freq_stb,
      output_tx_freq_ack => output_tx_freq_ack,

      output_tx_am => output_tx_am,
      output_tx_am_stb => output_tx_am_stb,
      output_tx_am_ack => output_tx_am_ack,

      output_tx_ctl => output_tx_ctl,
      output_tx_ctl_stb => output_tx_ctl_stb,
      output_tx_ctl_ack => output_tx_ctl_ack
  );

  pps1 : gps_pps port map(
      clk => clk,
      pps => pps,
      pps_count => input_gps_count,
      pps_count_stb => input_gps_count_stb,
      pps_count_ack => input_gps_count_ack
  );

  serial_output_inst_1 : serial_output generic map(
      clock_frequency => 100000000,
      baud_rate       => 12000000
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
      baud_rate       => 12000000
  ) port map (
      clk      => clk,
      rst      => internal_rst,
      rx       => rs232_rx,
     
      out1     => input_rs232_rx(7 downto 0),
      out1_stb => input_rs232_rx_stb,
      out1_ack => input_rs232_rx_ack
  );

  input_rs232_rx(15 downto 8) <= (others => '0');

  serial_output_inst_2 : serial_output generic map(
      clock_frequency => 100000000,
      baud_rate       => 9600
  )port map(
      clk     => clk,
      rst     => internal_rst,
      tx      => gps_rx,
     
      in1     => output_gps_tx(7 downto 0),
      in1_stb => output_gps_tx_stb,
      in1_ack => output_gps_tx_ack
  );

  serial_input_inst_2 : serial_input generic map(
      clock_frequency => 100000000,
      baud_rate       => 9600
  ) port map (
      clk      => clk,
      rst      => internal_rst,
      rx       => gps_tx,
     
      out1     => input_gps_rx(7 downto 0),
      out1_stb => input_gps_rx_stb,
      out1_ack => input_gps_rx_ack
  );

  input_gps_rx(15 downto 8) <= (others => '0');

  process
  begin
    wait until rising_edge(clk);
    if output_leds_stb = '1' then
      leds <= output_leds(7 downto 0);
    end if;
  end process;
  output_leds_ack <= '1';



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

  process
  begin
    wait until rising_edge(clk);
    not_locked <= not locked_internal;
    internal_rst <= not_locked;
  end process;

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
  

  -- chips clk frequency selection
  -------------------------------------
  --clk <= clk_out1; --50 mhz
  clk <= clk_out2; --100 mhz
  --clk <= clk_out3; --125 mhz
  --clk <= clk_out4; --200 mhz

end architecture rtl;
