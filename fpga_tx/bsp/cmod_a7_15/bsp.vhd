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
   ld1                   : out std_logic;

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
  signal clkfb             : std_logic;
  signal clkfbout          : std_logic;
  signal clk100            : std_logic;
  signal locked_internal   : std_logic;
  signal not_locked        : std_logic;
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

  ld1 <= '1';

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




  -- input buffering
  --------------------------------------
  clkin1_buf : ibufg
  port map
   (o  => clkin1,
    i  => clk_in);

   mmcme2_base_inst : mmcme2_base
   generic map (
     bandwidth => "optimized", -- jitter programming (optimized, high, low)
     clkfbout_mult_f => 50.0, -- multiply value for all clkout (2.000-64.000).
     clkfbout_phase => 0.0, -- phase offset in degrees of clkfb (-360.000-360.000).
     clkin1_period => 83.333, -- input clock period in ns to ps resolution (i.e. 33.333 is 30 mhz).
                              -- clkout0_divide - clkout6_divide: divide amount for each clkout (1-128)
     clkout1_divide => 1,
     clkout2_divide => 1,
     clkout3_divide => 1,
     clkout4_divide => 1,
     clkout5_divide => 1,
     clkout6_divide => 1,
     clkout0_divide_f => 6.0, -- divide amount for clkout0 (1.000-128.000).
                              -- clkout0_duty_cycle - clkout6_duty_cycle: duty cycle for each clkout (0.01-0.99).
     clkout0_duty_cycle => 0.5,
     clkout1_duty_cycle => 0.5,
     clkout2_duty_cycle => 0.5,
     clkout3_duty_cycle => 0.5,
     clkout4_duty_cycle => 0.5,
     clkout5_duty_cycle => 0.5,
     clkout6_duty_cycle => 0.5,
    -- clkout0_phase - clkout6_phase: phase offset for each clkout (-360.000-360.000).
     clkout0_phase => 0.0,
     clkout1_phase => 0.0,
     clkout2_phase => 0.0,
     clkout3_phase => 0.0,
     clkout4_phase => 0.0,
     clkout5_phase => 0.0,
     clkout6_phase => 0.0,
     clkout4_cascade => false, -- cascade clkout4 counter with clkout6 (false, true)
     divclk_divide => 1, -- master division value (1-106)
     ref_jitter1 => 0.0, -- reference input jitter in ui (0.000-0.999).
     startup_wait => false -- delays done until mmcm is locked (false, true)
   )
   port map (
     clkout0 => clk100, -- 1-bit output: clkout0
     clkout0b => open, -- 1-bit output: inverted clkout0
     clkout1 => open, -- 1-bit output: clkout1
     clkout1b => open, -- 1-bit output: inverted clkout1
     clkout2 => open, -- 1-bit output: clkout2
     clkout2b => open, -- 1-bit output: inverted clkout2
     clkout3 => open, -- 1-bit output: clkout3
     clkout3b => open, -- 1-bit output: inverted clkout3
     clkout4 => open, -- 1-bit output: clkout4
     clkout5 => open, -- 1-bit output: clkout5
     clkout6 => open, -- 1-bit output: clkout6
     -- feedback clocks: 1-bit (each) output: clock feedback ports
     clkfbout => clkfbout, -- 1-bit output: feedback clock
     clkfboutb => open, -- 1-bit output: inverted clkfbout
     -- status ports: 1-bit (each) output: mmcm status ports
     locked => locked_internal, -- 1-bit output: lock
     -- clock inputs: 1-bit (each) input: clock input
     clkin1 => clkin1, -- 1-bit input: clock
     -- control ports: 1-bit (each) input: mmcm control ports
     pwrdwn => '0', -- 1-bit input: power-down
     rst => rst, -- 1-bit input: reset
     -- feedback clocks: 1-bit (each) input: clock feedback ports
     clkfbin => clkfb -- 1-bit input: feedback clock
   );

  process
  begin
    wait until rising_edge(clk);
    not_locked <= not locked_internal;
    internal_rst <= not_locked;
  end process;

  -- output buffering
  -------------------------------------
  bufg_inst2 : bufg
  port map
   (o   => clkfb,
    i   => clkfbout);

  bufg_inst3 : bufg
  port map
   (o   => clk,
    i   => clk100);

end architecture rtl;
