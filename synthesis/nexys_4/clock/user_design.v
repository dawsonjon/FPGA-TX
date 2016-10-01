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
  wire   exception_139862653362472;
  wire   exception_139862644971568;
  wire   exception_139862646361552;
  wire   exception_139862643167032;
  wire   exception_139862645557368;
  wire   exception_139862650758280;
  wire   exception_139862648892520;
  wire   exception_139862653242184;
  wire   exception_139862651635328;
  wire   exception_139862652708768;
  wire   exception_139862652897688;
  wire   exception_139862653154440;
  wire   exception_139862645457408;
  wire   exception_139862653530840;
  wire   exception_139862649334096;
  wire   exception_139862644255704;
  wire   exception_139862650723000;
  main_0 main_0_139862653362472(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862653362472),
    .input_rs232_rx(input_rs232_rx),
    .input_rs232_rx_stb(input_rs232_rx_stb),
    .input_rs232_rx_ack(input_rs232_rx_ack),
    .output_rs232_tx(output_rs232_tx),
    .output_rs232_tx_stb(output_rs232_tx_stb),
    .output_rs232_tx_ack(output_rs232_tx_ack));
  main_1 main_1_139862644971568(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862644971568),
    .input_in(input_timer),
    .input_in_stb(input_timer_stb),
    .input_in_ack(input_timer_ack));
  main_2 main_2_139862646361552(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862646361552),
    .input_in(input_ps2),
    .input_in_stb(input_ps2_stb),
    .input_in_ack(input_ps2_ack));
  main_3 main_3_139862643167032(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862643167032),
    .input_in(input_i2c),
    .input_in_stb(input_i2c_stb),
    .input_in_ack(input_i2c_ack));
  main_4 main_4_139862645557368(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862645557368),
    .input_in(input_switches),
    .input_in_stb(input_switches_stb),
    .input_in_ack(input_switches_ack));
  main_5 main_5_139862650758280(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862650758280),
    .input_in(input_eth_rx),
    .input_in_stb(input_eth_rx_stb),
    .input_in_ack(input_eth_rx_ack));
  main_6 main_6_139862648892520(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862648892520),
    .input_in(input_buttons),
    .input_in_stb(input_buttons_stb),
    .input_in_ack(input_buttons_ack));
  main_7 main_7_139862653242184(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862653242184),
    .output_out(output_seven_segment_annode),
    .output_out_stb(output_seven_segment_annode_stb),
    .output_out_ack(output_seven_segment_annode_ack));
  main_8 main_8_139862651635328(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862651635328),
    .output_out(output_eth_tx),
    .output_out_stb(output_eth_tx_stb),
    .output_out_ack(output_eth_tx_ack));
  main_9 main_9_139862652708768(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652708768),
    .output_out(output_leds),
    .output_out_stb(output_leds_stb),
    .output_out_ack(output_leds_ack));
  main_10 main_10_139862652897688(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652897688),
    .output_out(output_audio),
    .output_out_stb(output_audio_stb),
    .output_out_ack(output_audio_ack));
  main_11 main_11_139862653154440(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862653154440),
    .output_out(output_led_g),
    .output_out_stb(output_led_g_stb),
    .output_out_ack(output_led_g_ack));
  main_12 main_12_139862645457408(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862645457408),
    .output_out(output_seven_segment_cathode),
    .output_out_stb(output_seven_segment_cathode_stb),
    .output_out_ack(output_seven_segment_cathode_ack));
  main_13 main_13_139862653530840(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862653530840),
    .output_out(output_led_b),
    .output_out_stb(output_led_b_stb),
    .output_out_ack(output_led_b_ack));
  main_14 main_14_139862649334096(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862649334096),
    .output_out(output_i2c),
    .output_out_stb(output_i2c_stb),
    .output_out_ack(output_i2c_ack));
  main_15 main_15_139862644255704(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862644255704),
    .output_out(output_vga),
    .output_out_stb(output_vga_stb),
    .output_out_ack(output_vga_ack));
  main_16 main_16_139862650723000(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862650723000),
    .output_out(output_led_r),
    .output_out_stb(output_led_r_stb),
    .output_out_ack(output_led_r_ack));
  assign exception = exception_139862653362472 || exception_139862644971568 || exception_139862646361552 || exception_139862643167032 || exception_139862645557368 || exception_139862650758280 || exception_139862648892520 || exception_139862653242184 || exception_139862651635328 || exception_139862652708768 || exception_139862652897688 || exception_139862653154440 || exception_139862645457408 || exception_139862653530840 || exception_139862649334096 || exception_139862644255704 || exception_139862650723000;
endmodule
