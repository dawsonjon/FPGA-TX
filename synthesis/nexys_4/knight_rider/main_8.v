//Discard stream contents
module main_8 (input_in_ack,clk,rst,input_in,input_in_stb,exception);
  input clk;
  input rst;
  input [31:0] input_in;
  input input_in_stb;
  output input_in_ack;
  output exception;

  assign input_in_ack = 1;
  assign exception = 0;
endmodule