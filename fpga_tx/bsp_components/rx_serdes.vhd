library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity rx_serdes is
  port(
    clk : in std_logic;
    rst : in std_logic;

    i_1 : in std_logic;
    i_2 : in std_logic;
    i_3 : in std_logic;
    i_4 : in std_logic;
    i_5 : in std_logic;
    i_6 : in std_logic;
    i_7 : in std_logic;
    i_8 : in std_logic;

    q_1 : in std_logic;
    q_2 : in std_logic;
    q_3 : in std_logic;
    q_4 : in std_logic;
    q_5 : in std_logic;
    q_6 : in std_logic;
    q_7 : in std_logic;
    q_8 : in std_logic;

    i : inout std_logic;
    i_n : inout std_logic;
    q : inout std_logic;
    q_n : inout std_logic

  );
end entity rx_serdes;

architecture rtl of rx_serdes is

  signal clk_100 : std_logic;
  signal clk_100_s : std_logic;
  signal clk_400 : std_logic;
  signal clk_400_s : std_logic;
  signal clk_200 : std_logic;
  signal clk_200_s : std_logic;
  signal clk_400_n : std_logic;
  signal clk_400_n_s : std_logic;
  signal clkfbin : std_logic;
  signal clkfbout : std_logic;

  signal hi_nibble : std_logic := '0';

  signal fast_i_1 : std_logic;
  signal fast_i_2 : std_logic;
  signal fast_i_3 : std_logic;
  signal fast_i_4 : std_logic;
  signal fast_i_n_1 : std_logic;
  signal fast_i_n_2 : std_logic;
  signal fast_i_n_3 : std_logic;
  signal fast_i_n_4 : std_logic;
  signal fast_q_1 : std_logic;
  signal fast_q_2 : std_logic;
  signal fast_q_3 : std_logic;
  signal fast_q_4 : std_logic;
  signal fast_q_n_1 : std_logic;
  signal fast_q_n_2 : std_logic;
  signal fast_q_n_3 : std_logic;
  signal fast_q_n_4 : std_logic;

  signal i_s : std_logic;
  signal q_s : std_logic;
  signal i_n_s : std_logic;
  signal q_n_s : std_logic;

