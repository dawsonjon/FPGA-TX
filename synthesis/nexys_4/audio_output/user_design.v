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
  wire   exception_140564202926376;
  wire   exception_140564202372848;
  wire   exception_140564203075920;
  wire   exception_140564201568304;
  wire   exception_140564201064640;
  wire   exception_140564202106960;
  wire   exception_140564201710728;
  wire   exception_140564200331384;
  wire   exception_140564202528496;
  wire   exception_140564202321320;
  wire   exception_140564202318376;
  wire   exception_140564200712744;
  wire   exception_140564200539920;
  wire   exception_140564198777056;
  wire   exception_140564202408776;
  wire   exception_140564198343312;
  wire   exception_140564202498168;
  wire   exception_140564202458864;
  wire   exception_140564198734880;
  main_0 main_0_140564202926376(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564202926376),
    .input_eth_in(input_eth_rx),
    .input_eth_in_stb(input_eth_rx_stb),
    .input_eth_in_ack(input_eth_rx_ack),
    .output_audio_out(output_audio),
    .output_audio_out_stb(output_audio_stb),
    .output_audio_out_ack(output_audio_ack),
    .output_eth_out(output_eth_tx),
    .output_eth_out_stb(output_eth_tx_stb),
    .output_eth_out_ack(output_eth_tx_ack));
  main_1 main_1_140564202372848(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564202372848),
    .input_in(input_timer),
    .input_in_stb(input_timer_stb),
    .input_in_ack(input_timer_ack));
  main_2 main_2_140564203075920(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564203075920),
    .input_in(input_rs232_rx),
    .input_in_stb(input_rs232_rx_stb),
    .input_in_ack(input_rs232_rx_ack));
  main_3 main_3_140564201568304(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564201568304),
    .input_in(input_ps2),
    .input_in_stb(input_ps2_stb),
    .input_in_ack(input_ps2_ack));
  main_4 main_4_140564201064640(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564201064640),
    .input_in(input_radio_audio),
    .input_in_stb(input_radio_audio_stb),
    .input_in_ack(input_radio_audio_ack));
  main_5 main_5_140564202106960(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564202106960),
    .input_in(input_i2c),
    .input_in_stb(input_i2c_stb),
    .input_in_ack(input_i2c_ack));
  main_6 main_6_140564201710728(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564201710728),
    .input_in(input_switches),
    .input_in_stb(input_switches_stb),
    .input_in_ack(input_switches_ack));
  main_7 main_7_140564200331384(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564200331384),
    .input_in(input_buttons),
    .input_in_stb(input_buttons_stb),
    .input_in_ack(input_buttons_ack));
  main_8 main_8_140564202528496(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564202528496),
    .output_out(output_seven_segment_annode),
    .output_out_stb(output_seven_segment_annode_stb),
    .output_out_ack(output_seven_segment_annode_ack));
  main_9 main_9_140564202321320(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564202321320),
    .output_out(output_rs232_tx),
    .output_out_stb(output_rs232_tx_stb),
    .output_out_ack(output_rs232_tx_ack));
  main_10 main_10_140564202318376(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564202318376),
    .output_out(output_leds),
    .output_out_stb(output_leds_stb),
    .output_out_ack(output_leds_ack));
  main_11 main_11_140564200712744(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564200712744),
    .output_out(output_led_g),
    .output_out_stb(output_led_g_stb),
    .output_out_ack(output_led_g_ack));
  main_12 main_12_140564200539920(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564200539920),
    .output_out(output_seven_segment_cathode),
    .output_out_stb(output_seven_segment_cathode_stb),
    .output_out_ack(output_seven_segment_cathode_ack));
  main_13 main_13_140564198777056(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564198777056),
    .output_out(output_led_b),
    .output_out_stb(output_led_b_stb),
    .output_out_ack(output_led_b_ack));
  main_14 main_14_140564202408776(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564202408776),
    .output_out(output_radio_frequency),
    .output_out_stb(output_radio_frequency_stb),
    .output_out_ack(output_radio_frequency_ack));
  main_15 main_15_140564198343312(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564198343312),
    .output_out(output_i2c),
    .output_out_stb(output_i2c_stb),
    .output_out_ack(output_i2c_ack));
  main_16 main_16_140564202498168(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564202498168),
    .output_out(output_vga),
    .output_out_stb(output_vga_stb),
    .output_out_ack(output_vga_ack));
  main_17 main_17_140564202458864(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564202458864),
    .output_out(output_radio_average_samples),
    .output_out_stb(output_radio_average_samples_stb),
    .output_out_ack(output_radio_average_samples_ack));
  main_18 main_18_140564198734880(
    .clk(clk),
    .rst(rst),
    .exception(exception_140564198734880),
    .output_out(output_led_r),
    .output_out_stb(output_led_r_stb),
    .output_out_ack(output_led_r_ack));
  assign exception = exception_140564202926376 || exception_140564202372848 || exception_140564203075920 || exception_140564201568304 || exception_140564201064640 || exception_140564202106960 || exception_140564201710728 || exception_140564200331384 || exception_140564202528496 || exception_140564202321320 || exception_140564202318376 || exception_140564200712744 || exception_140564200539920 || exception_140564198777056 || exception_140564202408776 || exception_140564198343312 || exception_140564202498168 || exception_140564202458864 || exception_140564198734880;
endmodule
