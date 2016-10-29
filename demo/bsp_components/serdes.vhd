library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.vcomponents.all;

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

  signal CLK_100 : std_logic;
  signal CLK_100_s : std_logic;
  signal CLK_400 : std_logic;
  signal CLK_400_s : std_logic;
  signal CLK_400_N : std_logic;
  signal CLK_400_N_s : std_logic;
  signal CLKFBIN : std_logic;
  signal CLKFBOUT : std_logic;

begin

  output <= input_7;

  OSERDESE2_inst : OSERDESE2
  generic map (
    DATA_RATE_OQ => "DDR", -- DDR, SDR
    DATA_RATE_TQ => "DDR", -- DDR, BUF, SDR
    DATA_WIDTH => 8, -- Parallel data width (2-8,10,14)
    INIT_OQ => '0', -- Initial value of OQ output (1'b0,1'b1)
    INIT_TQ => '0', -- Initial value of TQ output (1'b0,1'b1)
    SERDES_MODE => "MASTER", -- MASTER, SLAVE
    SRVAL_OQ => '0', -- OQ output value when SR is used (1'b0,1'b1)
    SRVAL_TQ => '0', -- TQ output value when SR is used (1'b0,1'b1)
    TBYTE_CTL => "FALSE", -- Enable tristate byte operation (FALSE, TRUE)
    TBYTE_SRC => "FALSE", -- Tristate byte source (FALSE, TRUE)
    TRISTATE_WIDTH => 1 -- 3-state converter width (1,4)
  )
  port map (
    OFB => open, -- 1-bit output: Feedback path for data
    OQ => open, -- 1-bit output: Data path output
    -- SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
    SHIFTOUT1 => open,
    SHIFTOUT2 => open,
    TBYTEOUT => open, -- 1-bit output: Byte group tristate
    TFB => open, -- 1-bit output: 3-state control
    TQ => open, -- 1-bit output: 3-state control
    CLK => CLK_400, -- 1-bit input: High speed clock
    CLKDIV => CLK_100, -- 1-bit input: Divided clock
    -- D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
    D1 => input_0,
    D2 => input_1,
    D3 => input_2,
    D4 => input_3,
    D5 => input_4,
    D6 => input_5,
    D7 => input_6,
    D8 => input_7,
    OCE => '1', -- 1-bit input: Output data clock enable
    RST => '0', -- 1-bit input: Reset
    -- SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
    SHIFTIN1 => '0',
    SHIFTIN2 => '0',
    -- T1 - T4: 1-bit (each) input: Parallel 3-state inputs
    T1 => '0',
    T2 => '0',
    T3 => '0',
    T4 => '0',
    TBYTEIN => '0', -- 1-bit input: Byte group tristate
    TCE => '1' -- 1-bit input: 3-state clock enable
  );

  PLLE2_BASE_inst : PLLE2_BASE generic map (
    BANDWIDTH => "OPTIMIZED", -- OPTIMIZED, HIGH, LOW
    CLKFBOUT_MULT => 8, -- Multiply value for all CLKOUT, (2-64)
    CLKFBOUT_PHASE => 0.0, -- Phase offset in degrees of CLKFB, (-360.000-360.000).
    CLKIN1_PERIOD => 10.0, -- Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
    -- CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
    CLKOUT0_DIVIDE => 8,
    CLKOUT1_DIVIDE => 2,
    CLKOUT2_DIVIDE => 2,
    CLKOUT3_DIVIDE => 1,
    CLKOUT4_DIVIDE => 1,
    CLKOUT5_DIVIDE => 1,
    -- CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
    CLKOUT0_DUTY_CYCLE => 0.5,
    CLKOUT1_DUTY_CYCLE => 0.5,
    CLKOUT2_DUTY_CYCLE => 0.5,
    CLKOUT3_DUTY_CYCLE => 0.5,
    CLKOUT4_DUTY_CYCLE => 0.5,
    CLKOUT5_DUTY_CYCLE => 0.5,
    -- CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
    CLKOUT0_PHASE => 0.0,
    CLKOUT1_PHASE => 0.0,
    CLKOUT2_PHASE => 180.0,
    CLKOUT3_PHASE => 0.0,
    CLKOUT4_PHASE => 0.0,
    CLKOUT5_PHASE => 0.0,
    DIVCLK_DIVIDE => 1, -- Master division value, (1-56)
    REF_JITTER1 => 0.0, -- Reference input jitter in UI, (0.000-0.999).
    STARTUP_WAIT => "FALSE" -- Delay DONE until PLL Locks, ("TRUE"/"FALSE")
  )
  port map (
    -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
    CLKOUT0 => CLK_100_s,
    CLKOUT1 => CLK_400_s,
    CLKOUT2 => CLK_400_N_s,
    CLKOUT3 => open,
    CLKOUT4 => open,
    CLKOUT5 => open,
    -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
    CLKFBOUT => CLKFBOUT, -- 1-bit output: Feedback clock
    -- Status Port: 1-bit (each) output: PLL status ports
    LOCKED => open, -- 1-bit output: LOCK
    -- Clock Input: 1-bit (each) input: Clock input
    CLKIN1 => CLK, -- 1-bit input: Input clock
    -- Control Ports: 1-bit (each) input: PLL control ports
    PWRDWN => '0', -- 1-bit input: Power-down
    RST => '0', -- 1-bit input: Reset
    -- Feedback Clocks: 1-bit (each) input: Clock feedback ports
    CLKFBIN => CLKFBIN -- 1-bit input: Feedback clock
  );

  BUFG_inst_1 : BUFG
  port map (
  O => CLK_100, -- 1-bit output: Clock output
  I => CLK_100_s -- 1-bit input: Clock input
  );

  BUFG_inst_2 : BUFG
  port map (
  O => CLK_400, -- 1-bit output: Clock output
  I => CLK_400_s -- 1-bit input: Clock input
  );

  BUFG_inst_3 : BUFG
  port map (
  O => CLK_400_N, -- 1-bit output: Clock output
  I => CLK_400_N_s -- 1-bit input: Clock input
  );

  BUFG_inst_4 : BUFG
  port map (
  O => CLKFBIN,
  I => CLKFBOUT
  );

end rtl;