begin

  process
  begin

    wait until rising_edge(clk_200);

    hi_nibble <= not hi_nibble;
    if hi_nibble = '1' then
      fast_i_1 <= i_1;
      fast_i_2 <= i_2;
      fast_i_3 <= i_3;
      fast_i_4 <= i_4;
      fast_i_n_1 <= not i_1;
      fast_i_n_2 <= not i_2;
      fast_i_n_3 <= not i_3;
      fast_i_n_4 <= not i_4;
      fast_q_1 <= q_1;
      fast_q_2 <= q_2;
      fast_q_3 <= q_3;
      fast_q_4 <= q_4;
      fast_q_n_1 <= not q_1;
      fast_q_n_2 <= not q_2;
      fast_q_n_3 <= not q_3;
      fast_q_n_4 <= not q_4;
    else
      fast_i_1 <= i_5;
      fast_i_2 <= i_6;
      fast_i_3 <= i_7;
      fast_i_4 <= i_8;
      fast_i_n_1 <= not i_5;
      fast_i_n_2 <= not i_6;
      fast_i_n_3 <= not i_7;
      fast_i_n_4 <= not i_8;
      fast_q_1 <= q_5;
      fast_q_2 <= q_6;
      fast_q_3 <= q_7;
      fast_q_4 <= q_8;
      fast_q_n_1 <= not q_5;
      fast_q_n_2 <= not q_6;
      fast_q_n_3 <= not q_7;
      fast_q_n_4 <= not q_8;
    end if;
    if rst_n = '1' then
      hi_nibble <= '0';
    end if;
  end process;

  oserdese2_i_inst : oserdese2
  generic map (
    data_rate_oq => "ddr", -- ddr, sdr
    data_rate_tq => "sdr", -- ddr, buf, sdr
    data_width => 4, -- parallel data width (2-8,10,14)
    init_oq => '0', -- initial value of oq output (1'b0,1'b1)
    init_tq => '0', -- initial value of tq output (1'b0,1'b1)
    serdes_mode => "master", -- master, slave
    srval_oq => '0', -- oq output value when sr is used (1'b0,1'b1)
    srval_tq => '0', -- tq output value when sr is used (1'b0,1'b1)
    tbyte_ctl => "false", -- enable tristate byte operation (false, true)
    tbyte_src => "false", -- tristate byte source (false, true)
    tristate_width => 4 -- 3-state converter width (1,4)
  )
  port map (
    ofb => open, -- 1-bit output: feedback path for data
    oq => open, -- 1-bit output: data path output
    -- shiftout1 / shiftout2: 1-bit (each) output: data output expansion (1-bit each)
    shiftout1 => open,
    shiftout2 => open,
    tbyteout => open, -- 1-bit output: byte group tristate
    tfb => open, -- 1-bit output: 3-state control
    tq => i_s, -- 1-bit output: 3-state control
    clk => clk_400, -- 1-bit input: high speed clock
    clkdiv => clk_200, -- 1-bit input: divided clock
    -- d1 - d8: 1-bit (each) input: parallel data inputs (1-bit each)
    d1 => open,
    d2 => open,
    d3 => open,
    d4 => open,
    d5 => open,
    d6 => open,
    d7 => open,
    d8 => open,
    oce => '1', -- 1-bit input: output data clock enable
    rst => '0', -- 1-bit input: reset
    -- shiftin1 / shiftin2: 1-bit (each) input: data input expansion (1-bit each)
    shiftin1 => '0',
    shiftin2 => '0',
    -- t1 - t4: 1-bit (each) input: parallel 3-state inputs
    t1 => fast_i_1,
    t2 => fast_i_2,
    t3 => fast_i_3,
    t4 => fast_i_4,
    tbytein => '1', -- 1-bit input: byte group tristate
    tce => '1' -- 1-bit input: 3-state clock enable
  );

  oserdese2_i_n_inst : oserdese2
  generic map (
    data_rate_oq => "ddr", -- ddr, sdr
    data_rate_tq => "sdr", -- ddr, buf, sdr
    data_width => 4, -- parallel data width (2-8,10,14)
    init_oq => '0', -- initial value of oq output (1'b0,1'b1)
    init_tq => '0', -- initial value of tq output (1'b0,1'b1)
    serdes_mode => "master", -- master, slave
    srval_oq => '0', -- oq output value when sr is used (1'b0,1'b1)
    srval_tq => '0', -- tq output value when sr is used (1'b0,1'b1)
    tbyte_ctl => "false", -- enable tristate byte operation (false, true)
    tbyte_src => "false", -- tristate byte source (false, true)
    tristate_width => 4 -- 3-state converter width (1,4)
  )
  port map (
    ofb => open, -- 1-bit output: feedback path for data
    oq => open, -- 1-bit output: data path output
    -- shiftout1 / shiftout2: 1-bit (each) output: data output expansion (1-bit each)
    shiftout1 => open,
    shiftout2 => open,
    tbyteout => open, -- 1-bit output: byte group tristate
    tfb => open, -- 1-bit output: 3-state control
    tq => i_n_s, -- 1-bit output: 3-state control
    clk => clk_400, -- 1-bit input: high speed clock
    clkdiv => clk_200, -- 1-bit input: divided clock
    -- d1 - d8: 1-bit (each) input: parallel data inputs (1-bit each)
    d1 => open,
    d2 => open,
    d3 => open,
    d4 => open,
    d5 => open,
    d6 => open,
    d7 => open,
    d8 => open,
    oce => '1', -- 1-bit input: output data clock enable
    rst => '0', -- 1-bit input: reset
    -- shiftin1 / shiftin2: 1-bit (each) input: data input expansion (1-bit each)
    shiftin1 => '0',
    shiftin2 => '0',
    -- t1 - t4: 1-bit (each) input: parallel 3-state inputs
    t1 => fast_i_n_1,
    t2 => fast_i_n_2,
    t3 => fast_i_n_3,
    t4 => fast_i_n_4,
    tbytein => '1', -- 1-bit input: byte group tristate
    tce => '1' -- 1-bit input: 3-state clock enable
  );

  oserdese2_q_inst : oserdese2
  generic map (
    data_rate_oq => "ddr", -- ddr, sdr
    data_rate_tq => "sdr", -- ddr, buf, sdr
    data_width => 4, -- parallel data width (2-8,10,14)
    init_oq => '0', -- initial value of oq output (1'b0,1'b1)
    init_tq => '0', -- initial value of tq output (1'b0,1'b1)
    serdes_mode => "master", -- master, slave
    srval_oq => '0', -- oq output value when sr is used (1'b0,1'b1)
    srval_tq => '0', -- tq output value when sr is used (1'b0,1'b1)
    tbyte_ctl => "false", -- enable tristate byte operation (false, true)
    tbyte_src => "false", -- tristate byte source (false, true)
    tristate_width => 4 -- 3-state converter width (1,4)
  )
  port map (
    ofb => open, -- 1-bit output: feedback path for data
    oq => open, -- 1-bit output: data path output
    -- shiftout1 / shiftout2: 1-bit (each) output: data output expansion (1-bit each)
    shiftout1 => open,
    shiftout2 => open,
    tbyteout => open, -- 1-bit output: byte group tristate
    tfb => open, -- 1-bit output: 3-state control
    tq => q_s, -- 1-bit output: 3-state control
    clk => clk_400, -- 1-bit input: high speed clock
    clkdiv => clk_200, -- 1-bit input: divided clock
    -- d1 - d8: 1-bit (each) input: parallel data inputs (1-bit each)
    d1 => open,
    d2 => open,
    d3 => open,
    d4 => open,
    d5 => open,
    d6 => open,
    d7 => open,
    d8 => open,
    oce => '1', -- 1-bit input: output data clock enable
    rst => '0', -- 1-bit input: reset
    -- shiftin1 / shiftin2: 1-bit (each) input: data input expansion (1-bit each)
    shiftin1 => '0',
    shiftin2 => '0',
    -- t1 - t4: 1-bit (each) input: parallel 3-state inputs
    t1 => fast_q_1,
    t2 => fast_q_2,
    t3 => fast_q_3,
    t4 => fast_q_4,
    tbytein => '1', -- 1-bit input: byte group tristate
    tce => '1' -- 1-bit input: 3-state clock enable
  );

  oserdese2_q_n_inst : oserdese2
  generic map (
    data_rate_oq => "ddr", -- ddr, sdr
    data_rate_tq => "sdr", -- ddr, buf, sdr
    data_width => 4, -- parallel data width (2-8,10,14)
    init_oq => '0', -- initial value of oq output (1'b0,1'b1)
    init_tq => '0', -- initial value of tq output (1'b0,1'b1)
    serdes_mode => "master", -- master, slave
    srval_oq => '0', -- oq output value when sr is used (1'b0,1'b1)
    srval_tq => '0', -- tq output value when sr is used (1'b0,1'b1)
    tbyte_ctl => "false", -- enable tristate byte operation (false, true)
    tbyte_src => "false", -- tristate byte source (false, true)
    tristate_width => 4 -- 3-state converter width (1,4)
  )
  port map (
    ofb => open, -- 1-bit output: feedback path for data
    oq => open, -- 1-bit output: data path output
    -- shiftout1 / shiftout2: 1-bit (each) output: data output expansion (1-bit each)
    shiftout1 => open,
    shiftout2 => open,
    tbyteout => open, -- 1-bit output: byte group tristate
    tfb => open, -- 1-bit output: 3-state control
    tq => q_n_s, -- 1-bit output: 3-state control
    clk => clk_400, -- 1-bit input: high speed clock
    clkdiv => clk_200, -- 1-bit input: divided clock
    -- d1 - d8: 1-bit (each) input: parallel data inputs (1-bit each)
    d1 => open,
    d2 => open,
    d3 => open,
    d4 => open,
    d5 => open,
    d6 => open,
    d7 => open,
    d8 => open,
    oce => '1', -- 1-bit input: output data clock enable
    rst => '0', -- 1-bit input: reset
    -- shiftin1 / shiftin2: 1-bit (each) input: data input expansion (1-bit each)
    shiftin1 => '0',
    shiftin2 => '0',
    -- t1 - t4: 1-bit (each) input: parallel 3-state inputs
    t1 => fast_q_n_1,
    t2 => fast_q_n_2,
    t3 => fast_q_n_3,
    t4 => fast_q_n_4,
    tbytein => '1', -- 1-bit input: byte group tristate
    tce => '1' -- 1-bit input: 3-state clock enable
  );

  i_n <= 'z' when i_n_s = '1' else '0';
  i  <= 'z' when i_s = '1' else '0';
  q_n <= 'z' when q_n_s = '1' else '0';
  q  <= 'z' when q_s = '1' else '0';

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
    clkout3 => clk_200_s,
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
  o => clk_200, -- 1-bit output: clock output
  i => clk_200_s -- 1-bit input: clock input
  );

  bufg_inst_5 : bufg
  port map (
  o => clkfbin,
  i => clkfbout
  );


end rtl;
