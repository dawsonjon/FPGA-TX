library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

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

  signal clk_100 : std_logic;
  signal clk_100_s : std_logic;
  signal clk_400 : std_logic;
  signal clk_400_s : std_logic;
  signal clk_400_n : std_logic;
  signal clk_400_n_s : std_logic;
  signal clkfbin : std_logic;
  signal clkfbout : std_logic;

begin


  oserdese2_inst : oserdese2
  generic map (
    data_rate_oq => "ddr", -- ddr, sdr
    data_rate_tq => "sdr", -- ddr, buf, sdr
    data_width => 8, -- parallel data width (2-8,10,14)
    init_oq => '0', -- initial value of oq output (1'b0,1'b1)
    init_tq => '0', -- initial value of tq output (1'b0,1'b1)
    serdes_mode => "master", -- master, slave
    srval_oq => '0', -- oq output value when sr is used (1'b0,1'b1)
    srval_tq => '0', -- tq output value when sr is used (1'b0,1'b1)
    tbyte_ctl => "false", -- enable tristate byte operation (false, true)
    tbyte_src => "false", -- tristate byte source (false, true)
    tristate_width => 1 -- 3-state converter width (1,4)
  )
  port map (
    ofb => open, -- 1-bit output: feedback path for data
    oq => output, -- 1-bit output: data path output
    -- shiftout1 / shiftout2: 1-bit (each) output: data output expansion (1-bit each)
    shiftout1 => open,
    shiftout2 => open,
    tbyteout => open, -- 1-bit output: byte group tristate
    tfb => open, -- 1-bit output: 3-state control
    tq => open, -- 1-bit output: 3-state control
    clk => clk_400, -- 1-bit input: high speed clock
    clkdiv => clk_100, -- 1-bit input: divided clock
    -- d1 - d8: 1-bit (each) input: parallel data inputs (1-bit each)
    d1 => input_0,
    d2 => input_1,
    d3 => input_2,
    d4 => input_3,
    d5 => input_4,
    d6 => input_5,
    d7 => input_6,
    d8 => input_7,
    oce => '1', -- 1-bit input: output data clock enable
    rst => '0', -- 1-bit input: reset
    -- shiftin1 / shiftin2: 1-bit (each) input: data input expansion (1-bit each)
    shiftin1 => '0',
    shiftin2 => '0',
    -- t1 - t4: 1-bit (each) input: parallel 3-state inputs
    t1 => '0',
    t2 => '0',
    t3 => '0',
    t4 => '0',
    tbytein => '0', -- 1-bit input: byte group tristate
    tce => '1' -- 1-bit input: 3-state clock enable
  );

  plle2_base_inst : plle2_base generic map (
    bandwidth => "optimized", -- optimized, high, low
    clkfbout_mult => 8, -- multiply value for all clkout, (2-64)
    clkfbout_phase => 0.0, -- phase offset in degrees of clkfb, (-360.000-360.000).
    clkin1_period => 10.0, -- input clock period in ns to ps resolution (i.e. 33.333 is 30 mhz).
    -- clkout0_divide - clkout5_divide: divide amount for each clkout (1-128)
    clkout0_divide => 8,
    clkout1_divide => 2,
    clkout2_divide => 2,
    clkout3_divide => 1,
    clkout4_divide => 1,
    clkout5_divide => 1,
    -- clkout0_duty_cycle - clkout5_duty_cycle: duty cycle for each clkout (0.001-0.999).
    clkout0_duty_cycle => 0.5,
    clkout1_duty_cycle => 0.5,
    clkout2_duty_cycle => 0.5,
    clkout3_duty_cycle => 0.5,
    clkout4_duty_cycle => 0.5,
    clkout5_duty_cycle => 0.5,
    -- clkout0_phase - clkout5_phase: phase offset for each clkout (-360.000-360.000).
    clkout0_phase => 0.0,
    clkout1_phase => 0.0,
    clkout2_phase => 180.0,
    clkout3_phase => 0.0,
    clkout4_phase => 0.0,
    clkout5_phase => 0.0,
    divclk_divide => 1, -- master division value, (1-56)
    ref_jitter1 => 0.0, -- reference input jitter in ui, (0.000-0.999).
    startup_wait => "false" -- delay done until pll locks, ("true"/"false")
  )
  port map (
    -- clock outputs: 1-bit (each) output: user configurable clock outputs
    clkout0 => clk_100_s,
    clkout1 => clk_400_s,
    clkout2 => clk_400_n_s,
    clkout3 => open,
    clkout4 => open,
    clkout5 => open,
    -- feedback clocks: 1-bit (each) output: clock feedback ports
    clkfbout => clkfbout, -- 1-bit output: feedback clock
    -- status port: 1-bit (each) output: pll status ports
    locked => open, -- 1-bit output: lock
    -- clock input: 1-bit (each) input: clock input
    clkin1 => clk, -- 1-bit input: input clock
    -- control ports: 1-bit (each) input: pll control ports
    pwrdwn => '0', -- 1-bit input: power-down
    rst => '0', -- 1-bit input: reset
    -- feedback clocks: 1-bit (each) input: clock feedback ports
    clkfbin => clkfbin -- 1-bit input: feedback clock
  );

  bufg_inst_1 : bufg
  port map (
  o => clk_100, -- 1-bit output: clock output
  i => clk_100_s -- 1-bit input: clock input
  );

  bufg_inst_2 : bufg
  port map (
  o => clk_400, -- 1-bit output: clock output
  i => clk_400_s -- 1-bit input: clock input
  );

  bufg_inst_3 : bufg
  port map (
  o => clk_400_n, -- 1-bit output: clock output
  i => clk_400_n_s -- 1-bit input: clock input
  );

  bufg_inst_4 : bufg
  port map (
  o => clkfbin,
  i => clkfbout
  );

end rtl;
