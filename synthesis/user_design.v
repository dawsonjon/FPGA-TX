module user_design(clk, rst, exception, input_eth_rx, input_rs232_rx, input_switches, input_buttons, input_timer, input_eth_rx_stb, input_rs232_rx_stb, input_switches_stb, input_buttons_stb, input_timer_stb, input_eth_rx_ack, input_rs232_rx_ack, input_switches_ack, input_buttons_ack, input_timer_ack, output_eth_tx, output_rs232_tx, output_leds, output_eth_tx_stb, output_rs232_tx_stb, output_leds_stb, output_eth_tx_ack, output_rs232_tx_ack, output_leds_ack);
  input  clk;
  input  rst;
  output  exception;
  input  [31:0] input_eth_rx;
  input  input_eth_rx_stb;
  output input_eth_rx_ack;
  input  [31:0] input_rs232_rx;
  input  input_rs232_rx_stb;
  output input_rs232_rx_ack;
  input  [31:0] input_switches;
  input  input_switches_stb;
  output input_switches_ack;
  input  [31:0] input_buttons;
  input  input_buttons_stb;
  output input_buttons_ack;
  input  [31:0] input_timer;
  input  input_timer_stb;
  output input_timer_ack;
  output [31:0] output_eth_tx;
  output output_eth_tx_stb;
  input  output_eth_tx_ack;
  output [31:0] output_rs232_tx;
  output output_rs232_tx_stb;
  input  output_rs232_tx_ack;
  output [31:0] output_leds;
  output output_leds_stb;
  input  output_leds_ack;
  wire   [31:0] wire_24135224;
  wire   wire_24135224_stb;
  wire   wire_24135224_ack;
  wire   [31:0] wire_24135296;
  wire   wire_24135296_stb;
  wire   wire_24135296_ack;
  wire   [31:0] wire_24135368;
  wire   wire_24135368_stb;
  wire   wire_24135368_ack;
  wire   [31:0] wire_24135440;
  wire   wire_24135440_stb;
  wire   wire_24135440_ack;
  wire   exception_24135512;
  wire   exception_24328024;
  wire   exception_21121792;
  arbiter arbiter_24135512(
    .clk(clk),
    .rst(rst),
    .exception(exception_24135512),
    .input_in1(wire_24135368),
    .input_in1_stb(wire_24135368_stb),
    .input_in1_ack(wire_24135368_ack),
    .input_in2(wire_24135440),
    .input_in2_stb(wire_24135440_stb),
    .input_in2_ack(wire_24135440_ack),
    .output_out(output_rs232_tx),
    .output_out_stb(output_rs232_tx_stb),
    .output_out_ack(output_rs232_tx_ack));
  application application_24328024(
    .clk(clk),
    .rst(rst),
    .exception(exception_24328024),
    .input_switches(input_switches),
    .input_switches_stb(input_switches_stb),
    .input_switches_ack(input_switches_ack),
    .input_buttons(input_buttons),
    .input_buttons_stb(input_buttons_stb),
    .input_buttons_ack(input_buttons_ack),
    .input_socket(wire_24135296),
    .input_socket_stb(wire_24135296_stb),
    .input_socket_ack(wire_24135296_ack),
    .input_timer(input_timer),
    .input_timer_stb(input_timer_stb),
    .input_timer_ack(input_timer_ack),
    .input_rs232_rx(input_rs232_rx),
    .input_rs232_rx_stb(input_rs232_rx_stb),
    .input_rs232_rx_ack(input_rs232_rx_ack),
    .output_rs232_tx(wire_24135368),
    .output_rs232_tx_stb(wire_24135368_stb),
    .output_rs232_tx_ack(wire_24135368_ack),
    .output_leds(output_leds),
    .output_leds_stb(output_leds_stb),
    .output_leds_ack(output_leds_ack),
    .output_socket(wire_24135224),
    .output_socket_stb(wire_24135224_stb),
    .output_socket_ack(wire_24135224_ack));
  server server_21121792(
    .clk(clk),
    .rst(rst),
    .exception(exception_21121792),
    .input_eth_rx(input_eth_rx),
    .input_eth_rx_stb(input_eth_rx_stb),
    .input_eth_rx_ack(input_eth_rx_ack),
    .input_socket(wire_24135224),
    .input_socket_stb(wire_24135224_stb),
    .input_socket_ack(wire_24135224_ack),
    .output_rs232_tx(wire_24135440),
    .output_rs232_tx_stb(wire_24135440_stb),
    .output_rs232_tx_ack(wire_24135440_ack),
    .output_socket(wire_24135296),
    .output_socket_stb(wire_24135296_stb),
    .output_socket_ack(wire_24135296_ack),
    .output_eth_tx(output_eth_tx),
    .output_eth_tx_stb(output_eth_tx_stb),
    .output_eth_tx_ack(output_eth_tx_ack));
  assign exception = exception_24135512 || exception_24328024 || exception_21121792;
endmodule
