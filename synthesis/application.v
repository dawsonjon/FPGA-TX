//////////////////////////////////////////////////////////////////////////////
//name : application
//input : input_socket:16
//input : input_rs232_rx:16
//input : input_timer:16
//input : input_switches:16
//input : input_buttons:16
//output : output_socket:16
//output : output_rs232_tx:16
//output : output_leds:16
//source_file : /media/storage/Projects/Chips-Demo/demo/examples/image_processor/application.c
///===========
///
///Created by C2CHIP

module application(input_socket,input_rs232_rx,input_timer,input_switches,input_buttons,input_socket_stb,input_rs232_rx_stb,input_timer_stb,input_switches_stb,input_buttons_stb,output_socket_ack,output_rs232_tx_ack,output_leds_ack,clk,rst,output_socket,output_rs232_tx,output_leds,output_socket_stb,output_rs232_tx_stb,output_leds_stb,input_socket_ack,input_rs232_rx_ack,input_timer_ack,input_switches_ack,input_buttons_ack,exception);
  integer file_count;
  parameter  stop = 3'd0,
  instruction_fetch = 3'd1,
  operand_fetch = 3'd2,
  execute = 3'd3,
  load = 3'd4,
  wait_state = 3'd5,
  read = 3'd6,
  write = 3'd7;
  input [31:0] input_socket;
  input [31:0] input_rs232_rx;
  input [31:0] input_timer;
  input [31:0] input_switches;
  input [31:0] input_buttons;
  input input_socket_stb;
  input input_rs232_rx_stb;
  input input_timer_stb;
  input input_switches_stb;
  input input_buttons_stb;
  input output_socket_ack;
  input output_rs232_tx_ack;
  input output_leds_ack;
  input clk;
  input rst;
  output [31:0] output_socket;
  output [31:0] output_rs232_tx;
  output [31:0] output_leds;
  output output_socket_stb;
  output output_rs232_tx_stb;
  output output_leds_stb;
  output input_socket_ack;
  output input_rs232_rx_ack;
  output input_timer_ack;
  output input_switches_ack;
  output input_buttons_ack;
  reg [15:0] timer;
  reg [15:0] program_counter;
  reg [15:0] program_counter_1;
  reg [15:0] program_counter_2;
  reg [43:0] instruction;
  reg [3:0] opcode_2;
  reg [3:0] a;
  reg [3:0] b;
  reg [3:0] z;
  reg write_enable;
  reg [3:0] address_a_2;
  reg [3:0] address_b_2;
  reg [3:0] address_z_2;
  reg [3:0] address_z_3;
  reg [31:0] load_data;
  reg [31:0] write_output;
  reg [31:0] write_value;
  reg [31:0] read_input;
  reg [31:0] literal_2;
  reg [31:0] a_hi;
  reg [31:0] b_hi;
  reg [31:0] a_lo;
  reg [31:0] b_lo;
  reg [63:0] long_result;
  reg [31:0] result;
  reg [15:0] address;
  reg [31:0] data_out;
  reg [31:0] data_in;
  reg [31:0] carry;
  reg [31:0] s_output_socket_stb;
  reg [31:0] s_output_rs232_tx_stb;
  reg [31:0] s_output_leds_stb;
  reg [31:0] s_output_socket;
  reg [31:0] s_output_rs232_tx;
  reg [31:0] s_output_leds;
  reg [31:0] s_input_socket_ack;
  reg [31:0] s_input_rs232_rx_ack;
  reg [31:0] s_input_timer_ack;
  reg [31:0] s_input_switches_ack;
  reg [31:0] s_input_buttons_ack;
  reg [7:0] state;
  output reg exception;
  reg [43:0] instructions [391:0];
  reg [31:0] memory [6143:0];
  reg [31:0] registers [15:0];
  wire [31:0] operand_a;
  wire [31:0] operand_b;
  wire [31:0] register_a;
  wire [31:0] register_b;
  wire [31:0] literal;
  wire [3:0] opcode;
  wire [3:0] address_a;
  wire [3:0] address_b;
  wire [3:0] address_z;
  wire [15:0] load_address;
  wire [15:0] store_address;
  wire [31:0] store_data;
  wire  store_enable;

  //////////////////////////////////////////////////////////////////////////////
  // INSTRUCTION INITIALIZATION                                                 
  //                                                                            
  // Initialise the contents of the instruction memory                          
  //
  // Intruction Set
  // ==============
  // 0 {'literal': True, 'op': 'literal'}
  // 1 {'literal': True, 'op': 'addl'}
  // 2 {'literal': False, 'op': 'store'}
  // 3 {'literal': True, 'op': 'call'}
  // 4 {'literal': False, 'op': 'stop'}
  // 5 {'literal': False, 'op': 'load'}
  // 6 {'literal': False, 'op': 'read'}
  // 7 {'literal': False, 'op': 'subtract'}
  // 8 {'literal': False, 'op': 'write'}
  // 9 {'literal': True, 'op': 'goto'}
  // 10 {'literal': False, 'op': 'return'}
  // 11 {'literal': False, 'op': 'add'}
  // 12 {'literal': True, 'op': 'jmp_if_false'}
  // Intructions
  // ===========
  
  initial
  begin
    instructions[0] = {4'd0, 4'd3, 4'd0, 32'd0};//{'literal': 0, 'z': 3, 'op': 'literal'}
    instructions[1] = {4'd0, 4'd4, 4'd0, 32'd0};//{'literal': 0, 'z': 4, 'op': 'literal'}
    instructions[2] = {4'd1, 4'd3, 4'd3, 32'd72};//{'a': 3, 'literal': 72, 'z': 3, 'op': 'addl'}
    instructions[3] = {4'd0, 4'd8, 4'd0, 32'd73};//{'literal': 73, 'z': 8, 'op': 'literal'}
    instructions[4] = {4'd0, 4'd2, 4'd0, 32'd0};//{'literal': 0, 'z': 2, 'op': 'literal'}
    instructions[5] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[6] = {4'd0, 4'd8, 4'd0, 32'd109};//{'literal': 109, 'z': 8, 'op': 'literal'}
    instructions[7] = {4'd0, 4'd2, 4'd0, 32'd1};//{'literal': 1, 'z': 2, 'op': 'literal'}
    instructions[8] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[9] = {4'd0, 4'd8, 4'd0, 32'd97};//{'literal': 97, 'z': 8, 'op': 'literal'}
    instructions[10] = {4'd0, 4'd2, 4'd0, 32'd2};//{'literal': 2, 'z': 2, 'op': 'literal'}
    instructions[11] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[12] = {4'd0, 4'd8, 4'd0, 32'd103};//{'literal': 103, 'z': 8, 'op': 'literal'}
    instructions[13] = {4'd0, 4'd2, 4'd0, 32'd3};//{'literal': 3, 'z': 2, 'op': 'literal'}
    instructions[14] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[15] = {4'd0, 4'd8, 4'd0, 32'd101};//{'literal': 101, 'z': 8, 'op': 'literal'}
    instructions[16] = {4'd0, 4'd2, 4'd0, 32'd4};//{'literal': 4, 'z': 2, 'op': 'literal'}
    instructions[17] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[18] = {4'd0, 4'd8, 4'd0, 32'd32};//{'literal': 32, 'z': 8, 'op': 'literal'}
    instructions[19] = {4'd0, 4'd2, 4'd0, 32'd5};//{'literal': 5, 'z': 2, 'op': 'literal'}
    instructions[20] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[21] = {4'd0, 4'd8, 4'd0, 32'd80};//{'literal': 80, 'z': 8, 'op': 'literal'}
    instructions[22] = {4'd0, 4'd2, 4'd0, 32'd6};//{'literal': 6, 'z': 2, 'op': 'literal'}
    instructions[23] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[24] = {4'd0, 4'd8, 4'd0, 32'd114};//{'literal': 114, 'z': 8, 'op': 'literal'}
    instructions[25] = {4'd0, 4'd2, 4'd0, 32'd7};//{'literal': 7, 'z': 2, 'op': 'literal'}
    instructions[26] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[27] = {4'd0, 4'd8, 4'd0, 32'd111};//{'literal': 111, 'z': 8, 'op': 'literal'}
    instructions[28] = {4'd0, 4'd2, 4'd0, 32'd8};//{'literal': 8, 'z': 2, 'op': 'literal'}
    instructions[29] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[30] = {4'd0, 4'd8, 4'd0, 32'd99};//{'literal': 99, 'z': 8, 'op': 'literal'}
    instructions[31] = {4'd0, 4'd2, 4'd0, 32'd9};//{'literal': 9, 'z': 2, 'op': 'literal'}
    instructions[32] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[33] = {4'd0, 4'd8, 4'd0, 32'd101};//{'literal': 101, 'z': 8, 'op': 'literal'}
    instructions[34] = {4'd0, 4'd2, 4'd0, 32'd10};//{'literal': 10, 'z': 2, 'op': 'literal'}
    instructions[35] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[36] = {4'd0, 4'd8, 4'd0, 32'd115};//{'literal': 115, 'z': 8, 'op': 'literal'}
    instructions[37] = {4'd0, 4'd2, 4'd0, 32'd11};//{'literal': 11, 'z': 2, 'op': 'literal'}
    instructions[38] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[39] = {4'd0, 4'd8, 4'd0, 32'd115};//{'literal': 115, 'z': 8, 'op': 'literal'}
    instructions[40] = {4'd0, 4'd2, 4'd0, 32'd12};//{'literal': 12, 'z': 2, 'op': 'literal'}
    instructions[41] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[42] = {4'd0, 4'd8, 4'd0, 32'd105};//{'literal': 105, 'z': 8, 'op': 'literal'}
    instructions[43] = {4'd0, 4'd2, 4'd0, 32'd13};//{'literal': 13, 'z': 2, 'op': 'literal'}
    instructions[44] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[45] = {4'd0, 4'd8, 4'd0, 32'd110};//{'literal': 110, 'z': 8, 'op': 'literal'}
    instructions[46] = {4'd0, 4'd2, 4'd0, 32'd14};//{'literal': 14, 'z': 2, 'op': 'literal'}
    instructions[47] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[48] = {4'd0, 4'd8, 4'd0, 32'd103};//{'literal': 103, 'z': 8, 'op': 'literal'}
    instructions[49] = {4'd0, 4'd2, 4'd0, 32'd15};//{'literal': 15, 'z': 2, 'op': 'literal'}
    instructions[50] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[51] = {4'd0, 4'd8, 4'd0, 32'd32};//{'literal': 32, 'z': 8, 'op': 'literal'}
    instructions[52] = {4'd0, 4'd2, 4'd0, 32'd16};//{'literal': 16, 'z': 2, 'op': 'literal'}
    instructions[53] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[54] = {4'd0, 4'd8, 4'd0, 32'd67};//{'literal': 67, 'z': 8, 'op': 'literal'}
    instructions[55] = {4'd0, 4'd2, 4'd0, 32'd17};//{'literal': 17, 'z': 2, 'op': 'literal'}
    instructions[56] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[57] = {4'd0, 4'd8, 4'd0, 32'd104};//{'literal': 104, 'z': 8, 'op': 'literal'}
    instructions[58] = {4'd0, 4'd2, 4'd0, 32'd18};//{'literal': 18, 'z': 2, 'op': 'literal'}
    instructions[59] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[60] = {4'd0, 4'd8, 4'd0, 32'd105};//{'literal': 105, 'z': 8, 'op': 'literal'}
    instructions[61] = {4'd0, 4'd2, 4'd0, 32'd19};//{'literal': 19, 'z': 2, 'op': 'literal'}
    instructions[62] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[63] = {4'd0, 4'd8, 4'd0, 32'd112};//{'literal': 112, 'z': 8, 'op': 'literal'}
    instructions[64] = {4'd0, 4'd2, 4'd0, 32'd20};//{'literal': 20, 'z': 2, 'op': 'literal'}
    instructions[65] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[66] = {4'd0, 4'd8, 4'd0, 32'd115};//{'literal': 115, 'z': 8, 'op': 'literal'}
    instructions[67] = {4'd0, 4'd2, 4'd0, 32'd21};//{'literal': 21, 'z': 2, 'op': 'literal'}
    instructions[68] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[69] = {4'd0, 4'd8, 4'd0, 32'd45};//{'literal': 45, 'z': 8, 'op': 'literal'}
    instructions[70] = {4'd0, 4'd2, 4'd0, 32'd22};//{'literal': 22, 'z': 2, 'op': 'literal'}
    instructions[71] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[72] = {4'd0, 4'd8, 4'd0, 32'd50};//{'literal': 50, 'z': 8, 'op': 'literal'}
    instructions[73] = {4'd0, 4'd2, 4'd0, 32'd23};//{'literal': 23, 'z': 2, 'op': 'literal'}
    instructions[74] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[75] = {4'd0, 4'd8, 4'd0, 32'd46};//{'literal': 46, 'z': 8, 'op': 'literal'}
    instructions[76] = {4'd0, 4'd2, 4'd0, 32'd24};//{'literal': 24, 'z': 2, 'op': 'literal'}
    instructions[77] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[78] = {4'd0, 4'd8, 4'd0, 32'd48};//{'literal': 48, 'z': 8, 'op': 'literal'}
    instructions[79] = {4'd0, 4'd2, 4'd0, 32'd25};//{'literal': 25, 'z': 2, 'op': 'literal'}
    instructions[80] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[81] = {4'd0, 4'd8, 4'd0, 32'd32};//{'literal': 32, 'z': 8, 'op': 'literal'}
    instructions[82] = {4'd0, 4'd2, 4'd0, 32'd26};//{'literal': 26, 'z': 2, 'op': 'literal'}
    instructions[83] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[84] = {4'd0, 4'd8, 4'd0, 32'd100};//{'literal': 100, 'z': 8, 'op': 'literal'}
    instructions[85] = {4'd0, 4'd2, 4'd0, 32'd27};//{'literal': 27, 'z': 2, 'op': 'literal'}
    instructions[86] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[87] = {4'd0, 4'd8, 4'd0, 32'd101};//{'literal': 101, 'z': 8, 'op': 'literal'}
    instructions[88] = {4'd0, 4'd2, 4'd0, 32'd28};//{'literal': 28, 'z': 2, 'op': 'literal'}
    instructions[89] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[90] = {4'd0, 4'd8, 4'd0, 32'd109};//{'literal': 109, 'z': 8, 'op': 'literal'}
    instructions[91] = {4'd0, 4'd2, 4'd0, 32'd29};//{'literal': 29, 'z': 2, 'op': 'literal'}
    instructions[92] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[93] = {4'd0, 4'd8, 4'd0, 32'd111};//{'literal': 111, 'z': 8, 'op': 'literal'}
    instructions[94] = {4'd0, 4'd2, 4'd0, 32'd30};//{'literal': 30, 'z': 2, 'op': 'literal'}
    instructions[95] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[96] = {4'd0, 4'd8, 4'd0, 32'd33};//{'literal': 33, 'z': 8, 'op': 'literal'}
    instructions[97] = {4'd0, 4'd2, 4'd0, 32'd31};//{'literal': 31, 'z': 2, 'op': 'literal'}
    instructions[98] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[99] = {4'd0, 4'd8, 4'd0, 32'd10};//{'literal': 10, 'z': 8, 'op': 'literal'}
    instructions[100] = {4'd0, 4'd2, 4'd0, 32'd32};//{'literal': 32, 'z': 2, 'op': 'literal'}
    instructions[101] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[102] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[103] = {4'd0, 4'd2, 4'd0, 32'd33};//{'literal': 33, 'z': 2, 'op': 'literal'}
    instructions[104] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[105] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[106] = {4'd0, 4'd2, 4'd0, 32'd34};//{'literal': 34, 'z': 2, 'op': 'literal'}
    instructions[107] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[108] = {4'd0, 4'd8, 4'd0, 32'd1};//{'literal': 1, 'z': 8, 'op': 'literal'}
    instructions[109] = {4'd0, 4'd2, 4'd0, 32'd35};//{'literal': 35, 'z': 2, 'op': 'literal'}
    instructions[110] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[111] = {4'd0, 4'd8, 4'd0, 32'd3};//{'literal': 3, 'z': 8, 'op': 'literal'}
    instructions[112] = {4'd0, 4'd2, 4'd0, 32'd36};//{'literal': 36, 'z': 2, 'op': 'literal'}
    instructions[113] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[114] = {4'd0, 4'd8, 4'd0, 32'd2};//{'literal': 2, 'z': 8, 'op': 'literal'}
    instructions[115] = {4'd0, 4'd2, 4'd0, 32'd37};//{'literal': 37, 'z': 2, 'op': 'literal'}
    instructions[116] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[117] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[118] = {4'd0, 4'd2, 4'd0, 32'd38};//{'literal': 38, 'z': 2, 'op': 'literal'}
    instructions[119] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[120] = {4'd0, 4'd8, 4'd0, 32'd67};//{'literal': 67, 'z': 8, 'op': 'literal'}
    instructions[121] = {4'd0, 4'd2, 4'd0, 32'd39};//{'literal': 39, 'z': 2, 'op': 'literal'}
    instructions[122] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[123] = {4'd0, 4'd8, 4'd0, 32'd111};//{'literal': 111, 'z': 8, 'op': 'literal'}
    instructions[124] = {4'd0, 4'd2, 4'd0, 32'd40};//{'literal': 40, 'z': 2, 'op': 'literal'}
    instructions[125] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[126] = {4'd0, 4'd8, 4'd0, 32'd110};//{'literal': 110, 'z': 8, 'op': 'literal'}
    instructions[127] = {4'd0, 4'd2, 4'd0, 32'd41};//{'literal': 41, 'z': 2, 'op': 'literal'}
    instructions[128] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[129] = {4'd0, 4'd8, 4'd0, 32'd110};//{'literal': 110, 'z': 8, 'op': 'literal'}
    instructions[130] = {4'd0, 4'd2, 4'd0, 32'd42};//{'literal': 42, 'z': 2, 'op': 'literal'}
    instructions[131] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[132] = {4'd0, 4'd8, 4'd0, 32'd101};//{'literal': 101, 'z': 8, 'op': 'literal'}
    instructions[133] = {4'd0, 4'd2, 4'd0, 32'd43};//{'literal': 43, 'z': 2, 'op': 'literal'}
    instructions[134] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[135] = {4'd0, 4'd8, 4'd0, 32'd99};//{'literal': 99, 'z': 8, 'op': 'literal'}
    instructions[136] = {4'd0, 4'd2, 4'd0, 32'd44};//{'literal': 44, 'z': 2, 'op': 'literal'}
    instructions[137] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[138] = {4'd0, 4'd8, 4'd0, 32'd116};//{'literal': 116, 'z': 8, 'op': 'literal'}
    instructions[139] = {4'd0, 4'd2, 4'd0, 32'd45};//{'literal': 45, 'z': 2, 'op': 'literal'}
    instructions[140] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[141] = {4'd0, 4'd8, 4'd0, 32'd32};//{'literal': 32, 'z': 8, 'op': 'literal'}
    instructions[142] = {4'd0, 4'd2, 4'd0, 32'd46};//{'literal': 46, 'z': 2, 'op': 'literal'}
    instructions[143] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[144] = {4'd0, 4'd8, 4'd0, 32'd116};//{'literal': 116, 'z': 8, 'op': 'literal'}
    instructions[145] = {4'd0, 4'd2, 4'd0, 32'd47};//{'literal': 47, 'z': 2, 'op': 'literal'}
    instructions[146] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[147] = {4'd0, 4'd8, 4'd0, 32'd111};//{'literal': 111, 'z': 8, 'op': 'literal'}
    instructions[148] = {4'd0, 4'd2, 4'd0, 32'd48};//{'literal': 48, 'z': 2, 'op': 'literal'}
    instructions[149] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[150] = {4'd0, 4'd8, 4'd0, 32'd32};//{'literal': 32, 'z': 8, 'op': 'literal'}
    instructions[151] = {4'd0, 4'd2, 4'd0, 32'd49};//{'literal': 49, 'z': 2, 'op': 'literal'}
    instructions[152] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[153] = {4'd0, 4'd8, 4'd0, 32'd49};//{'literal': 49, 'z': 8, 'op': 'literal'}
    instructions[154] = {4'd0, 4'd2, 4'd0, 32'd50};//{'literal': 50, 'z': 2, 'op': 'literal'}
    instructions[155] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[156] = {4'd0, 4'd8, 4'd0, 32'd57};//{'literal': 57, 'z': 8, 'op': 'literal'}
    instructions[157] = {4'd0, 4'd2, 4'd0, 32'd51};//{'literal': 51, 'z': 2, 'op': 'literal'}
    instructions[158] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[159] = {4'd0, 4'd8, 4'd0, 32'd50};//{'literal': 50, 'z': 8, 'op': 'literal'}
    instructions[160] = {4'd0, 4'd2, 4'd0, 32'd52};//{'literal': 52, 'z': 2, 'op': 'literal'}
    instructions[161] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[162] = {4'd0, 4'd8, 4'd0, 32'd46};//{'literal': 46, 'z': 8, 'op': 'literal'}
    instructions[163] = {4'd0, 4'd2, 4'd0, 32'd53};//{'literal': 53, 'z': 2, 'op': 'literal'}
    instructions[164] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[165] = {4'd0, 4'd8, 4'd0, 32'd49};//{'literal': 49, 'z': 8, 'op': 'literal'}
    instructions[166] = {4'd0, 4'd2, 4'd0, 32'd54};//{'literal': 54, 'z': 2, 'op': 'literal'}
    instructions[167] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[168] = {4'd0, 4'd8, 4'd0, 32'd54};//{'literal': 54, 'z': 8, 'op': 'literal'}
    instructions[169] = {4'd0, 4'd2, 4'd0, 32'd55};//{'literal': 55, 'z': 2, 'op': 'literal'}
    instructions[170] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[171] = {4'd0, 4'd8, 4'd0, 32'd56};//{'literal': 56, 'z': 8, 'op': 'literal'}
    instructions[172] = {4'd0, 4'd2, 4'd0, 32'd56};//{'literal': 56, 'z': 2, 'op': 'literal'}
    instructions[173] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[174] = {4'd0, 4'd8, 4'd0, 32'd46};//{'literal': 46, 'z': 8, 'op': 'literal'}
    instructions[175] = {4'd0, 4'd2, 4'd0, 32'd57};//{'literal': 57, 'z': 2, 'op': 'literal'}
    instructions[176] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[177] = {4'd0, 4'd8, 4'd0, 32'd49};//{'literal': 49, 'z': 8, 'op': 'literal'}
    instructions[178] = {4'd0, 4'd2, 4'd0, 32'd58};//{'literal': 58, 'z': 2, 'op': 'literal'}
    instructions[179] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[180] = {4'd0, 4'd8, 4'd0, 32'd46};//{'literal': 46, 'z': 8, 'op': 'literal'}
    instructions[181] = {4'd0, 4'd2, 4'd0, 32'd59};//{'literal': 59, 'z': 2, 'op': 'literal'}
    instructions[182] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[183] = {4'd0, 4'd8, 4'd0, 32'd49};//{'literal': 49, 'z': 8, 'op': 'literal'}
    instructions[184] = {4'd0, 4'd2, 4'd0, 32'd60};//{'literal': 60, 'z': 2, 'op': 'literal'}
    instructions[185] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[186] = {4'd0, 4'd8, 4'd0, 32'd32};//{'literal': 32, 'z': 8, 'op': 'literal'}
    instructions[187] = {4'd0, 4'd2, 4'd0, 32'd61};//{'literal': 61, 'z': 2, 'op': 'literal'}
    instructions[188] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[189] = {4'd0, 4'd8, 4'd0, 32'd112};//{'literal': 112, 'z': 8, 'op': 'literal'}
    instructions[190] = {4'd0, 4'd2, 4'd0, 32'd62};//{'literal': 62, 'z': 2, 'op': 'literal'}
    instructions[191] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[192] = {4'd0, 4'd8, 4'd0, 32'd111};//{'literal': 111, 'z': 8, 'op': 'literal'}
    instructions[193] = {4'd0, 4'd2, 4'd0, 32'd63};//{'literal': 63, 'z': 2, 'op': 'literal'}
    instructions[194] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[195] = {4'd0, 4'd8, 4'd0, 32'd114};//{'literal': 114, 'z': 8, 'op': 'literal'}
    instructions[196] = {4'd0, 4'd2, 4'd0, 32'd64};//{'literal': 64, 'z': 2, 'op': 'literal'}
    instructions[197] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[198] = {4'd0, 4'd8, 4'd0, 32'd116};//{'literal': 116, 'z': 8, 'op': 'literal'}
    instructions[199] = {4'd0, 4'd2, 4'd0, 32'd65};//{'literal': 65, 'z': 2, 'op': 'literal'}
    instructions[200] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[201] = {4'd0, 4'd8, 4'd0, 32'd32};//{'literal': 32, 'z': 8, 'op': 'literal'}
    instructions[202] = {4'd0, 4'd2, 4'd0, 32'd66};//{'literal': 66, 'z': 2, 'op': 'literal'}
    instructions[203] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[204] = {4'd0, 4'd8, 4'd0, 32'd56};//{'literal': 56, 'z': 8, 'op': 'literal'}
    instructions[205] = {4'd0, 4'd2, 4'd0, 32'd67};//{'literal': 67, 'z': 2, 'op': 'literal'}
    instructions[206] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[207] = {4'd0, 4'd8, 4'd0, 32'd48};//{'literal': 48, 'z': 8, 'op': 'literal'}
    instructions[208] = {4'd0, 4'd2, 4'd0, 32'd68};//{'literal': 68, 'z': 2, 'op': 'literal'}
    instructions[209] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[210] = {4'd0, 4'd8, 4'd0, 32'd10};//{'literal': 10, 'z': 8, 'op': 'literal'}
    instructions[211] = {4'd0, 4'd2, 4'd0, 32'd69};//{'literal': 69, 'z': 2, 'op': 'literal'}
    instructions[212] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[213] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[214] = {4'd0, 4'd2, 4'd0, 32'd70};//{'literal': 70, 'z': 2, 'op': 'literal'}
    instructions[215] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[216] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[217] = {4'd0, 4'd2, 4'd0, 32'd71};//{'literal': 71, 'z': 2, 'op': 'literal'}
    instructions[218] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[219] = {4'd1, 4'd7, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 7, 'op': 'addl'}
    instructions[220] = {4'd1, 4'd4, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 4, 'op': 'addl'}
    instructions[221] = {4'd3, 4'd6, 4'd0, 32'd223};//{'z': 6, 'label': 223, 'op': 'call'}
    instructions[222] = {4'd4, 4'd0, 4'd0, 32'd0};//{'op': 'stop'}
    instructions[223] = {4'd1, 4'd3, 4'd3, 32'd839};//{'a': 3, 'literal': 839, 'z': 3, 'op': 'addl'}
    instructions[224] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[225] = {4'd1, 4'd2, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[226] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[227] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[228] = {4'd1, 4'd2, 4'd4, 32'd1};//{'a': 4, 'literal': 1, 'z': 2, 'op': 'addl'}
    instructions[229] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[230] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[231] = {4'd1, 4'd2, 4'd4, 32'd2};//{'a': 4, 'literal': 2, 'z': 2, 'op': 'addl'}
    instructions[232] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[233] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[234] = {4'd1, 4'd2, 4'd4, 32'd771};//{'a': 4, 'literal': 771, 'z': 2, 'op': 'addl'}
    instructions[235] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[236] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[237] = {4'd1, 4'd2, 4'd4, 32'd772};//{'a': 4, 'literal': 772, 'z': 2, 'op': 'addl'}
    instructions[238] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[239] = {4'd0, 4'd8, 4'd0, 32'd37};//{'literal': 37, 'z': 8, 'op': 'literal'}
    instructions[240] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[241] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[242] = {4'd0, 4'd2, 4'd0, 32'd38};//{'literal': 38, 'z': 2, 'op': 'literal'}
    instructions[243] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[244] = {4'd0, 4'd8, 4'd0, 32'd36};//{'literal': 36, 'z': 8, 'op': 'literal'}
    instructions[245] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[246] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[247] = {4'd0, 4'd2, 4'd0, 32'd34};//{'literal': 34, 'z': 2, 'op': 'literal'}
    instructions[248] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[249] = {4'd2, 4'd0, 4'd3, 32'd6};//{'a': 3, 'comment': 'push', 'b': 6, 'op': 'store'}
    instructions[250] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[251] = {4'd2, 4'd0, 4'd3, 32'd7};//{'a': 3, 'comment': 'push', 'b': 7, 'op': 'store'}
    instructions[252] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[253] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[254] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[255] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[256] = {4'd1, 4'd7, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 7, 'op': 'addl'}
    instructions[257] = {4'd1, 4'd4, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 4, 'op': 'addl'}
    instructions[258] = {4'd3, 4'd6, 4'd0, 32'd304};//{'z': 6, 'label': 304, 'op': 'call'}
    instructions[259] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[260] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[261] = {4'd5, 4'd7, 4'd3, 32'd0};//{'a': 3, 'z': 7, 'op': 'load'}
    instructions[262] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[263] = {4'd5, 4'd6, 4'd3, 32'd0};//{'a': 3, 'z': 6, 'op': 'load'}
    instructions[264] = {4'd1, 4'd3, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[265] = {4'd2, 4'd0, 4'd3, 32'd6};//{'a': 3, 'comment': 'push', 'b': 6, 'op': 'store'}
    instructions[266] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[267] = {4'd2, 4'd0, 4'd3, 32'd7};//{'a': 3, 'comment': 'push', 'b': 7, 'op': 'store'}
    instructions[268] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[269] = {4'd0, 4'd8, 4'd0, 32'd39};//{'literal': 39, 'z': 8, 'op': 'literal'}
    instructions[270] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[271] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[272] = {4'd1, 4'd7, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 7, 'op': 'addl'}
    instructions[273] = {4'd1, 4'd4, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 4, 'op': 'addl'}
    instructions[274] = {4'd3, 4'd6, 4'd0, 32'd304};//{'z': 6, 'label': 304, 'op': 'call'}
    instructions[275] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[276] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[277] = {4'd5, 4'd7, 4'd3, 32'd0};//{'a': 3, 'z': 7, 'op': 'load'}
    instructions[278] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[279] = {4'd5, 4'd6, 4'd3, 32'd0};//{'a': 3, 'z': 6, 'op': 'load'}
    instructions[280] = {4'd1, 4'd3, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[281] = {4'd0, 4'd8, 4'd0, 32'd35};//{'literal': 35, 'z': 8, 'op': 'literal'}
    instructions[282] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[283] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[284] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[285] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[286] = {4'd0, 4'd8, 4'd0, 32'd71};//{'literal': 71, 'z': 8, 'op': 'literal'}
    instructions[287] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[288] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[289] = {4'd6, 4'd8, 4'd8, 32'd0};//{'a': 8, 'z': 8, 'op': 'read'}
    instructions[290] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[291] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[292] = {4'd0, 4'd8, 4'd0, 32'd255};//{'literal': 255, 'z': 8, 'op': 'literal'}
    instructions[293] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[294] = {4'd5, 4'd10, 4'd3, 32'd0};//{'a': 3, 'z': 10, 'op': 'load'}
    instructions[295] = {4'd7, 4'd8, 4'd8, 32'd10};//{'a': 8, 'z': 8, 'b': 10, 'op': 'subtract'}
    instructions[296] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[297] = {4'd5, 4'd0, 4'd3, 32'd0};//{'a': 3, 'z': 0, 'op': 'load'}
    instructions[298] = {4'd8, 4'd0, 4'd0, 32'd8};//{'a': 0, 'b': 8, 'op': 'write'}
    instructions[299] = {4'd1, 4'd3, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[300] = {4'd9, 4'd0, 4'd0, 32'd281};//{'label': 281, 'op': 'goto'}
    instructions[301] = {4'd1, 4'd3, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[302] = {4'd1, 4'd4, 4'd7, 32'd0};//{'a': 7, 'literal': 0, 'z': 4, 'op': 'addl'}
    instructions[303] = {4'd10, 4'd0, 4'd6, 32'd0};//{'a': 6, 'op': 'return'}
    instructions[304] = {4'd1, 4'd3, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[305] = {4'd2, 4'd0, 4'd3, 32'd6};//{'a': 3, 'comment': 'push', 'b': 6, 'op': 'store'}
    instructions[306] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[307] = {4'd2, 4'd0, 4'd3, 32'd7};//{'a': 3, 'comment': 'push', 'b': 7, 'op': 'store'}
    instructions[308] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[309] = {4'd1, 4'd8, 4'd4, -32'd1};//{'a': 4, 'literal': -1, 'z': 8, 'op': 'addl'}
    instructions[310] = {4'd5, 4'd8, 4'd8, 32'd0};//{'a': 8, 'z': 8, 'op': 'load'}
    instructions[311] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[312] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[313] = {4'd0, 4'd8, 4'd0, 32'd38};//{'literal': 38, 'z': 8, 'op': 'literal'}
    instructions[314] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[315] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[316] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[317] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[318] = {4'd1, 4'd7, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 7, 'op': 'addl'}
    instructions[319] = {4'd1, 4'd4, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 4, 'op': 'addl'}
    instructions[320] = {4'd3, 4'd6, 4'd0, 32'd330};//{'z': 6, 'label': 330, 'op': 'call'}
    instructions[321] = {4'd1, 4'd3, 4'd3, -32'd2};//{'a': 3, 'literal': -2, 'z': 3, 'op': 'addl'}
    instructions[322] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[323] = {4'd5, 4'd7, 4'd3, 32'd0};//{'a': 3, 'z': 7, 'op': 'load'}
    instructions[324] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[325] = {4'd5, 4'd6, 4'd3, 32'd0};//{'a': 3, 'z': 6, 'op': 'load'}
    instructions[326] = {4'd1, 4'd3, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[327] = {4'd1, 4'd3, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[328] = {4'd1, 4'd4, 4'd7, 32'd0};//{'a': 7, 'literal': 0, 'z': 4, 'op': 'addl'}
    instructions[329] = {4'd10, 4'd0, 4'd6, 32'd0};//{'a': 6, 'op': 'return'}
    instructions[330] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[331] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[332] = {4'd1, 4'd2, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[333] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[334] = {4'd1, 4'd8, 4'd4, -32'd2};//{'a': 4, 'literal': -2, 'z': 8, 'op': 'addl'}
    instructions[335] = {4'd5, 4'd8, 4'd8, 32'd0};//{'a': 8, 'z': 8, 'op': 'load'}
    instructions[336] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[337] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[338] = {4'd1, 4'd8, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 8, 'op': 'addl'}
    instructions[339] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[340] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[341] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[342] = {4'd5, 4'd2, 4'd3, 32'd0};//{'a': 3, 'z': 2, 'op': 'load'}
    instructions[343] = {4'd11, 4'd8, 4'd8, 32'd2};//{'a': 8, 'z': 8, 'b': 2, 'op': 'add'}
    instructions[344] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[345] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[346] = {4'd12, 4'd0, 4'd8, 32'd387};//{'a': 8, 'label': 387, 'op': 'jmp_if_false'}
    instructions[347] = {4'd1, 4'd8, 4'd4, -32'd1};//{'a': 4, 'literal': -1, 'z': 8, 'op': 'addl'}
    instructions[348] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[349] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[350] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[351] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[352] = {4'd1, 4'd8, 4'd4, -32'd2};//{'a': 4, 'literal': -2, 'z': 8, 'op': 'addl'}
    instructions[353] = {4'd5, 4'd8, 4'd8, 32'd0};//{'a': 8, 'z': 8, 'op': 'load'}
    instructions[354] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[355] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[356] = {4'd1, 4'd8, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 8, 'op': 'addl'}
    instructions[357] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[358] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[359] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[360] = {4'd5, 4'd2, 4'd3, 32'd0};//{'a': 3, 'z': 2, 'op': 'load'}
    instructions[361] = {4'd11, 4'd8, 4'd8, 32'd2};//{'a': 8, 'z': 8, 'b': 2, 'op': 'add'}
    instructions[362] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[363] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[364] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[365] = {4'd5, 4'd0, 4'd3, 32'd0};//{'a': 3, 'z': 0, 'op': 'load'}
    instructions[366] = {4'd8, 4'd0, 4'd0, 32'd8};//{'a': 0, 'b': 8, 'op': 'write'}
    instructions[367] = {4'd1, 4'd3, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[368] = {4'd1, 4'd8, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 8, 'op': 'addl'}
    instructions[369] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[370] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[371] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[372] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[373] = {4'd0, 4'd8, 4'd0, 32'd1};//{'literal': 1, 'z': 8, 'op': 'literal'}
    instructions[374] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[375] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[376] = {4'd1, 4'd8, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 8, 'op': 'addl'}
    instructions[377] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[378] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[379] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[380] = {4'd5, 4'd10, 4'd3, 32'd0};//{'a': 3, 'z': 10, 'op': 'load'}
    instructions[381] = {4'd11, 4'd8, 4'd8, 32'd10};//{'a': 8, 'z': 8, 'b': 10, 'op': 'add'}
    instructions[382] = {4'd1, 4'd2, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[383] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[384] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[385] = {4'd5, 4'd8, 4'd3, 32'd0};//{'a': 3, 'z': 8, 'op': 'load'}
    instructions[386] = {4'd9, 4'd0, 4'd0, 32'd388};//{'label': 388, 'op': 'goto'}
    instructions[387] = {4'd9, 4'd0, 4'd0, 32'd389};//{'label': 389, 'op': 'goto'}
    instructions[388] = {4'd9, 4'd0, 4'd0, 32'd334};//{'label': 334, 'op': 'goto'}
    instructions[389] = {4'd1, 4'd3, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[390] = {4'd1, 4'd4, 4'd7, 32'd0};//{'a': 7, 'literal': 0, 'z': 4, 'op': 'addl'}
    instructions[391] = {4'd10, 4'd0, 4'd6, 32'd0};//{'a': 6, 'op': 'return'}
  end

  
  always @(posedge clk)
  begin
    load_data <= memory[load_address];
    if(store_enable && state == execute) begin
      memory[store_address] <= store_data;
    end
  end


  //////////////////////////////////////////////////////////////////////////////
  // PIPELINE STAGE 1 -- FETCH INSTRUCTION
  //                                                                            
  
  always @(posedge clk)
  begin
    //implement memory for instructions
    if (state == instruction_fetch || state == operand_fetch || state == execute) begin
      instruction <= instructions[program_counter];
      program_counter_1 <= program_counter;
    end
  end

  assign opcode    = instruction[43:40];
  assign address_z = instruction[39:36];
  assign address_a = instruction[35:32];
  assign address_b = instruction[3:0];
  assign literal   = instruction[31:0];

  //////////////////////////////////////////////////////////////////////////////
  // PIPELINE STAGE 2 -- FETCH OPERANDS
  //                                                                            
  
  always @(posedge clk)
  begin
    if (write_enable) begin
      registers[address_z_3] <= result;
    end
    if (state == operand_fetch || state == execute) begin
      opcode_2 <= opcode;
      literal_2 <= literal;
      address_a_2 <= address_a;
      address_b_2 <= address_b;
      address_z_2 <= address_z;
      program_counter_2 <= program_counter_1;
    end
  end
  assign register_a = registers[address_a_2];
  assign register_b = registers[address_b_2];
  assign operand_a = (address_a_2 == address_z_3 && write_enable)?result:register_a;
  assign operand_b = (address_b_2 == address_z_3 && write_enable)?result:register_b;
  assign store_address = operand_a;
  assign load_address = operand_a;
  assign store_data = operand_b;
  assign store_enable = (opcode_2==2);

  //////////////////////////////////////////////////////////////////////////////
  // PIPELINE STAGE 3 -- EXECUTE
  //                                                                            
  
  always @(posedge clk)
  begin

  write_enable <= 0;
  case(state)

    //instruction_fetch
    instruction_fetch: begin
      program_counter <= program_counter + 1;
      state <= operand_fetch;
    end
    //operand_fetch
    operand_fetch: begin
      program_counter <= program_counter + 1;
      state <= execute;
    end
    //execute
    execute: begin
      program_counter <= program_counter + 1;
      address_z_3 <= address_z_2;
      case(opcode_2)

        //literal
        16'd0:
        begin
          result<=literal_2;
          write_enable <= 1;
        end

        //addl
        16'd1:
        begin
          result<=operand_a + literal_2;
          write_enable <= 1;
        end

        //store
        16'd2:
        begin
        end

        //call
        16'd3:
        begin
          result <= program_counter_2 + 1;
          write_enable <= 1;
          program_counter <= literal_2;
          state <= instruction_fetch;
        end

        //stop
        16'd4:
        begin
        state <= stop;
        end

        //load
        16'd5:
        begin
          state <= load;
        end

        //read
        16'd6:
        begin
          state <= read;
          read_input <= operand_a;
        end

        //subtract
        16'd7:
        begin
          long_result = operand_a + (~operand_b) + 1;
          result <= long_result[31:0];
          carry[0] <= ~long_result[32];
          write_enable <= 1;
        end

        //write
        16'd8:
        begin
          state <= write;
          write_output <= operand_a;
          write_value <= operand_b;
        end

        //goto
        16'd9:
        begin
          program_counter <= literal_2;
          state <= instruction_fetch;
        end

        //return
        16'd10:
        begin
          program_counter <= operand_a;
          state <= instruction_fetch;
        end

        //add
        16'd11:
        begin
          long_result = operand_a + operand_b;
          result <= long_result[31:0];
          carry[0] <= long_result[32];
          write_enable <= 1;
        end

        //jmp_if_false
        16'd12:
        begin
          if (operand_a == 0) begin
            program_counter <= literal_2;
            state <= instruction_fetch;
          end
        end

      endcase

    end

    read:
    begin
      case(read_input)
      0:
      begin
        s_input_socket_ack <= 1;
        if (s_input_socket_ack && input_socket_stb) begin
          result <= input_socket;
          write_enable <= 1;
          s_input_socket_ack <= 0;
          state <= execute;
        end
      end
      3:
      begin
        s_input_rs232_rx_ack <= 1;
        if (s_input_rs232_rx_ack && input_rs232_rx_stb) begin
          result <= input_rs232_rx;
          write_enable <= 1;
          s_input_rs232_rx_ack <= 0;
          state <= execute;
        end
      end
      4:
      begin
        s_input_timer_ack <= 1;
        if (s_input_timer_ack && input_timer_stb) begin
          result <= input_timer;
          write_enable <= 1;
          s_input_timer_ack <= 0;
          state <= execute;
        end
      end
      5:
      begin
        s_input_switches_ack <= 1;
        if (s_input_switches_ack && input_switches_stb) begin
          result <= input_switches;
          write_enable <= 1;
          s_input_switches_ack <= 0;
          state <= execute;
        end
      end
      6:
      begin
        s_input_buttons_ack <= 1;
        if (s_input_buttons_ack && input_buttons_stb) begin
          result <= input_buttons;
          write_enable <= 1;
          s_input_buttons_ack <= 0;
          state <= execute;
        end
      end
      endcase
    end

    write:
    begin
      case(write_output)
      1:
      begin
        s_output_socket_stb <= 1;
        s_output_socket <= write_value;
        if (output_socket_ack && s_output_socket_stb) begin
          s_output_socket_stb <= 0;
          state <= execute;
        end
      end
      2:
      begin
        s_output_rs232_tx_stb <= 1;
        s_output_rs232_tx <= write_value;
        if (output_rs232_tx_ack && s_output_rs232_tx_stb) begin
          s_output_rs232_tx_stb <= 0;
          state <= execute;
        end
      end
      7:
      begin
        s_output_leds_stb <= 1;
        s_output_leds <= write_value;
        if (output_leds_ack && s_output_leds_stb) begin
          s_output_leds_stb <= 0;
          state <= execute;
        end
      end
      endcase
    end

    load:
    begin
        result <= load_data;
        write_enable <= 1;
        state <= execute;
    end

    wait_state:
    begin
      if (timer) begin
        timer <= timer - 1;
      end else begin
        state <= execute;
      end
    end

    stop:
    begin
    end

    endcase

    if (rst == 1'b1) begin
      timer <= 0;
      program_counter <= 0;
      address_z_3 <= 0;
      result <= 0;
      a = 0;
      b = 0;
      z = 0;
      state <= instruction_fetch;
      s_input_socket_ack <= 0;
      s_input_rs232_rx_ack <= 0;
      s_input_timer_ack <= 0;
      s_input_switches_ack <= 0;
      s_input_buttons_ack <= 0;
      s_output_socket_stb <= 0;
      s_output_rs232_tx_stb <= 0;
      s_output_leds_stb <= 0;
    end
  end
  assign input_socket_ack = s_input_socket_ack;
  assign input_rs232_rx_ack = s_input_rs232_rx_ack;
  assign input_timer_ack = s_input_timer_ack;
  assign input_switches_ack = s_input_switches_ack;
  assign input_buttons_ack = s_input_buttons_ack;
  assign output_socket_stb = s_output_socket_stb;
  assign output_socket = s_output_socket;
  assign output_rs232_tx_stb = s_output_rs232_tx_stb;
  assign output_rs232_tx = s_output_rs232_tx;
  assign output_leds_stb = s_output_leds_stb;
  assign output_leds = s_output_leds;

endmodule
