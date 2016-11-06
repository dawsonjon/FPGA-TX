module user_design(clk, rst, exception, input_timer, input_rs232_rx, input_ps2, input_i2c, input_switches, input_eth_rx, input_buttons, input_timer_stb, input_rs232_rx_stb, input_ps2_stb, input_i2c_stb, input_switches_stb, input_eth_rx_stb, input_buttons_stb, input_timer_ack, input_rs232_rx_ack, input_ps2_ack, input_i2c_ack, input_switches_ack, input_eth_rx_ack, input_buttons_ack, output_seven_segment_annode, output_tx_ctl, output_eth_tx, output_rs232_tx, output_leds, output_audio, output_led_g, output_seven_segment_cathode, output_led_b, output_i2c, output_vga, output_tx_am, output_led_r, output_tx_freq, output_seven_segment_annode_stb, output_tx_ctl_stb, output_eth_tx_stb, output_rs232_tx_stb, output_leds_stb, output_audio_stb, output_led_g_stb, output_seven_segment_cathode_stb, output_led_b_stb, output_i2c_stb, output_vga_stb, output_tx_am_stb, output_led_r_stb, output_tx_freq_stb, output_seven_segment_annode_ack, output_tx_ctl_ack, output_eth_tx_ack, output_rs232_tx_ack, output_leds_ack, output_audio_ack, output_led_g_ack, output_seven_segment_cathode_ack, output_led_b_ack, output_i2c_ack, output_vga_ack, output_tx_am_ack, output_led_r_ack, output_tx_freq_ack);
  input  clk;
  input  rst;
  output  exception;
  input  [31:0] input_timer;
  input  input_timer_stb;
  output input_timer_ack;
  input  [31:0] input_rs232_rx;
  input  input_rs232_rx_stb;
  output input_rs232_rx_ack;
  input  [31:0] input_ps2;
  input  input_ps2_stb;
  output input_ps2_ack;
  input  [31:0] input_i2c;
  input  input_i2c_stb;
  output input_i2c_ack;
  input  [31:0] input_switches;
  input  input_switches_stb;
  output input_switches_ack;
  input  [31:0] input_eth_rx;
  input  input_eth_rx_stb;
  output input_eth_rx_ack;
  input  [31:0] input_buttons;
  input  input_buttons_stb;
  output input_buttons_ack;
  output [31:0] output_seven_segment_annode;
  output output_seven_segment_annode_stb;
  input  output_seven_segment_annode_ack;
  output [31:0] output_tx_ctl;
  output output_tx_ctl_stb;
  input  output_tx_ctl_ack;
  output [31:0] output_eth_tx;
  output output_eth_tx_stb;
  input  output_eth_tx_ack;
  output [31:0] output_rs232_tx;
  output output_rs232_tx_stb;
  input  output_rs232_tx_ack;
  output [31:0] output_leds;
  output output_leds_stb;
  input  output_leds_ack;
  output [31:0] output_audio;
  output output_audio_stb;
  input  output_audio_ack;
  output [31:0] output_led_g;
  output output_led_g_stb;
  input  output_led_g_ack;
  output [31:0] output_seven_segment_cathode;
  output output_seven_segment_cathode_stb;
  input  output_seven_segment_cathode_ack;
  output [31:0] output_led_b;
  output output_led_b_stb;
  input  output_led_b_ack;
  output [31:0] output_i2c;
  output output_i2c_stb;
  input  output_i2c_ack;
  output [31:0] output_vga;
  output output_vga_stb;
  input  output_vga_ack;
  output [31:0] output_tx_am;
  output output_tx_am_stb;
  input  output_tx_am_ack;
  output [31:0] output_led_r;
  output output_led_r_stb;
  input  output_led_r_ack;
  output [31:0] output_tx_freq;
  output output_tx_freq_stb;
  input  output_tx_freq_ack;
  wire   exception_139871567460040;
  wire   exception_139871567356416;
  wire   exception_139871564850096;
  wire   exception_139871565782480;
  wire   exception_139871567446096;
  wire   exception_139871564534848;
  wire   exception_139871564804752;
  wire   exception_139871565752008;
  wire   exception_139871565745328;
  wire   exception_139871563950704;
  wire   exception_139871564537224;
  wire   exception_139871566434888;
  wire   exception_139871564299296;
  wire   exception_139871564758192;
  wire   exception_139871566436832;
  wire   exception_139871566685464;
  main_0 main_0_139871567460040(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871567460040),
    .input_rs232_rx(input_rs232_rx),
    .input_rs232_rx_stb(input_rs232_rx_stb),
    .input_rs232_rx_ack(input_rs232_rx_ack),
    .output_rs232_tx(output_rs232_tx),
    .output_rs232_tx_stb(output_rs232_tx_stb),
    .output_rs232_tx_ack(output_rs232_tx_ack),
    .output_audio_out(output_audio),
    .output_audio_out_stb(output_audio_stb),
    .output_audio_out_ack(output_audio_ack),
    .output_freq_out(output_tx_freq),
    .output_freq_out_stb(output_tx_freq_stb),
    .output_freq_out_ack(output_tx_freq_ack),
    .output_am_out(output_tx_am),
    .output_am_out_stb(output_tx_am_stb),
    .output_am_out_ack(output_tx_am_ack),
    .output_ctl_out(output_tx_ctl),
    .output_ctl_out_stb(output_tx_ctl_stb),
    .output_ctl_out_ack(output_tx_ctl_ack));
  main_1 main_1_139871567356416(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871567356416),
    .input_in(input_timer),
    .input_in_stb(input_timer_stb),
    .input_in_ack(input_timer_ack));
  main_2 main_2_139871564850096(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871564850096),
    .input_in(input_ps2),
    .input_in_stb(input_ps2_stb),
    .input_in_ack(input_ps2_ack));
  main_3 main_3_139871565782480(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871565782480),
    .input_in(input_i2c),
    .input_in_stb(input_i2c_stb),
    .input_in_ack(input_i2c_ack));
  main_4 main_4_139871567446096(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871567446096),
    .input_in(input_switches),
    .input_in_stb(input_switches_stb),
    .input_in_ack(input_switches_ack));
  main_5 main_5_139871564534848(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871564534848),
    .input_in(input_eth_rx),
    .input_in_stb(input_eth_rx_stb),
    .input_in_ack(input_eth_rx_ack));
  main_6 main_6_139871564804752(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871564804752),
    .input_in(input_buttons),
    .input_in_stb(input_buttons_stb),
    .input_in_ack(input_buttons_ack));
  main_7 main_7_139871565752008(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871565752008),
    .output_out(output_seven_segment_annode),
    .output_out_stb(output_seven_segment_annode_stb),
    .output_out_ack(output_seven_segment_annode_ack));
  main_8 main_8_139871565745328(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871565745328),
    .output_out(output_eth_tx),
    .output_out_stb(output_eth_tx_stb),
    .output_out_ack(output_eth_tx_ack));
  main_9 main_9_139871563950704(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871563950704),
    .output_out(output_leds),
    .output_out_stb(output_leds_stb),
    .output_out_ack(output_leds_ack));
  main_10 main_10_139871564537224(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871564537224),
    .output_out(output_led_g),
    .output_out_stb(output_led_g_stb),
    .output_out_ack(output_led_g_ack));
  main_11 main_11_139871566434888(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871566434888),
    .output_out(output_seven_segment_cathode),
    .output_out_stb(output_seven_segment_cathode_stb),
    .output_out_ack(output_seven_segment_cathode_ack));
  main_12 main_12_139871564299296(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871564299296),
    .output_out(output_led_b),
    .output_out_stb(output_led_b_stb),
    .output_out_ack(output_led_b_ack));
  main_13 main_13_139871564758192(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871564758192),
    .output_out(output_i2c),
    .output_out_stb(output_i2c_stb),
    .output_out_ack(output_i2c_ack));
  main_14 main_14_139871566436832(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871566436832),
    .output_out(output_vga),
    .output_out_stb(output_vga_stb),
    .output_out_ack(output_vga_ack));
  main_15 main_15_139871566685464(
    .clk(clk),
    .rst(rst),
    .exception(exception_139871566685464),
    .output_out(output_led_r),
    .output_out_stb(output_led_r_stb),
    .output_out_ack(output_led_r_ack));
  assign exception = exception_139871567460040 || exception_139871567356416 || exception_139871564850096 || exception_139871565782480 || exception_139871567446096 || exception_139871564534848 || exception_139871564804752 || exception_139871565752008 || exception_139871565745328 || exception_139871563950704 || exception_139871564537224 || exception_139871566434888 || exception_139871564299296 || exception_139871564758192 || exception_139871566436832 || exception_139871566685464;
endmodule
