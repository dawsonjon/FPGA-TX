module main_18 (output_out_ack,clk,rst,output_out,output_out_stb,exception);
  input output_out_ack;
  input clk;
  input rst;
  output [31:0] output_out;
  output output_out_stb;
  output exception;

  assign output_out = 0;
  assign output_out_stb = 1;
  assign exception = 0;
endmodule