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
  wire   [31:0] wire_139931276046560;
  wire   wire_139931276046560_stb;
  wire   wire_139931276046560_ack;
  wire   exception_139931282298208;
  wire   exception_139931279302312;
  wire   exception_139931282298568;
  wire   exception_139931276022632;
  wire   exception_139931284594768;
  wire   exception_139931283933808;
  wire   exception_139931274793904;
  wire   exception_139931280104840;
  wire   exception_139931276181376;
  wire   exception_139931279234472;
  wire   exception_139931282558560;
  wire   exception_139931284812000;
  wire   exception_139931278184392;
  wire   exception_139931274909024;
  wire   exception_139931275225496;
  wire   exception_139931277018680;
  wire   exception_139931277927848;
  wire   exception_139931279974624;
  main_0 main_0_139931282298208(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931282298208),
    .output_value(wire_139931276046560),
    .output_value_stb(wire_139931276046560_stb),
    .output_value_ack(wire_139931276046560_ack));
  main_1 main_1_139931279302312(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931279302312),
    .input_value(wire_139931276046560),
    .input_value_stb(wire_139931276046560_stb),
    .input_value_ack(wire_139931276046560_ack),
    .output_annode(output_seven_segment_annode),
    .output_annode_stb(output_seven_segment_annode_stb),
    .output_annode_ack(output_seven_segment_annode_ack),
    .output_cathode(output_seven_segment_cathode),
    .output_cathode_stb(output_seven_segment_cathode_stb),
    .output_cathode_ack(output_seven_segment_cathode_ack));
  main_2 main_2_139931282298568(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931282298568),
    .input_in(input_timer),
    .input_in_stb(input_timer_stb),
    .input_in_ack(input_timer_ack));
  main_3 main_3_139931276022632(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931276022632),
    .input_in(input_rs232_rx),
    .input_in_stb(input_rs232_rx_stb),
    .input_in_ack(input_rs232_rx_ack));
  main_4 main_4_139931284594768(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931284594768),
    .input_in(input_ps2),
    .input_in_stb(input_ps2_stb),
    .input_in_ack(input_ps2_ack));
  main_5 main_5_139931283933808(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931283933808),
    .input_in(input_i2c),
    .input_in_stb(input_i2c_stb),
    .input_in_ack(input_i2c_ack));
  main_6 main_6_139931274793904(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931274793904),
    .input_in(input_switches),
    .input_in_stb(input_switches_stb),
    .input_in_ack(input_switches_ack));
  main_7 main_7_139931280104840(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931280104840),
    .input_in(input_eth_rx),
    .input_in_stb(input_eth_rx_stb),
    .input_in_ack(input_eth_rx_ack));
  main_8 main_8_139931276181376(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931276181376),
    .input_in(input_buttons),
    .input_in_stb(input_buttons_stb),
    .input_in_ack(input_buttons_ack));
  main_9 main_9_139931279234472(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931279234472),
    .output_out(output_eth_tx),
    .output_out_stb(output_eth_tx_stb),
    .output_out_ack(output_eth_tx_ack));
  main_10 main_10_139931282558560(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931282558560),
    .output_out(output_rs232_tx),
    .output_out_stb(output_rs232_tx_stb),
    .output_out_ack(output_rs232_tx_ack));
  main_11 main_11_139931284812000(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931284812000),
    .output_out(output_leds),
    .output_out_stb(output_leds_stb),
    .output_out_ack(output_leds_ack));
  main_12 main_12_139931278184392(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931278184392),
    .output_out(output_audio),
    .output_out_stb(output_audio_stb),
    .output_out_ack(output_audio_ack));
  main_13 main_13_139931274909024(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931274909024),
    .output_out(output_led_g),
    .output_out_stb(output_led_g_stb),
    .output_out_ack(output_led_g_ack));
  main_14 main_14_139931275225496(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931275225496),
    .output_out(output_led_b),
    .output_out_stb(output_led_b_stb),
    .output_out_ack(output_led_b_ack));
  main_15 main_15_139931277018680(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931277018680),
    .output_out(output_i2c),
    .output_out_stb(output_i2c_stb),
    .output_out_ack(output_i2c_ack));
  main_16 main_16_139931277927848(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931277927848),
    .output_out(output_vga),
    .output_out_stb(output_vga_stb),
    .output_out_ack(output_vga_ack));
  main_17 main_17_139931279974624(
    .clk(clk),
    .rst(rst),
    .exception(exception_139931279974624),
    .output_out(output_led_r),
    .output_out_stb(output_led_r_stb),
    .output_out_ack(output_led_r_ack));
  assign exception = exception_139931282298208 || exception_139931279302312 || exception_139931282298568 || exception_139931276022632 || exception_139931284594768 || exception_139931283933808 || exception_139931274793904 || exception_139931280104840 || exception_139931276181376 || exception_139931279234472 || exception_139931282558560 || exception_139931284812000 || exception_139931278184392 || exception_139931274909024 || exception_139931275225496 || exception_139931277018680 || exception_139931277927848 || exception_139931279974624;
endmodule
