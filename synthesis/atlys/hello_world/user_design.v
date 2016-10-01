module user_design(clk, rst, exception, input_timer, input_rs232_rx, input_buttons, input_switches, input_eth_rx, input_ps2, input_timer_stb, input_rs232_rx_stb, input_buttons_stb, input_switches_stb, input_eth_rx_stb, input_ps2_stb, input_timer_ack, input_rs232_rx_ack, input_buttons_ack, input_switches_ack, input_eth_rx_ack, input_ps2_ack, output_eth_tx, output_rs232_tx, output_leds, output_eth_tx_stb, output_rs232_tx_stb, output_leds_stb, output_eth_tx_ack, output_rs232_tx_ack, output_leds_ack);
  input  clk;
  input  rst;
  output  exception;
  input  [31:0] input_timer;
  input  input_timer_stb;
  output input_timer_ack;
  input  [31:0] input_rs232_rx;
  input  input_rs232_rx_stb;
  output input_rs232_rx_ack;
  input  [31:0] input_buttons;
  input  input_buttons_stb;
  output input_buttons_ack;
  input  [31:0] input_switches;
  input  input_switches_stb;
  output input_switches_ack;
  input  [31:0] input_eth_rx;
  input  input_eth_rx_stb;
  output input_eth_rx_ack;
  input  [31:0] input_ps2;
  input  input_ps2_stb;
  output input_ps2_ack;
  output [31:0] output_eth_tx;
  output output_eth_tx_stb;
  input  output_eth_tx_ack;
  output [31:0] output_rs232_tx;
  output output_rs232_tx_stb;
  input  output_rs232_tx_ack;
  output [31:0] output_leds;
  output output_leds_stb;
  input  output_leds_ack;
  wire   exception_139862644953960;
  wire   exception_139862644166240;
  wire   exception_139862645134832;
  wire   exception_139862652443032;
  wire   exception_139862652505984;
  wire   exception_139862640071024;
  wire   exception_139862635182056;
  wire   exception_139862647349328;
  wire   exception_139862636844312;
  main_0 main_0_139862644953960(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862644953960),
    .output_rs232_tx(output_rs232_tx),
    .output_rs232_tx_stb(output_rs232_tx_stb),
    .output_rs232_tx_ack(output_rs232_tx_ack));
  main_1 main_1_139862644166240(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862644166240),
    .input_in(input_timer),
    .input_in_stb(input_timer_stb),
    .input_in_ack(input_timer_ack));
  main_2 main_2_139862645134832(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862645134832),
    .input_in(input_rs232_rx),
    .input_in_stb(input_rs232_rx_stb),
    .input_in_ack(input_rs232_rx_ack));
  main_3 main_3_139862652443032(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652443032),
    .input_in(input_buttons),
    .input_in_stb(input_buttons_stb),
    .input_in_ack(input_buttons_ack));
  main_4 main_4_139862652505984(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652505984),
    .input_in(input_switches),
    .input_in_stb(input_switches_stb),
    .input_in_ack(input_switches_ack));
  main_5 main_5_139862640071024(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862640071024),
    .input_in(input_eth_rx),
    .input_in_stb(input_eth_rx_stb),
    .input_in_ack(input_eth_rx_ack));
  main_6 main_6_139862635182056(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862635182056),
    .input_in(input_ps2),
    .input_in_stb(input_ps2_stb),
    .input_in_ack(input_ps2_ack));
  main_7 main_7_139862647349328(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862647349328),
    .output_out(output_eth_tx),
    .output_out_stb(output_eth_tx_stb),
    .output_out_ack(output_eth_tx_ack));
  main_8 main_8_139862636844312(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862636844312),
    .output_out(output_leds),
    .output_out_stb(output_leds_stb),
    .output_out_ack(output_leds_ack));
  assign exception = exception_139862644953960 || exception_139862644166240 || exception_139862645134832 || exception_139862652443032 || exception_139862652505984 || exception_139862640071024 || exception_139862635182056 || exception_139862647349328 || exception_139862636844312;
endmodule
