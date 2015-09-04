module user_design(clk, rst, eth_rx, rs232_rx, switches, buttons, timer, eth_rx_stb, rs232_rx_stb, switches_stb, buttons_stb, timer_stb, eth_rx_ack, rs232_rx_ack, switches_ack, buttons_ack, timer_ack, eth_tx, rs232_tx, led, eth_tx_stb, rs232_tx_stb, led_stb, eth_tx_ack, rs232_tx_ack, led_ack);
  input  clk;
  input  rst;
  input  [31:0] eth_rx;
  input  eth_rx_stb;
  output eth_rx_ack;
  input  [31:0] rs232_rx;
  input  rs232_rx_stb;
  output rs232_rx_ack;
  input  [31:0] switches;
  input  switches_stb;
  output switches_ack;
  input  [31:0] buttons;
  input  buttons_stb;
  output buttons_ack;
  input  [31:0] timer;
  input  timer_stb;
  output timer_ack;
  output [31:0] eth_tx;
  output eth_tx_stb;
  input  eth_tx_ack;
  output [31:0] rs232_tx;
  output rs232_tx_stb;
  input  rs232_tx_ack;
  output [31:0] led;
  output led_stb;
  input  led_ack;
  user_design user_design_48078000(
    .clk(clk),
    .rst(rst),
    .input_switches(switches),
    .input_switches_stb(switches_stb),
    .input_switches_ack(switches_ack),
    .input_buttons(buttons),
    .input_buttons_stb(buttons_stb),
    .input_buttons_ack(buttons_ack),
    .input_eth_rx(eth_rx),
    .input_eth_rx_stb(eth_rx_stb),
    .input_eth_rx_ack(eth_rx_ack),
    .input_timer(timer),
    .input_timer_stb(timer_stb),
    .input_timer_ack(timer_ack),
    .input_rs232_rx(rs232_rx),
    .input_rs232_rx_stb(rs232_rx_stb),
    .input_rs232_rx_ack(rs232_rx_ack),
    .output_rs232_tx(rs232_tx),
    .output_rs232_tx_stb(rs232_tx_stb),
    .output_rs232_tx_ack(rs232_tx_ack),
    .output_leds(led),
    .output_leds_stb(led_stb),
    .output_leds_ack(led_ack),
    .output_eth_tx(eth_tx),
    .output_eth_tx_stb(eth_tx_stb),
    .output_eth_tx_ack(eth_tx_ack));
endmodule
