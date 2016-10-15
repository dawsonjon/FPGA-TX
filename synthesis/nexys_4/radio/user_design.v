module user_design(clk, rst, exception, input_timer, input_rs232_rx, input_ps2, input_radio_audio, input_i2c, input_switches, input_eth_rx, input_buttons, input_timer_stb, input_rs232_rx_stb, input_ps2_stb, input_radio_audio_stb, input_i2c_stb, input_switches_stb, input_eth_rx_stb, input_buttons_stb, input_timer_ack, input_rs232_rx_ack, input_ps2_ack, input_radio_audio_ack, input_i2c_ack, input_switches_ack, input_eth_rx_ack, input_buttons_ack, output_seven_segment_annode, output_eth_tx, output_rs232_tx, output_leds, output_audio, output_led_g, output_seven_segment_cathode, output_led_b, output_radio_frequency, output_i2c, output_vga, output_radio_average_samples, output_led_r, output_seven_segment_annode_stb, output_eth_tx_stb, output_rs232_tx_stb, output_leds_stb, output_audio_stb, output_led_g_stb, output_seven_segment_cathode_stb, output_led_b_stb, output_radio_frequency_stb, output_i2c_stb, output_vga_stb, output_radio_average_samples_stb, output_led_r_stb, output_seven_segment_annode_ack, output_eth_tx_ack, output_rs232_tx_ack, output_leds_ack, output_audio_ack, output_led_g_ack, output_seven_segment_cathode_ack, output_led_b_ack, output_radio_frequency_ack, output_i2c_ack, output_vga_ack, output_radio_average_samples_ack, output_led_r_ack);
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
  input  [31:0] input_radio_audio;
  input  input_radio_audio_stb;
  output input_radio_audio_ack;
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
  output [31:0] output_radio_frequency;
  output output_radio_frequency_stb;
  input  output_radio_frequency_ack;
  output [31:0] output_i2c;
  output output_i2c_stb;
  input  output_i2c_ack;
  output [31:0] output_vga;
  output output_vga_stb;
  input  output_vga_ack;
  output [31:0] output_radio_average_samples;
  output output_radio_average_samples_stb;
  input  output_radio_average_samples_ack;
  output [31:0] output_led_r;
  output output_led_r_stb;
  input  output_led_r_ack;
  wire   exception_140242267076080;
  wire   exception_140242266531312;
  wire   exception_140242264712112;
  wire   exception_140242265385584;
  wire   exception_140242264524560;
  wire   exception_140242264526288;
  wire   exception_140242264432792;
  wire   exception_140242264600448;
  wire   exception_140242264344840;
  wire   exception_140242265734032;
  wire   exception_140242265430928;
  wire   exception_140242264059984;
  wire   exception_140242264526576;
  wire   exception_140242265164544;
  main_0 main_0_140242267076080(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242267076080),
    .input_rs232_rx(input_rs232_rx),
    .input_rs232_rx_stb(input_rs232_rx_stb),
    .input_rs232_rx_ack(input_rs232_rx_ack),
    .input_audio_in(input_radio_audio),
    .input_audio_in_stb(input_radio_audio_stb),
    .input_audio_in_ack(input_radio_audio_ack),
    .input_eth_in(input_eth_rx),
    .input_eth_in_stb(input_eth_rx_stb),
    .input_eth_in_ack(input_eth_rx_ack),
    .output_rs232_tx(output_rs232_tx),
    .output_rs232_tx_stb(output_rs232_tx_stb),
    .output_rs232_tx_ack(output_rs232_tx_ack),
    .output_audio_out(output_audio),
    .output_audio_out_stb(output_audio_stb),
    .output_audio_out_ack(output_audio_ack),
    .output_samples_out(output_radio_average_samples),
    .output_samples_out_stb(output_radio_average_samples_stb),
    .output_samples_out_ack(output_radio_average_samples_ack),
    .output_frequency_out(output_radio_frequency),
    .output_frequency_out_stb(output_radio_frequency_stb),
    .output_frequency_out_ack(output_radio_frequency_ack),
    .output_eth_out(output_eth_tx),
    .output_eth_out_stb(output_eth_tx_stb),
    .output_eth_out_ack(output_eth_tx_ack));
  main_1 main_1_140242266531312(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242266531312),
    .input_in(input_timer),
    .input_in_stb(input_timer_stb),
    .input_in_ack(input_timer_ack));
  main_2 main_2_140242264712112(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242264712112),
    .input_in(input_ps2),
    .input_in_stb(input_ps2_stb),
    .input_in_ack(input_ps2_ack));
  main_3 main_3_140242265385584(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242265385584),
    .input_in(input_i2c),
    .input_in_stb(input_i2c_stb),
    .input_in_ack(input_i2c_ack));
  main_4 main_4_140242264524560(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242264524560),
    .input_in(input_switches),
    .input_in_stb(input_switches_stb),
    .input_in_ack(input_switches_ack));
  main_5 main_5_140242264526288(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242264526288),
    .input_in(input_buttons),
    .input_in_stb(input_buttons_stb),
    .input_in_ack(input_buttons_ack));
  main_6 main_6_140242264432792(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242264432792),
    .output_out(output_seven_segment_annode),
    .output_out_stb(output_seven_segment_annode_stb),
    .output_out_ack(output_seven_segment_annode_ack));
  main_7 main_7_140242264600448(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242264600448),
    .output_out(output_leds),
    .output_out_stb(output_leds_stb),
    .output_out_ack(output_leds_ack));
  main_8 main_8_140242264344840(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242264344840),
    .output_out(output_led_g),
    .output_out_stb(output_led_g_stb),
    .output_out_ack(output_led_g_ack));
  main_9 main_9_140242265734032(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242265734032),
    .output_out(output_seven_segment_cathode),
    .output_out_stb(output_seven_segment_cathode_stb),
    .output_out_ack(output_seven_segment_cathode_ack));
  main_10 main_10_140242265430928(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242265430928),
    .output_out(output_led_b),
    .output_out_stb(output_led_b_stb),
    .output_out_ack(output_led_b_ack));
  main_11 main_11_140242264059984(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242264059984),
    .output_out(output_i2c),
    .output_out_stb(output_i2c_stb),
    .output_out_ack(output_i2c_ack));
  main_12 main_12_140242264526576(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242264526576),
    .output_out(output_vga),
    .output_out_stb(output_vga_stb),
    .output_out_ack(output_vga_ack));
  main_13 main_13_140242265164544(
    .clk(clk),
    .rst(rst),
    .exception(exception_140242265164544),
    .output_out(output_led_r),
    .output_out_stb(output_led_r_stb),
    .output_out_ack(output_led_r_ack));
  assign exception = exception_140242267076080 || exception_140242266531312 || exception_140242264712112 || exception_140242265385584 || exception_140242264524560 || exception_140242264526288 || exception_140242264432792 || exception_140242264600448 || exception_140242264344840 || exception_140242265734032 || exception_140242265430928 || exception_140242264059984 || exception_140242264526576 || exception_140242265164544;
endmodule
