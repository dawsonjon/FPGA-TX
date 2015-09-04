//////////////////////////////////////////////////////////////////////////////
//name : arbiter
//input : input_in1:16
//input : input_in2:16
//output : output_out:16
//source_file : /media/storage/Projects/Chips-Demo/demo/examples/image_processor/arbiter.c
///=======
///
///Created by C2CHIP

module arbiter(input_in1,input_in2,input_in1_stb,input_in2_stb,output_out_ack,clk,rst,output_out,output_out_stb,input_in1_ack,input_in2_ack,exception);
  integer file_count;
  parameter  stop = 3'd0,
  instruction_fetch = 3'd1,
  operand_fetch = 3'd2,
  execute = 3'd3,
  load = 3'd4,
  wait_state = 3'd5,
  read = 3'd6,
  write = 3'd7;
  input [31:0] input_in1;
  input [31:0] input_in2;
  input input_in1_stb;
  input input_in2_stb;
  input output_out_ack;
  input clk;
  input rst;
  output [31:0] output_out;
  output output_out_stb;
  output input_in1_ack;
  output input_in2_ack;
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
  reg [31:0] s_output_out_stb;
  reg [31:0] s_output_out;
  reg [31:0] s_input_in1_ack;
  reg [31:0] s_input_in2_ack;
  reg [7:0] state;
  output reg exception;
  reg [43:0] instructions [97:0];
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
  // 6 {'literal': False, 'op': 'ready'}
  // 7 {'literal': True, 'op': 'jmp_if_false'}
  // 8 {'literal': False, 'op': 'read'}
  // 9 {'literal': False, 'op': 'write'}
  // 10 {'literal': False, 'op': 'equal'}
  // 11 {'literal': True, 'op': 'goto'}
  // 12 {'literal': False, 'op': 'return'}
  // Intructions
  // ===========
  
  initial
  begin
    instructions[0] = {4'd0, 4'd3, 4'd0, 32'd0};//{'literal': 0, 'z': 3, 'op': 'literal'}
    instructions[1] = {4'd0, 4'd4, 4'd0, 32'd0};//{'literal': 0, 'z': 4, 'op': 'literal'}
    instructions[2] = {4'd1, 4'd3, 4'd3, 32'd3};//{'a': 3, 'literal': 3, 'z': 3, 'op': 'addl'}
    instructions[3] = {4'd0, 4'd8, 4'd0, 32'd1};//{'literal': 1, 'z': 8, 'op': 'literal'}
    instructions[4] = {4'd0, 4'd2, 4'd0, 32'd0};//{'literal': 0, 'z': 2, 'op': 'literal'}
    instructions[5] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[6] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[7] = {4'd0, 4'd2, 4'd0, 32'd1};//{'literal': 1, 'z': 2, 'op': 'literal'}
    instructions[8] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[9] = {4'd0, 4'd8, 4'd0, 32'd2};//{'literal': 2, 'z': 8, 'op': 'literal'}
    instructions[10] = {4'd0, 4'd2, 4'd0, 32'd2};//{'literal': 2, 'z': 2, 'op': 'literal'}
    instructions[11] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[12] = {4'd1, 4'd7, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 7, 'op': 'addl'}
    instructions[13] = {4'd1, 4'd4, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 4, 'op': 'addl'}
    instructions[14] = {4'd3, 4'd6, 4'd0, 32'd16};//{'z': 6, 'label': 16, 'op': 'call'}
    instructions[15] = {4'd4, 4'd0, 4'd0, 32'd0};//{'op': 'stop'}
    instructions[16] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[17] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[18] = {4'd1, 4'd2, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[19] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[20] = {4'd0, 4'd8, 4'd0, 32'd1};//{'literal': 1, 'z': 8, 'op': 'literal'}
    instructions[21] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[22] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[23] = {4'd6, 4'd8, 4'd8, 32'd0};//{'a': 8, 'z': 8, 'op': 'ready'}
    instructions[24] = {4'd7, 4'd0, 4'd8, 32'd57};//{'a': 8, 'label': 57, 'op': 'jmp_if_false'}
    instructions[25] = {4'd0, 4'd8, 4'd0, 32'd1};//{'literal': 1, 'z': 8, 'op': 'literal'}
    instructions[26] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[27] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[28] = {4'd8, 4'd8, 4'd8, 32'd0};//{'a': 8, 'z': 8, 'op': 'read'}
    instructions[29] = {4'd1, 4'd2, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[30] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[31] = {4'd0, 4'd8, 4'd0, 32'd2};//{'literal': 2, 'z': 8, 'op': 'literal'}
    instructions[32] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[33] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[34] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[35] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[36] = {4'd1, 4'd8, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 8, 'op': 'addl'}
    instructions[37] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[38] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[39] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[40] = {4'd5, 4'd0, 4'd3, 32'd0};//{'a': 3, 'z': 0, 'op': 'load'}
    instructions[41] = {4'd9, 4'd0, 4'd0, 32'd8};//{'a': 0, 'b': 8, 'op': 'write'}
    instructions[42] = {4'd1, 4'd3, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[43] = {4'd0, 4'd8, 4'd0, 32'd10};//{'literal': 10, 'z': 8, 'op': 'literal'}
    instructions[44] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[45] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[46] = {4'd1, 4'd8, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 8, 'op': 'addl'}
    instructions[47] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[48] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[49] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[50] = {4'd5, 4'd10, 4'd3, 32'd0};//{'a': 3, 'z': 10, 'op': 'load'}
    instructions[51] = {4'd10, 4'd8, 4'd8, 32'd10};//{'a': 8, 'z': 8, 'b': 10, 'op': 'equal'}
    instructions[52] = {4'd7, 4'd0, 4'd8, 32'd55};//{'a': 8, 'label': 55, 'op': 'jmp_if_false'}
    instructions[53] = {4'd11, 4'd0, 4'd0, 32'd56};//{'label': 56, 'op': 'goto'}
    instructions[54] = {4'd11, 4'd0, 4'd0, 32'd55};//{'label': 55, 'op': 'goto'}
    instructions[55] = {4'd11, 4'd0, 4'd0, 32'd25};//{'label': 25, 'op': 'goto'}
    instructions[56] = {4'd11, 4'd0, 4'd0, 32'd57};//{'label': 57, 'op': 'goto'}
    instructions[57] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[58] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[59] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[60] = {4'd6, 4'd8, 4'd8, 32'd0};//{'a': 8, 'z': 8, 'op': 'ready'}
    instructions[61] = {4'd7, 4'd0, 4'd8, 32'd94};//{'a': 8, 'label': 94, 'op': 'jmp_if_false'}
    instructions[62] = {4'd0, 4'd8, 4'd0, 32'd0};//{'literal': 0, 'z': 8, 'op': 'literal'}
    instructions[63] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[64] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[65] = {4'd8, 4'd8, 4'd8, 32'd0};//{'a': 8, 'z': 8, 'op': 'read'}
    instructions[66] = {4'd1, 4'd2, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[67] = {4'd2, 4'd0, 4'd2, 32'd8};//{'a': 2, 'b': 8, 'op': 'store'}
    instructions[68] = {4'd0, 4'd8, 4'd0, 32'd2};//{'literal': 2, 'z': 8, 'op': 'literal'}
    instructions[69] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[70] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[71] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[72] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[73] = {4'd1, 4'd8, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 8, 'op': 'addl'}
    instructions[74] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[75] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[76] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[77] = {4'd5, 4'd0, 4'd3, 32'd0};//{'a': 3, 'z': 0, 'op': 'load'}
    instructions[78] = {4'd9, 4'd0, 4'd0, 32'd8};//{'a': 0, 'b': 8, 'op': 'write'}
    instructions[79] = {4'd1, 4'd3, 4'd3, 32'd0};//{'a': 3, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[80] = {4'd0, 4'd8, 4'd0, 32'd10};//{'literal': 10, 'z': 8, 'op': 'literal'}
    instructions[81] = {4'd2, 4'd0, 4'd3, 32'd8};//{'a': 3, 'comment': 'push', 'b': 8, 'op': 'store'}
    instructions[82] = {4'd1, 4'd3, 4'd3, 32'd1};//{'a': 3, 'literal': 1, 'z': 3, 'op': 'addl'}
    instructions[83] = {4'd1, 4'd8, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 8, 'op': 'addl'}
    instructions[84] = {4'd1, 4'd2, 4'd8, 32'd0};//{'a': 8, 'literal': 0, 'z': 2, 'op': 'addl'}
    instructions[85] = {4'd5, 4'd8, 4'd2, 32'd0};//{'a': 2, 'z': 8, 'op': 'load'}
    instructions[86] = {4'd1, 4'd3, 4'd3, -32'd1};//{'a': 3, 'comment': 'pop', 'literal': -1, 'z': 3, 'op': 'addl'}
    instructions[87] = {4'd5, 4'd10, 4'd3, 32'd0};//{'a': 3, 'z': 10, 'op': 'load'}
    instructions[88] = {4'd10, 4'd8, 4'd8, 32'd10};//{'a': 8, 'z': 8, 'b': 10, 'op': 'equal'}
    instructions[89] = {4'd7, 4'd0, 4'd8, 32'd92};//{'a': 8, 'label': 92, 'op': 'jmp_if_false'}
    instructions[90] = {4'd11, 4'd0, 4'd0, 32'd93};//{'label': 93, 'op': 'goto'}
    instructions[91] = {4'd11, 4'd0, 4'd0, 32'd92};//{'label': 92, 'op': 'goto'}
    instructions[92] = {4'd11, 4'd0, 4'd0, 32'd62};//{'label': 62, 'op': 'goto'}
    instructions[93] = {4'd11, 4'd0, 4'd0, 32'd94};//{'label': 94, 'op': 'goto'}
    instructions[94] = {4'd11, 4'd0, 4'd0, 32'd20};//{'label': 20, 'op': 'goto'}
    instructions[95] = {4'd1, 4'd3, 4'd4, 32'd0};//{'a': 4, 'literal': 0, 'z': 3, 'op': 'addl'}
    instructions[96] = {4'd1, 4'd4, 4'd7, 32'd0};//{'a': 7, 'literal': 0, 'z': 4, 'op': 'addl'}
    instructions[97] = {4'd12, 4'd0, 4'd6, 32'd0};//{'a': 6, 'op': 'return'}
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

        //ready
        16'd6:
        begin
          result <= 0;
          case(operand_a)

            0:
            begin
              result[0] <= input_in1_stb;
            end
            1:
            begin
              result[0] <= input_in2_stb;
            end
          endcase
          write_enable <= 1;
        end

        //jmp_if_false
        16'd7:
        begin
          if (operand_a == 0) begin
            program_counter <= literal_2;
            state <= instruction_fetch;
          end
        end

        //read
        16'd8:
        begin
          state <= read;
          read_input <= operand_a;
        end

        //write
        16'd9:
        begin
          state <= write;
          write_output <= operand_a;
          write_value <= operand_b;
        end

        //equal
        16'd10:
        begin
          result <= operand_a == operand_b;
          write_enable <= 1;
        end

        //goto
        16'd11:
        begin
          program_counter <= literal_2;
          state <= instruction_fetch;
        end

        //return
        16'd12:
        begin
          program_counter <= operand_a;
          state <= instruction_fetch;
        end

      endcase

    end

    read:
    begin
      case(read_input)
      0:
      begin
        s_input_in1_ack <= 1;
        if (s_input_in1_ack && input_in1_stb) begin
          result <= input_in1;
          write_enable <= 1;
          s_input_in1_ack <= 0;
          state <= execute;
        end
      end
      1:
      begin
        s_input_in2_ack <= 1;
        if (s_input_in2_ack && input_in2_stb) begin
          result <= input_in2;
          write_enable <= 1;
          s_input_in2_ack <= 0;
          state <= execute;
        end
      end
      endcase
    end

    write:
    begin
      case(write_output)
      2:
      begin
        s_output_out_stb <= 1;
        s_output_out <= write_value;
        if (output_out_ack && s_output_out_stb) begin
          s_output_out_stb <= 0;
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
      s_input_in1_ack <= 0;
      s_input_in2_ack <= 0;
      s_output_out_stb <= 0;
    end
  end
  assign input_in1_ack = s_input_in1_ack;
  assign input_in2_ack = s_input_in2_ack;
  assign output_out_stb = s_output_out_stb;
  assign output_out = s_output_out;

endmodule
