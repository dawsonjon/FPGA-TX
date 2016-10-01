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
  wire   [31:0] wire_139862652899272;
  wire   wire_139862652899272_stb;
  wire   wire_139862652899272_ack;
  wire   [31:0] wire_139862652897760;
  wire   wire_139862652897760_stb;
  wire   wire_139862652897760_ack;
  wire   [31:0] wire_139862652895888;
  wire   wire_139862652895888_stb;
  wire   wire_139862652895888_ack;
  wire   [31:0] wire_139862652898552;
  wire   wire_139862652898552_stb;
  wire   wire_139862652898552_ack;
  wire   exception_139862652896896;
  wire   exception_139862648885544;
  wire   exception_139862642642528;
  wire   exception_139862650578848;
  wire   exception_139862641339136;
  wire   exception_139862641140008;
  wire   exception_139862644177160;
  wire   exception_139862640327280;
  wire   exception_139862643501680;
  wire   exception_139862647186424;
  wire   exception_139862643542208;
  wire   exception_139862643617664;
  wire   exception_139862653193032;
  wire   exception_139862642599192;
  main_0 main_0_139862652896896(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652896896),
    .input_in1(wire_139862652895888),
    .input_in1_stb(wire_139862652895888_stb),
    .input_in1_ack(wire_139862652895888_ack),
    .input_in2(wire_139862652898552),
    .input_in2_stb(wire_139862652898552_stb),
    .input_in2_ack(wire_139862652898552_ack),
    .output_out(output_rs232_tx),
    .output_out_stb(output_rs232_tx_stb),
    .output_out_ack(output_rs232_tx_ack));
  main_1 main_1_139862648885544(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862648885544),
    .input_switches(input_switches),
    .input_switches_stb(input_switches_stb),
    .input_switches_ack(input_switches_ack),
    .input_buttons(input_buttons),
    .input_buttons_stb(input_buttons_stb),
    .input_buttons_ack(input_buttons_ack),
    .input_socket(wire_139862652897760),
    .input_socket_stb(wire_139862652897760_stb),
    .input_socket_ack(wire_139862652897760_ack),
    .input_rs232_rx(input_rs232_rx),
    .input_rs232_rx_stb(input_rs232_rx_stb),
    .input_rs232_rx_ack(input_rs232_rx_ack),
    .output_rs232_tx(wire_139862652895888),
    .output_rs232_tx_stb(wire_139862652895888_stb),
    .output_rs232_tx_ack(wire_139862652895888_ack),
    .output_leds(output_leds),
    .output_leds_stb(output_leds_stb),
    .output_leds_ack(output_leds_ack),
    .output_socket(wire_139862652899272),
    .output_socket_stb(wire_139862652899272_stb),
    .output_socket_ack(wire_139862652899272_ack));
  main_2 main_2_139862642642528(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862642642528),
    .input_eth_rx(input_eth_rx),
    .input_eth_rx_stb(input_eth_rx_stb),
    .input_eth_rx_ack(input_eth_rx_ack),
    .input_socket(wire_139862652899272),
    .input_socket_stb(wire_139862652899272_stb),
    .input_socket_ack(wire_139862652899272_ack),
    .output_rs232_tx(wire_139862652898552),
    .output_rs232_tx_stb(wire_139862652898552_stb),
    .output_rs232_tx_ack(wire_139862652898552_ack),
    .output_socket(wire_139862652897760),
    .output_socket_stb(wire_139862652897760_stb),
    .output_socket_ack(wire_139862652897760_ack),
    .output_eth_tx(output_eth_tx),
    .output_eth_tx_stb(output_eth_tx_stb),
    .output_eth_tx_ack(output_eth_tx_ack));
  main_3 main_3_139862650578848(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862650578848),
    .input_in(input_timer),
    .input_in_stb(input_timer_stb),
    .input_in_ack(input_timer_ack));
  main_4 main_4_139862641339136(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862641339136),
    .input_in(input_ps2),
    .input_in_stb(input_ps2_stb),
    .input_in_ack(input_ps2_ack));
  main_5 main_5_139862641140008(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862641140008),
    .input_in(input_i2c),
    .input_in_stb(input_i2c_stb),
    .input_in_ack(input_i2c_ack));
  main_6 main_6_139862644177160(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862644177160),
    .output_out(output_seven_segment_annode),
    .output_out_stb(output_seven_segment_annode_stb),
    .output_out_ack(output_seven_segment_annode_ack));
  main_7 main_7_139862640327280(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862640327280),
    .output_out(output_audio),
    .output_out_stb(output_audio_stb),
    .output_out_ack(output_audio_ack));
  main_8 main_8_139862643501680(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862643501680),
    .output_out(output_led_g),
    .output_out_stb(output_led_g_stb),
    .output_out_ack(output_led_g_ack));
  main_9 main_9_139862647186424(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862647186424),
    .output_out(output_seven_segment_cathode),
    .output_out_stb(output_seven_segment_cathode_stb),
    .output_out_ack(output_seven_segment_cathode_ack));
  main_10 main_10_139862643542208(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862643542208),
    .output_out(output_led_b),
    .output_out_stb(output_led_b_stb),
    .output_out_ack(output_led_b_ack));
  main_11 main_11_139862643617664(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862643617664),
    .output_out(output_i2c),
    .output_out_stb(output_i2c_stb),
    .output_out_ack(output_i2c_ack));
  main_12 main_12_139862653193032(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862653193032),
    .output_out(output_vga),
    .output_out_stb(output_vga_stb),
    .output_out_ack(output_vga_ack));
  main_13 main_13_139862642599192(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862642599192),
    .output_out(output_led_r),
    .output_out_stb(output_led_r_stb),
    .output_out_ack(output_led_r_ack));
  assign exception = exception_139862652896896 || exception_139862648885544 || exception_139862642642528 || exception_139862650578848 || exception_139862641339136 || exception_139862641140008 || exception_139862644177160 || exception_139862640327280 || exception_139862643501680 || exception_139862647186424 || exception_139862643542208 || exception_139862643617664 || exception_139862653193032 || exception_139862642599192;
endmodule
