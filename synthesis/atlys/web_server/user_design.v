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
  wire   [31:0] wire_139862651979392;
  wire   wire_139862651979392_stb;
  wire   wire_139862651979392_ack;
  wire   [31:0] wire_139862651978816;
  wire   wire_139862651978816_stb;
  wire   wire_139862651978816_ack;
  wire   [31:0] wire_139862651979032;
  wire   wire_139862651979032_stb;
  wire   wire_139862651979032_ack;
  wire   [31:0] wire_139862651979176;
  wire   wire_139862651979176_stb;
  wire   wire_139862651979176_ack;
  wire   exception_139862651979464;
  wire   exception_139862650537960;
  wire   exception_139862638454400;
  wire   exception_139862650745920;
  wire   exception_139862652018984;
  main_0 main_0_139862651979464(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862651979464),
    .input_in1(wire_139862651979032),
    .input_in1_stb(wire_139862651979032_stb),
    .input_in1_ack(wire_139862651979032_ack),
    .input_in2(wire_139862651979176),
    .input_in2_stb(wire_139862651979176_stb),
    .input_in2_ack(wire_139862651979176_ack),
    .output_out(output_rs232_tx),
    .output_out_stb(output_rs232_tx_stb),
    .output_out_ack(output_rs232_tx_ack));
  main_1 main_1_139862650537960(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862650537960),
    .input_switches(input_switches),
    .input_switches_stb(input_switches_stb),
    .input_switches_ack(input_switches_ack),
    .input_buttons(input_buttons),
    .input_buttons_stb(input_buttons_stb),
    .input_buttons_ack(input_buttons_ack),
    .input_socket(wire_139862651978816),
    .input_socket_stb(wire_139862651978816_stb),
    .input_socket_ack(wire_139862651978816_ack),
    .input_rs232_rx(input_rs232_rx),
    .input_rs232_rx_stb(input_rs232_rx_stb),
    .input_rs232_rx_ack(input_rs232_rx_ack),
    .output_rs232_tx(wire_139862651979032),
    .output_rs232_tx_stb(wire_139862651979032_stb),
    .output_rs232_tx_ack(wire_139862651979032_ack),
    .output_leds(output_leds),
    .output_leds_stb(output_leds_stb),
    .output_leds_ack(output_leds_ack),
    .output_socket(wire_139862651979392),
    .output_socket_stb(wire_139862651979392_stb),
    .output_socket_ack(wire_139862651979392_ack));
  main_2 main_2_139862638454400(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862638454400),
    .input_eth_rx(input_eth_rx),
    .input_eth_rx_stb(input_eth_rx_stb),
    .input_eth_rx_ack(input_eth_rx_ack),
    .input_socket(wire_139862651979392),
    .input_socket_stb(wire_139862651979392_stb),
    .input_socket_ack(wire_139862651979392_ack),
    .output_rs232_tx(wire_139862651979176),
    .output_rs232_tx_stb(wire_139862651979176_stb),
    .output_rs232_tx_ack(wire_139862651979176_ack),
    .output_socket(wire_139862651978816),
    .output_socket_stb(wire_139862651978816_stb),
    .output_socket_ack(wire_139862651978816_ack),
    .output_eth_tx(output_eth_tx),
    .output_eth_tx_stb(output_eth_tx_stb),
    .output_eth_tx_ack(output_eth_tx_ack));
  main_3 main_3_139862650745920(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862650745920),
    .input_in(input_timer),
    .input_in_stb(input_timer_stb),
    .input_in_ack(input_timer_ack));
  main_4 main_4_139862652018984(
    .clk(clk),
    .rst(rst),
    .exception(exception_139862652018984),
    .input_in(input_ps2),
    .input_in_stb(input_ps2_stb),
    .input_in_ack(input_ps2_ack));
  assign exception = exception_139862651979464 || exception_139862650537960 || exception_139862638454400 || exception_139862650745920 || exception_139862652018984;
endmodule
