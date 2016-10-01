module user_design(clk, rst, exception, input_timer, input_rs232_rx, input_ps2, input_i2c, input_switches, input_eth_rx, input_buttons, input_timer_stb, input_rs232_rx_stb, input_ps2_stb, input_i2c_stb, input_switches_stb, input_eth_rx_stb, input_buttons_stb, input_timer_ack, input_rs232_rx_ack, input_ps2_ack, input_i2c_ack, input_switches_ack, input_eth_rx_ack, input_buttons_ack, output_seven_segment_annode, output_eth_tx, output_rs232_tx, output_leds, output_audio, output_led_g, output_seven_segment_cathode, output_led_b, output_i2c, output_vga, output_led_r, output_seven_segment_annode_stb, output_eth_tx_stb, output_rs232_tx_stb, output_leds_stb, output_audio_stb, output_led_g_stb, output_seven_segment_cathode_stb, output_led_b_stb, output_i2c_stb, output_vga_stb, output_led_r_stb, output_seven_segment_annode_ack, output_eth_tx_ack, output_rs232_tx_ack, output_leds_ack, output_audio_ack, output_led_g_ack, output_seven_segment_cathode_ack, output_led_b_ack, output_i2c_ack, output_vga_ack, output_led_r_ack);
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
  output [31:0] output_led_r;
  output output_led_r_stb;
  input  output_led_r_ack;
  wire   exception_139862652345808;
  wire   exception_139862652354144;
  wire   exception_139862652324464;
  wire   exception_139862652346952;
  wire   exception_139862645379584;
  wire   exception_139862649794072;
  wire   exception_139862648076768;
  wire   exception_139862652896824;
  wire   exception_139862649927296;
  wire   exception_139862646670832;
  wire   exception_139862647211576;
  wire   exception_139862647452160;
  wire   exception_139862650040264;
  wire   exception_139862646427376;
  wire   exception_139862647041704;
  wire   exception_139862652508352;
  main_0 main_0_139862652345808(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652345808),
    .input_eth_in(input_eth_rx),
    .input_eth_in_stb(input_eth_rx_stb),
    .input_eth_in_ack(input_eth_rx_ack),
    .output_audio_out(output_audio),
    .output_audio_out_stb(output_audio_stb),
    .output_audio_out_ack(output_audio_ack),
    .output_eth_out(output_eth_tx),
    .output_eth_out_stb(output_eth_tx_stb),
    .output_eth_out_ack(output_eth_tx_ack));
  main_1 main_1_139862652354144(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652354144),
    .input_in(input_timer),
    .input_in_stb(input_timer_stb),
    .input_in_ack(input_timer_ack));
  main_2 main_2_139862652324464(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652324464),
    .input_in(input_rs232_rx),
    .input_in_stb(input_rs232_rx_stb),
    .input_in_ack(input_rs232_rx_ack));
  main_3 main_3_139862652346952(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652346952),
    .input_in(input_ps2),
    .input_in_stb(input_ps2_stb),
    .input_in_ack(input_ps2_ack));
  main_4 main_4_139862645379584(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862645379584),
    .input_in(input_i2c),
    .input_in_stb(input_i2c_stb),
    .input_in_ack(input_i2c_ack));
  main_5 main_5_139862649794072(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862649794072),
    .input_in(input_switches),
    .input_in_stb(input_switches_stb),
    .input_in_ack(input_switches_ack));
  main_6 main_6_139862648076768(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862648076768),
    .input_in(input_buttons),
    .input_in_stb(input_buttons_stb),
    .input_in_ack(input_buttons_ack));
  main_7 main_7_139862652896824(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652896824),
    .output_out(output_seven_segment_annode),
    .output_out_stb(output_seven_segment_annode_stb),
    .output_out_ack(output_seven_segment_annode_ack));
  main_8 main_8_139862649927296(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862649927296),
    .output_out(output_rs232_tx),
    .output_out_stb(output_rs232_tx_stb),
    .output_out_ack(output_rs232_tx_ack));
  main_9 main_9_139862646670832(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862646670832),
    .output_out(output_leds),
    .output_out_stb(output_leds_stb),
    .output_out_ack(output_leds_ack));
  main_10 main_10_139862647211576(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862647211576),
    .output_out(output_led_g),
    .output_out_stb(output_led_g_stb),
    .output_out_ack(output_led_g_ack));
  main_11 main_11_139862647452160(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862647452160),
    .output_out(output_seven_segment_cathode),
    .output_out_stb(output_seven_segment_cathode_stb),
    .output_out_ack(output_seven_segment_cathode_ack));
  main_12 main_12_139862650040264(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862650040264),
    .output_out(output_led_b),
    .output_out_stb(output_led_b_stb),
    .output_out_ack(output_led_b_ack));
  main_13 main_13_139862646427376(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862646427376),
    .output_out(output_i2c),
    .output_out_stb(output_i2c_stb),
    .output_out_ack(output_i2c_ack));
  main_14 main_14_139862647041704(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862647041704),
    .output_out(output_vga),
    .output_out_stb(output_vga_stb),
    .output_out_ack(output_vga_ack));
  main_15 main_15_139862652508352(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652508352),
    .output_out(output_led_r),
    .output_out_stb(output_led_r_stb),
    .output_out_ack(output_led_r_ack));
  assign exception = exception_139862652345808 || exception_139862652354144 || exception_139862652324464 || exception_139862652346952 || exception_139862645379584 || exception_139862649794072 || exception_139862648076768 || exception_139862652896824 || exception_139862649927296 || exception_139862646670832 || exception_139862647211576 || exception_139862647452160 || exception_139862650040264 || exception_139862646427376 || exception_139862647041704 || exception_139862652508352;
endmodule
