//name : HTTP_test
//tag : c components
//source_file : HTTP_test.c
///Http_Test
///=========
///
///*Created by C2CHIP*

  
`timescale 1ns/1ps
module HTTP_test;
  integer file_count;
  integer output_file_0;
  reg       [15:0] timer;
  reg       [7:0] program_counter;
  reg       [15:0] address;
  reg       [15:0] data_out;
  reg       [15:0] data_in;
  reg       write_enable;
  reg       [15:0] register_0;
  reg       [15:0] register_1;
  reg       [15:0] register_2;
  reg       [15:0] register_3;
  reg       [15:0] register_4;
  reg       [15:0] register_5;
  reg       [15:0] register_6;
  reg       [15:0] register_7;
  reg       [15:0] register_8;
  reg       [15:0] register_9;
  reg       [15:0] register_10;
  reg       [15:0] register_11;
  reg       [15:0] register_12;
  reg       [15:0] register_13;
  reg       [15:0] register_14;
  reg       [15:0] register_15;
  reg       [15:0] register_16;
  reg       [15:0] register_17;
  reg       [15:0] register_18;
  reg       [15:0] register_19;
  reg       [15:0] register_20;
  reg       [15:0] register_21;
  reg       [15:0] register_22;
  reg       [15:0] register_23;
  reg       [15:0] register_24;
  reg       [15:0] register_25;
  reg       [15:0] register_26;
  reg       [15:0] register_27;
  reg       [15:0] register_28;
  reg       [15:0] register_29;
  reg       [15:0] register_30;
  reg       [15:0] register_31;
  reg       [15:0] register_32;
  reg       [15:0] register_33;
  reg       [15:0] register_34;
  reg       [15:0] register_35;
  reg       [15:0] register_36;
  reg       [15:0] register_37;
  reg       [15:0] register_38;
  reg       [15:0] register_39;
  reg       [15:0] register_40;
  reg       [15:0] register_41;
  reg       [15:0] register_42;
  reg       [15:0] register_43;
  reg       [15:0] register_44;
  reg       [15:0] register_45;
  reg       [15:0] register_46;
  reg       [15:0] register_47;
  reg       [15:0] register_48;
  reg       [15:0] register_49;
  reg       [15:0] register_50;
  reg       [15:0] register_51;
  reg       [15:0] register_52;
  reg       [15:0] register_53;
  reg       [15:0] register_54;
  reg       [15:0] register_55;
  reg       [15:0] register_56;
  reg       [15:0] register_57;
  reg       [15:0] register_58;
  reg       [15:0] register_59;
  reg       [15:0] register_60;
  reg       [15:0] register_61;
  reg       [15:0] register_62;
  reg       [15:0] register_63;
  reg       [15:0] register_64;
  reg       [15:0] register_65;
  reg       [15:0] register_66;
  reg       [15:0] register_67;
  reg       [15:0] register_68;
  reg       [15:0] register_69;
  reg       [15:0] register_70;
  reg       [15:0] register_71;
  reg       [15:0] register_72;
  reg       [15:0] register_73;
  reg       [15:0] register_74;
  reg       [15:0] register_75;
  reg       [15:0] register_76;
  reg       [15:0] register_77;
  reg       [15:0] register_78;
  reg       [15:0] register_79;
  reg       [15:0] register_80;
  reg       [15:0] register_81;
  reg       [15:0] register_82;
  reg       [15:0] register_83;
  reg       [15:0] register_84;
  reg       [15:0] register_85;
  reg       [15:0] register_86;
  reg       [15:0] register_87;
  reg       [15:0] register_88;
  reg       [15:0] register_89;
  reg       [15:0] register_90;
  reg       [15:0] register_91;
  reg       [15:0] register_92;
  reg       [15:0] register_93;
  reg       [15:0] register_94;
  reg       [15:0] register_95;
  reg       [15:0] register_96;
  reg       [15:0] register_97;
  reg       [15:0] register_98;
  reg       [15:0] register_99;
  reg       [15:0] register_100;
  reg       [15:0] register_101;
  reg       [15:0] register_102;
  reg       [15:0] register_103;
  reg       [15:0] register_104;
  reg       [15:0] register_105;
  reg       [15:0] register_106;
  reg       [15:0] register_107;
  reg       [15:0] register_108;
  reg       [15:0] register_109;
  reg       [15:0] register_110;
  reg       [15:0] register_111;
  reg       [15:0] register_112;
  reg       [15:0] register_113;
  reg       [15:0] register_114;
  reg       clk;
  reg       rst;
  reg [15:0] memory [133:0];

  //////////////////////////////////////////////////////////////////////////////
  // CLOCK AND RESET GENERATION                                                 
  //                                                                            
  // This file was generated in test bench mode. In this mode, the verilog      
  // output file can be executed directly within a verilog simulator.           
  // In test bench mode, a simulated clock and reset signal are generated within
  // the output file.                                                           
  // Verilog files generated in testbecnch mode are not suitable for synthesis, 
  // or for instantiation within a larger design.
  
  initial
  begin
    rst <= 1'b1;
    #50 rst <= 1'b0;
  end

  
  initial
  begin
    clk <= 1'b0;
    while (1) begin
      #5 clk <= ~clk;
    end
  end


  //////////////////////////////////////////////////////////////////////////////
  // MEMORY INITIALIZATION                                                      
  //                                                                            
  // In order to reduce program size, array contents have been stored into      
  // memory at initialization. In an FPGA, this will result in the memory being 
  // initialized when the FPGA configures.                                      
  // Memory will not be re-initialized at reset.                                
  // Dissable this behaviour using the no_initialize_memory switch              
  
  initial
  begin
    memory[16'd0] = 16'd72;
    memory[16'd1] = 16'd84;
    memory[16'd2] = 16'd84;
    memory[16'd3] = 16'd80;
    memory[16'd4] = 16'd47;
    memory[16'd5] = 16'd49;
    memory[16'd6] = 16'd46;
    memory[16'd7] = 16'd49;
    memory[16'd8] = 16'd32;
    memory[16'd9] = 16'd50;
    memory[16'd10] = 16'd48;
    memory[16'd11] = 16'd48;
    memory[16'd12] = 16'd32;
    memory[16'd13] = 16'd79;
    memory[16'd14] = 16'd75;
    memory[16'd15] = 16'd13;
    memory[16'd16] = 16'd10;
    memory[16'd17] = 16'd32;
    memory[16'd18] = 16'd68;
    memory[16'd19] = 16'd97;
    memory[16'd20] = 16'd116;
    memory[16'd21] = 16'd101;
    memory[16'd22] = 16'd58;
    memory[16'd23] = 16'd32;
    memory[16'd24] = 16'd84;
    memory[16'd25] = 16'd104;
    memory[16'd26] = 16'd117;
    memory[16'd27] = 16'd32;
    memory[16'd28] = 16'd79;
    memory[16'd29] = 16'd99;
    memory[16'd30] = 16'd116;
    memory[16'd31] = 16'd32;
    memory[16'd32] = 16'd51;
    memory[16'd33] = 16'd49;
    memory[16'd34] = 16'd32;
    memory[16'd35] = 16'd49;
    memory[16'd36] = 16'd57;
    memory[16'd37] = 16'd58;
    memory[16'd38] = 16'd49;
    memory[16'd39] = 16'd54;
    memory[16'd40] = 16'd58;
    memory[16'd41] = 16'd48;
    memory[16'd42] = 16'd48;
    memory[16'd43] = 16'd32;
    memory[16'd44] = 16'd50;
    memory[16'd45] = 16'd48;
    memory[16'd46] = 16'd49;
    memory[16'd47] = 16'd51;
    memory[16'd48] = 16'd13;
    memory[16'd49] = 16'd10;
    memory[16'd50] = 16'd32;
    memory[16'd51] = 16'd83;
    memory[16'd52] = 16'd101;
    memory[16'd53] = 16'd114;
    memory[16'd54] = 16'd118;
    memory[16'd55] = 16'd101;
    memory[16'd56] = 16'd114;
    memory[16'd57] = 16'd58;
    memory[16'd58] = 16'd32;
    memory[16'd59] = 16'd99;
    memory[16'd60] = 16'd104;
    memory[16'd61] = 16'd105;
    memory[16'd62] = 16'd112;
    memory[16'd63] = 16'd115;
    memory[16'd64] = 16'd45;
    memory[16'd65] = 16'd119;
    memory[16'd66] = 16'd101;
    memory[16'd67] = 16'd98;
    memory[16'd68] = 16'd47;
    memory[16'd69] = 16'd48;
    memory[16'd70] = 16'd46;
    memory[16'd71] = 16'd48;
    memory[16'd72] = 16'd13;
    memory[16'd73] = 16'd10;
    memory[16'd74] = 16'd32;
    memory[16'd75] = 16'd67;
    memory[16'd76] = 16'd111;
    memory[16'd77] = 16'd110;
    memory[16'd78] = 16'd116;
    memory[16'd79] = 16'd101;
    memory[16'd80] = 16'd110;
    memory[16'd81] = 16'd116;
    memory[16'd82] = 16'd45;
    memory[16'd83] = 16'd84;
    memory[16'd84] = 16'd121;
    memory[16'd85] = 16'd112;
    memory[16'd86] = 16'd101;
    memory[16'd87] = 16'd58;
    memory[16'd88] = 16'd32;
    memory[16'd89] = 16'd116;
    memory[16'd90] = 16'd101;
    memory[16'd91] = 16'd120;
    memory[16'd92] = 16'd116;
    memory[16'd93] = 16'd47;
    memory[16'd94] = 16'd104;
    memory[16'd95] = 16'd116;
    memory[16'd96] = 16'd109;
    memory[16'd97] = 16'd108;
    memory[16'd98] = 16'd13;
    memory[16'd99] = 16'd10;
    memory[16'd100] = 16'd32;
    memory[16'd101] = 16'd67;
    memory[16'd102] = 16'd111;
    memory[16'd103] = 16'd110;
    memory[16'd104] = 16'd116;
    memory[16'd105] = 16'd101;
    memory[16'd106] = 16'd110;
    memory[16'd107] = 16'd116;
    memory[16'd108] = 16'd45;
    memory[16'd109] = 16'd76;
    memory[16'd110] = 16'd101;
    memory[16'd111] = 16'd110;
    memory[16'd112] = 16'd103;
    memory[16'd113] = 16'd116;
    memory[16'd114] = 16'd104;
    memory[16'd115] = 16'd58;
    memory[16'd116] = 16'd32;
    memory[16'd117] = 16'd0;
    memory[16'd118] = 16'd13;
    memory[16'd119] = 16'd10;
    memory[16'd120] = 16'd13;
    memory[16'd121] = 16'd10;
    memory[16'd122] = 16'd0;
    memory[16'd123] = 16'd49;
    memory[16'd124] = 16'd50;
    memory[16'd125] = 16'd51;
    memory[16'd126] = 16'd52;
    memory[16'd127] = 16'd53;
    memory[16'd128] = 16'd54;
    memory[16'd129] = 16'd55;
    memory[16'd130] = 16'd56;
    memory[16'd131] = 16'd57;
    memory[16'd132] = 16'd48;
    memory[16'd133] = 16'd0;
  end

  
  initial
  begin
    output_file_0 = $fopen("packet");
  end


  //////////////////////////////////////////////////////////////////////////////
  // FSM IMPLEMENTAION OF C PROCESS                                             
  //                                                                            
  // This section of the file contains a Finite State Machine (FSM) implementing
  // the C process. In general execution is sequential, but the compiler will   
  // attempt to execute instructions in parallel if the instruction dependencies
  // allow. Further concurrency can be achieved by executing multiple C         
  // processes concurrently within the device.                                  
  
  always @(posedge clk)
  begin

    if (write_enable == 1'b1) begin
      memory[address] <= data_in;
    end

    data_out <= memory[address];
    write_enable <= 1'b0;
    timer <= 16'h0000;

    case(program_counter)

      16'd0:
      begin
        program_counter <= 16'd1;
        register_3 <= 16'd1;
        register_4 <= 16'd0;
        program_counter <= 16'd192;
        register_29 <= 16'd1;
      end

      16'd1:
      begin
        program_counter <= 16'd3;
        $fclose(output_file_0);
        $finish;
        program_counter <= program_counter;
      end

      16'd3:
      begin
        program_counter <= 16'd2;
        register_32 <= register_2;
        register_1 <= 16'd0;
      end

      16'd2:
      begin
        program_counter <= 16'd6;
        $fdisplay(output_file_0, "%d", register_32);
        program_counter <= register_0;
      end

      16'd6:
      begin
        program_counter <= 16'd7;
        register_33 <= register_3;
      end

      16'd7:
      begin
        program_counter <= 16'd5;
        if (register_33 == 16'h0000)
          program_counter <= 13;
      end

      16'd5:
      begin
        program_counter <= 16'd4;
        register_34 <= 16'd0;
        register_36 <= register_7;
      end

      16'd4:
      begin
        program_counter <= 16'd12;
        register_3 <= register_34;
        register_35 <= $signed(register_36) << $signed(16'd8);
      end

      16'd12:
      begin
        program_counter <= 16'd13;
        register_4 <= register_35;
        program_counter <= 16'd8;
      end

      16'd13:
      begin
        program_counter <= 16'd15;
        register_37 <= 16'd1;
        register_39 <= register_4;
        register_42 <= register_7;
      end

      16'd15:
      begin
        program_counter <= 16'd14;
        register_3 <= register_37;
        register_41 <= $signed(register_42) & $signed(16'd255);
      end

      16'd14:
      begin
        program_counter <= 16'd10;
        register_38 <= $unsigned(register_39) | $unsigned(register_41);
      end

      16'd10:
      begin
        program_counter <= 16'd11;
        register_4 <= register_38;
      end

      16'd11:
      begin
        program_counter <= 16'd9;
        register_2 <= register_4;
        program_counter <= 16'd3;
        register_0 <= 16'd9;
      end

      16'd9:
      begin
        program_counter <= 16'd8;
        register_43 <= register_1;
      end

      16'd8:
      begin
        program_counter <= 16'd24;
        register_6 <= 16'd0;
        program_counter <= register_5;
      end

      16'd24:
      begin
        program_counter <= 16'd25;
        register_45 <= register_3;
      end

      16'd25:
      begin
        program_counter <= 16'd27;
        register_44 <= $unsigned(register_45) == $unsigned(16'd0);
      end

      16'd27:
      begin
        program_counter <= 16'd26;
        if (register_44 == 16'h0000)
          program_counter <= 31;
      end

      16'd26:
      begin
        program_counter <= 16'd30;
        register_2 <= register_4;
        program_counter <= 16'd3;
        register_0 <= 16'd30;
      end

      16'd30:
      begin
        program_counter <= 16'd31;
        register_46 <= register_1;
        program_counter <= 16'd31;
      end

      16'd31:
      begin
        program_counter <= 16'd29;
        register_47 <= 16'd1;
        register_9 <= 16'd0;
      end

      16'd29:
      begin
        program_counter <= 16'd28;
        register_3 <= register_47;
        program_counter <= register_8;
      end

      16'd28:
      begin
        program_counter <= 16'd20;
        register_13 <= 16'd0;
      end

      16'd20:
      begin
        program_counter <= 16'd21;
        register_49 <= register_13;
      end

      16'd21:
      begin
        program_counter <= 16'd23;
        register_50 <= $unsigned(register_49) + $unsigned(register_12);
      end

      16'd23:
      begin
        program_counter <= 16'd22;
        address <= register_50;
      end

      16'd22:
      begin
        program_counter <= 16'd18;
      end

      16'd18:
      begin
        program_counter <= 16'd19;
        register_48 <= data_out;
      end

      16'd19:
      begin
        program_counter <= 16'd17;
        if (register_48 == 16'h0000)
          program_counter <= 53;
      end

      16'd17:
      begin
        program_counter <= 16'd16;
        register_52 <= register_13;
      end

      16'd16:
      begin
        program_counter <= 16'd48;
        register_53 <= $unsigned(register_52) + $unsigned(register_12);
      end

      16'd48:
      begin
        program_counter <= 16'd49;
        address <= register_53;
      end

      16'd49:
      begin
        program_counter <= 16'd51;
      end

      16'd51:
      begin
        program_counter <= 16'd50;
        register_7 <= data_out;
        program_counter <= 16'd6;
        register_5 <= 16'd50;
      end

      16'd50:
      begin
        program_counter <= 16'd54;
        register_51 <= register_6;
        register_55 <= register_13;
      end

      16'd54:
      begin
        program_counter <= 16'd55;
        register_54 <= $unsigned(register_55) + $unsigned(16'd1);
      end

      16'd55:
      begin
        program_counter <= 16'd53;
        register_13 <= register_54;
        program_counter <= 16'd52;
      end

      16'd53:
      begin
        program_counter <= 16'd52;
        program_counter <= 16'd60;
      end

      16'd52:
      begin
        program_counter <= 16'd60;
        program_counter <= 16'd20;
      end

      16'd60:
      begin
        program_counter <= 16'd61;
        register_11 <= 16'd0;
        program_counter <= register_10;
      end

      16'd61:
      begin
        program_counter <= 16'd63;
        register_17 <= 16'd48;
        register_18 <= 16'd48;
        register_19 <= 16'd48;
        register_20 <= 16'd48;
        register_21 <= 16'd48;
      end

      16'd63:
      begin
        program_counter <= 16'd62;
        register_57 <= register_16;
      end

      16'd62:
      begin
        program_counter <= 16'd58;
        register_56 <= $unsigned(register_57) >= $unsigned(16'd10000);
      end

      16'd58:
      begin
        program_counter <= 16'd59;
        if (register_56 == 16'h0000)
          program_counter <= 40;
      end

      16'd59:
      begin
        program_counter <= 16'd57;
        register_59 <= register_21;
        register_61 <= register_16;
      end

      16'd57:
      begin
        program_counter <= 16'd56;
        register_58 <= $signed(register_59) + $signed(16'd1);
        register_60 <= $unsigned(register_61) - $unsigned(16'd10000);
      end

      16'd56:
      begin
        program_counter <= 16'd40;
        register_21 <= register_58;
        register_16 <= register_60;
        program_counter <= 16'd41;
      end

      16'd40:
      begin
        program_counter <= 16'd41;
        program_counter <= 16'd43;
      end

      16'd41:
      begin
        program_counter <= 16'd43;
        program_counter <= 16'd63;
      end

      16'd43:
      begin
        program_counter <= 16'd42;
        register_7 <= register_21;
        program_counter <= 16'd6;
        register_5 <= 16'd42;
      end

      16'd42:
      begin
        program_counter <= 16'd46;
        register_62 <= register_6;
      end

      16'd46:
      begin
        program_counter <= 16'd47;
        register_64 <= register_16;
      end

      16'd47:
      begin
        program_counter <= 16'd45;
        register_63 <= $unsigned(register_64) >= $unsigned(16'd1000);
      end

      16'd45:
      begin
        program_counter <= 16'd44;
        if (register_63 == 16'h0000)
          program_counter <= 39;
      end

      16'd44:
      begin
        program_counter <= 16'd36;
        register_66 <= register_20;
        register_68 <= register_16;
      end

      16'd36:
      begin
        program_counter <= 16'd37;
        register_65 <= $signed(register_66) + $signed(16'd1);
        register_67 <= $unsigned(register_68) - $unsigned(16'd1000);
      end

      16'd37:
      begin
        program_counter <= 16'd39;
        register_20 <= register_65;
        register_16 <= register_67;
        program_counter <= 16'd38;
      end

      16'd39:
      begin
        program_counter <= 16'd38;
        program_counter <= 16'd34;
      end

      16'd38:
      begin
        program_counter <= 16'd34;
        program_counter <= 16'd46;
      end

      16'd34:
      begin
        program_counter <= 16'd35;
        register_7 <= register_20;
        program_counter <= 16'd6;
        register_5 <= 16'd35;
      end

      16'd35:
      begin
        program_counter <= 16'd33;
        register_69 <= register_6;
      end

      16'd33:
      begin
        program_counter <= 16'd32;
        register_71 <= register_16;
      end

      16'd32:
      begin
        program_counter <= 16'd96;
        register_70 <= $unsigned(register_71) >= $unsigned(16'd100);
      end

      16'd96:
      begin
        program_counter <= 16'd97;
        if (register_70 == 16'h0000)
          program_counter <= 102;
      end

      16'd97:
      begin
        program_counter <= 16'd99;
        register_73 <= register_19;
        register_75 <= register_16;
      end

      16'd99:
      begin
        program_counter <= 16'd98;
        register_72 <= $signed(register_73) + $signed(16'd1);
        register_74 <= $unsigned(register_75) - $unsigned(16'd100);
      end

      16'd98:
      begin
        program_counter <= 16'd102;
        register_19 <= register_72;
        register_16 <= register_74;
        program_counter <= 16'd103;
      end

      16'd102:
      begin
        program_counter <= 16'd103;
        program_counter <= 16'd101;
      end

      16'd103:
      begin
        program_counter <= 16'd101;
        program_counter <= 16'd33;
      end

      16'd101:
      begin
        program_counter <= 16'd100;
        register_7 <= register_19;
        program_counter <= 16'd6;
        register_5 <= 16'd100;
      end

      16'd100:
      begin
        program_counter <= 16'd108;
        register_76 <= register_6;
      end

      16'd108:
      begin
        program_counter <= 16'd109;
        register_78 <= register_16;
      end

      16'd109:
      begin
        program_counter <= 16'd111;
        register_77 <= $unsigned(register_78) >= $unsigned(16'd10);
      end

      16'd111:
      begin
        program_counter <= 16'd110;
        if (register_77 == 16'h0000)
          program_counter <= 105;
      end

      16'd110:
      begin
        program_counter <= 16'd106;
        register_80 <= register_18;
        register_82 <= register_16;
      end

      16'd106:
      begin
        program_counter <= 16'd107;
        register_79 <= $signed(register_80) + $signed(16'd1);
        register_81 <= $unsigned(register_82) - $unsigned(16'd10);
      end

      16'd107:
      begin
        program_counter <= 16'd105;
        register_18 <= register_79;
        register_16 <= register_81;
        program_counter <= 16'd104;
      end

      16'd105:
      begin
        program_counter <= 16'd104;
        program_counter <= 16'd120;
      end

      16'd104:
      begin
        program_counter <= 16'd120;
        program_counter <= 16'd108;
      end

      16'd120:
      begin
        program_counter <= 16'd121;
        register_7 <= register_18;
        program_counter <= 16'd6;
        register_5 <= 16'd121;
      end

      16'd121:
      begin
        program_counter <= 16'd123;
        register_83 <= register_6;
      end

      16'd123:
      begin
        program_counter <= 16'd122;
        register_85 <= register_16;
      end

      16'd122:
      begin
        program_counter <= 16'd126;
        register_84 <= $unsigned(register_85) >= $unsigned(16'd1);
      end

      16'd126:
      begin
        program_counter <= 16'd127;
        if (register_84 == 16'h0000)
          program_counter <= 116;
      end

      16'd127:
      begin
        program_counter <= 16'd125;
        register_87 <= register_17;
        register_89 <= register_16;
      end

      16'd125:
      begin
        program_counter <= 16'd124;
        register_86 <= $signed(register_87) + $signed(16'd1);
        register_88 <= $unsigned(register_89) - $unsigned(16'd1);
      end

      16'd124:
      begin
        program_counter <= 16'd116;
        register_17 <= register_86;
        register_16 <= register_88;
        program_counter <= 16'd117;
      end

      16'd116:
      begin
        program_counter <= 16'd117;
        program_counter <= 16'd119;
      end

      16'd117:
      begin
        program_counter <= 16'd119;
        program_counter <= 16'd123;
      end

      16'd119:
      begin
        program_counter <= 16'd118;
        register_7 <= register_17;
        program_counter <= 16'd6;
        register_5 <= 16'd118;
      end

      16'd118:
      begin
        program_counter <= 16'd114;
        register_90 <= register_6;
        register_15 <= 16'd0;
        program_counter <= register_14;
      end

      16'd114:
      begin
        program_counter <= 16'd115;
        register_25 <= 16'd0;
        register_26 <= 16'd0;
        register_27 <= 16'd0;
        register_91 <= 16'd0;
      end

      16'd115:
      begin
        program_counter <= 16'd113;
        register_25 <= register_91;
      end

      16'd113:
      begin
        program_counter <= 16'd112;
        register_93 <= register_25;
      end

      16'd112:
      begin
        program_counter <= 16'd80;
        register_94 <= $unsigned(register_93) + $unsigned(register_27);
      end

      16'd80:
      begin
        program_counter <= 16'd81;
        address <= register_94;
      end

      16'd81:
      begin
        program_counter <= 16'd83;
      end

      16'd83:
      begin
        program_counter <= 16'd82;
        register_92 <= data_out;
      end

      16'd82:
      begin
        program_counter <= 16'd86;
        if (register_92 == 16'h0000)
          program_counter <= 84;
      end

      16'd86:
      begin
        program_counter <= 16'd87;
        register_96 <= register_25;
      end

      16'd87:
      begin
        program_counter <= 16'd85;
        register_95 <= $unsigned(register_96) + $unsigned(16'd1);
      end

      16'd85:
      begin
        program_counter <= 16'd84;
        register_25 <= register_95;
        program_counter <= 16'd92;
      end

      16'd84:
      begin
        program_counter <= 16'd92;
        program_counter <= 16'd93;
      end

      16'd92:
      begin
        program_counter <= 16'd93;
        program_counter <= 16'd113;
      end

      16'd93:
      begin
        program_counter <= 16'd95;
        register_97 <= register_25;
        register_98 <= 16'd0;
      end

      16'd95:
      begin
        program_counter <= 16'd94;
        $display ("%d (report at line: 83 in file: HTTP.h)", $unsigned(register_97));
        register_26 <= register_98;
      end

      16'd94:
      begin
        program_counter <= 16'd90;
        register_100 <= register_26;
      end

      16'd90:
      begin
        program_counter <= 16'd91;
        register_101 <= $signed(register_100) + $signed(register_24);
      end

      16'd91:
      begin
        program_counter <= 16'd89;
        address <= register_101;
      end

      16'd89:
      begin
        program_counter <= 16'd88;
      end

      16'd88:
      begin
        program_counter <= 16'd72;
        register_99 <= data_out;
      end

      16'd72:
      begin
        program_counter <= 16'd73;
        if (register_99 == 16'h0000)
          program_counter <= 78;
      end

      16'd73:
      begin
        program_counter <= 16'd75;
        register_103 <= register_26;
      end

      16'd75:
      begin
        program_counter <= 16'd74;
        register_102 <= $unsigned(register_103) + $unsigned(16'd1);
      end

      16'd74:
      begin
        program_counter <= 16'd78;
        register_26 <= register_102;
        program_counter <= 16'd79;
      end

      16'd78:
      begin
        program_counter <= 16'd79;
        program_counter <= 16'd77;
      end

      16'd79:
      begin
        program_counter <= 16'd77;
        program_counter <= 16'd94;
      end

      16'd77:
      begin
        program_counter <= 16'd76;
        register_104 <= register_26;
        register_107 <= register_25;
        register_108 <= register_26;
      end

      16'd76:
      begin
        program_counter <= 16'd68;
        $display ("%d (report at line: 88 in file: HTTP.h)", $unsigned(register_104));
        register_106 <= $unsigned(register_107) + $unsigned(register_108);
      end

      16'd68:
      begin
        program_counter <= 16'd69;
        register_2 <= $unsigned(register_106) + $unsigned(16'd9);
        program_counter <= 16'd3;
        register_0 <= 16'd69;
      end

      16'd69:
      begin
        program_counter <= 16'd71;
        register_105 <= register_1;
        register_12 <= register_27;
        program_counter <= 16'd28;
        register_10 <= 16'd71;
      end

      16'd71:
      begin
        program_counter <= 16'd70;
        register_109 <= register_11;
        register_16 <= register_26;
        program_counter <= 16'd61;
        register_14 <= 16'd70;
      end

      16'd70:
      begin
        program_counter <= 16'd66;
        register_110 <= register_15;
        register_28 <= 16'd118;
      end

      16'd66:
      begin
        program_counter <= 16'd67;
        register_12 <= register_28;
        program_counter <= 16'd28;
        register_10 <= 16'd67;
      end

      16'd67:
      begin
        program_counter <= 16'd65;
        register_111 <= register_11;
        register_12 <= register_24;
        program_counter <= 16'd28;
        register_10 <= 16'd65;
      end

      16'd65:
      begin
        program_counter <= 16'd64;
        register_112 <= register_11;
        program_counter <= 16'd24;
        register_8 <= 16'd64;
      end

      16'd64:
      begin
        program_counter <= 16'd192;
        register_113 <= register_9;
        register_23 <= 16'd0;
        program_counter <= register_22;
      end

      16'd192:
      begin
        program_counter <= 16'd193;
        register_31 <= 16'd123;
      end

      16'd193:
      begin
        program_counter <= 16'd195;
        register_24 <= register_31;
        program_counter <= 16'd114;
        register_22 <= 16'd195;
      end

      16'd195:
      begin
        program_counter <= 16'd194;
        register_114 <= register_23;
        register_30 <= 16'd0;
        program_counter <= register_29;
      end

    endcase
    if (rst == 1'b1) begin
      program_counter <= 0;
    end
  end

endmodule
