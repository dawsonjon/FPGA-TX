module user_design(clk, rst, exception, input_rs232_rx, input_rs232_rx_stb, input_rs232_rx_ack, output_tx_ctl, output_tx_am, output_rs232_tx, output_tx_freq, output_leds, output_tx_ctl_stb, output_tx_am_stb, output_rs232_tx_stb, output_tx_freq_stb, output_leds_stb, output_tx_ctl_ack, output_tx_am_ack, output_rs232_tx_ack, output_tx_freq_ack, output_leds_ack);
  input  clk;
  input  rst;
  output  exception;
  input  [31:0] input_rs232_rx;
  input  input_rs232_rx_stb;
  output input_rs232_rx_ack;
  output [31:0] output_tx_ctl;
  output output_tx_ctl_stb;
  input  output_tx_ctl_ack;
  output [31:0] output_tx_am;
  output output_tx_am_stb;
  input  output_tx_am_ack;
  output [31:0] output_rs232_tx;
  output output_rs232_tx_stb;
  input  output_rs232_tx_ack;
  output [31:0] output_tx_freq;
  output output_tx_freq_stb;
  input  output_tx_freq_ack;
  output [31:0] output_leds;
  output output_leds_stb;
  input  output_leds_ack;
  wire   exception_140191123487128;
  main_0 main_0_140191123487128(
    .clk(clk),
    .rst(rst),
    .exception(exception_140191123487128),
    .input_rs232_rx(input_rs232_rx),
    .input_rs232_rx_stb(input_rs232_rx_stb),
    .input_rs232_rx_ack(input_rs232_rx_ack),
    .output_rs232_tx(output_rs232_tx),
    .output_rs232_tx_stb(output_rs232_tx_stb),
    .output_rs232_tx_ack(output_rs232_tx_ack),
    .output_leds(output_leds),
    .output_leds_stb(output_leds_stb),
    .output_leds_ack(output_leds_ack),
    .output_freq_out(output_tx_freq),
    .output_freq_out_stb(output_tx_freq_stb),
    .output_freq_out_ack(output_tx_freq_ack),
    .output_am_out(output_tx_am),
    .output_am_out_stb(output_tx_am_stb),
    .output_am_out_ack(output_tx_am_ack),
    .output_ctl_out(output_tx_ctl),
    .output_ctl_out_stb(output_tx_ctl_stb),
    .output_ctl_out_ack(output_tx_ctl_ack));
  assign exception = exception_140191123487128;
endmodule
