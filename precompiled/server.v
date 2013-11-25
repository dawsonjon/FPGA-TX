//name : server
//tag : c components
//input : input_eth_rx:16
//input : input_socket:16
//output : output_socket:16
//output : output_eth_tx:16
//source_file : ../source/server.c
///======
///
///*Created by C2CHIP*

//////////////////////////////////////////////////////////////////////////////
// Register Allocation
// ===================
//         Register                 Name                   Size          
//            0             put_eth return address            2            
//            1             function argument i             2            
//            2             put_socket return address            2            
//            3             function argument i             2            
//            4             get_eth return address            2            
//            5             get_eth return value            2            
//            6             rdy_eth return address            2            
//            7             rdy_eth return value            2            
//            8             get_socket return address            2            
//            9             get_socket return value            2            
//            10            variable local_mac_address_hi            2            
//            11            variable local_mac_address_med            2            
//            12            variable local_mac_address_lo            2            
//            13            variable local_ip_address_hi            2            
//            14            variable local_ip_address_lo            2            
//            15            variable local_port             2            
//            16                   array                    2            
//            17             variable checksum              4            
//            18            reset_checksum return address            2            
//            19            add_checksum return address            2            
//            20            function argument data            2            
//            21            check_checksum return address            2            
//            22            check_checksum return value            2            
//            23            calc_ack return address            2            
//            24            calc_ack return value            2            
//            25            function argument ack            2            
//            26            function argument seq            2            
//            27            function argument length            2            
//            28             variable new_ack_0             2            
//            29             variable new_ack_1             2            
//            30            variable return_value            2            
//            31            put_ethernet_packet return address            2            
//            32            function argument packet            2            
//            33            function argument number_of_bytes            2            
//            34            function argument destination_mac_address_hi            2            
//            35            function argument destination_mac_address_med            2            
//            36            function argument destination_mac_address_lo            2            
//            37            function argument protocol            2            
//            38               variable byte                2            
//            39               variable index               2            
//            40            get_ethernet_packet return address            2            
//            41            get_ethernet_packet return value            2            
//            42            function argument packet            2            
//            43            variable number_of_bytes            2            
//            44               variable index               2            
//            45               variable byte                2            
//            46                   array                    2            
//            47                   array                    2            
//            48                   array                    2            
//            49                   array                    2            
//            50                   array                    2            
//            51            variable arp_pounsigneder            2            
//            52            get_arp_cache return address            2            
//            53            get_arp_cache return value            2            
//            54            function argument ip_hi            2            
//            55            function argument ip_lo            2            
//            56            variable number_of_bytes            2            
//            57               variable byte                2            
//            58                   array                    2            
//            59                 variable i                 2            
//            60            put_ip_packet return address            2            
//            61            function argument packet            2            
//            62            function argument total_length            2            
//            63            function argument protocol            2            
//            64            function argument ip_hi            2            
//            65            function argument ip_lo            2            
//            66            variable number_of_bytes            2            
//            67                 variable i                 2            
//            68             variable arp_cache             2            
//            69            get_ip_packet return address            2            
//            70            get_ip_packet return value            2            
//            71            function argument packet            2            
//            72            variable total_length            2            
//            73            variable header_length            2            
//            74            variable payload_start            2            
//            75            variable payload_length            2            
//            76                 variable i                 2            
//            77               variable from                2            
//            78                variable to                 2            
//            79            variable payload_end            2            
//            80            variable remote_ip_hi            2            
//            81            variable remote_ip_lo            2            
//            82             variable tx_source             2            
//            83              variable tx_dest              2            
//            84                   array                    2            
//            85                   array                    2            
//            86                   array                    2            
//            87             variable tx_window             2            
//            88            variable tx_fin_flag            2            
//            89            variable tx_syn_flag            2            
//            90            variable tx_rst_flag            2            
//            91            variable tx_psh_flag            2            
//            92            variable tx_ack_flag            2            
//            93            variable tx_urg_flag            2            
//            94             variable rx_source             2            
//            95              variable rx_dest              2            
//            96                   array                    2            
//            97                   array                    2            
//            98            variable rx_fin_flag            2            
//            99            variable rx_syn_flag            2            
//           100            variable rx_rst_flag            2            
//           101            variable rx_ack_flag            2            
//           102            put_tcp_packet return address            2            
//           103            function argument tx_packet            2            
//           104            function argument tx_length            2            
//           105            variable payload_start            2            
//           106            variable packet_length            2            
//           107               variable index               2            
//           108             variable rx_length             2            
//           109             variable rx_start              2            
//           110            get_tcp_packet return address            2            
//           111            get_tcp_packet return value            2            
//           112            function argument rx_packet            2            
//           113            variable number_of_bytes            2            
//           114            variable header_length            2            
//           115            variable payload_start            2            
//           116            variable total_length            2            
//           117            variable payload_length            2            
//           118            variable tcp_header_length            2            
//           119            application_put_data return address            2            
//           120            function argument packet            2            
//           121            function argument start            2            
//           122            function argument length            2            
//           123                 variable i                 2            
//           124               variable index               2            
//           125            application_get_data return address            2            
//           126            application_get_data return value            2            
//           127            function argument packet            2            
//           128            function argument start            2            
//           129                 variable i                 2            
//           130               variable index               2            
//           131              variable length               2            
//           132            server return address            2            
//           133                   array                    2            
//           134                   array                    2            
//           135             variable tx_start              2            
//           136             variable tx_length             2            
//           137              variable timeout              2            
//           138            variable resend_wait            2            
//           139               variable bytes               2            
//           140            variable last_state             2            
//           141            variable new_rx_data            2            
//           142              variable listen               2            
//           143               variable open                2            
//           144               variable send                2            
//           145            variable wait_acknowledge            2            
//           146               variable close               2            
//           147               variable state               2            
//           148             temporary_register             2            
//           149             temporary_register             2            
//           150             temporary_register             2            
//           151             temporary_register             2            
//           152             temporary_register             2            
//           153             temporary_register             2            
  
`timescale 1ns/1ps
module server(input_eth_rx,input_socket,input_eth_rx_stb,input_socket_stb,output_socket_ack,output_eth_tx_ack,clk,rst,output_socket,output_eth_tx,output_socket_stb,output_eth_tx_stb,input_eth_rx_ack,input_socket_ack);
  integer file_count;
  input     [15:0] input_eth_rx;
  input     [15:0] input_socket;
  input     input_eth_rx_stb;
  input     input_socket_stb;
  input     output_socket_ack;
  input     output_eth_tx_ack;
  input     clk;
  input     rst;
  output    [15:0] output_socket;
  output    [15:0] output_eth_tx;
  output    output_socket_stb;
  output    output_eth_tx_stb;
  output    input_eth_rx_ack;
  output    input_socket_ack;
  reg       [15:0] timer;
  reg       timer_enable;
  reg       stage_0_enable;
  reg       stage_1_enable;
  reg       stage_2_enable;
  reg       [11:0] program_counter;
  reg       [11:0] program_counter_0;
  reg       [53:0] instruction_0;
  reg       [5:0] opcode_0;
  reg       [7:0] dest_0;
  reg       [7:0] src_0;
  reg       [7:0] srcb_0;
  reg       [31:0] literal_0;
  reg       [11:0] program_counter_1;
  reg       [5:0] opcode_1;
  reg       [7:0] dest_1;
  reg       [31:0] register_1;
  reg       [31:0] registerb_1;
  reg       [31:0] literal_1;
  reg       [7:0] dest_2;
  reg       [31:0] result_2;
  reg       write_enable_2;
  reg       [15:0] address_2;
  reg       [15:0] data_out_2;
  reg       [15:0] data_in_2;
  reg       memory_enable_2;
  reg       [15:0] address_4;
  reg       [31:0] data_out_4;
  reg       [31:0] data_in_4;
  reg       memory_enable_4;
  reg       [15:0] s_output_socket_stb;
  reg       [15:0] s_output_eth_tx_stb;
  reg       [15:0] s_output_socket;
  reg       [15:0] s_output_eth_tx;
  reg       [15:0] s_input_eth_rx_ack;
  reg       [15:0] s_input_socket_ack;
  reg [15:0] memory_2 [2665:0];
  reg [53:0] instructions [3024:0];
  reg [31:0] registers [153:0];

  //////////////////////////////////////////////////////////////////////////////
  // INSTRUCTION INITIALIZATION                                                 
  //                                                                            
  // Initialise the contents of the instruction memory                          
  //
  // Intruction Set
  // ==============
  // 0 {'literal': True, 'right': False, 'unsigned': False, 'op': 'literal'}
  // 1 {'literal': True, 'right': False, 'unsigned': False, 'op': 'jmp_and_link'}
  // 2 {'literal': False, 'right': False, 'unsigned': False, 'op': 'stop'}
  // 3 {'literal': False, 'right': False, 'unsigned': False, 'op': 'move'}
  // 4 {'literal': False, 'right': False, 'unsigned': False, 'op': 'nop'}
  // 5 {'output': 'eth_tx', 'literal': False, 'right': False, 'unsigned': False, 'op': 'write'}
  // 6 {'literal': False, 'right': False, 'unsigned': False, 'op': 'jmp_to_reg'}
  // 7 {'output': 'socket', 'literal': False, 'right': False, 'unsigned': False, 'op': 'write'}
  // 8 {'input': 'eth_rx', 'literal': False, 'right': False, 'unsigned': False, 'op': 'read'}
  // 9 {'input': 'eth_rx', 'literal': False, 'right': False, 'unsigned': False, 'op': 'ready'}
  // 10 {'input': 'socket', 'literal': False, 'right': False, 'unsigned': False, 'op': 'read'}
  // 11 {'literal': False, 'right': False, 'unsigned': True, 'op': '+'}
  // 12 {'literal': True, 'right': True, 'unsigned': True, 'op': '&'}
  // 13 {'literal': True, 'right': False, 'unsigned': False, 'op': 'jmp_if_false'}
  // 14 {'literal': True, 'right': True, 'unsigned': True, 'op': '+'}
  // 15 {'literal': True, 'right': False, 'unsigned': False, 'op': 'goto'}
  // 16 {'literal': False, 'right': False, 'unsigned': False, 'op': '~'}
  // 17 {'element_size': 2, 'literal': False, 'right': False, 'unsigned': False, 'op': 'memory_read_request'}
  // 18 {'element_size': 2, 'literal': False, 'right': False, 'unsigned': False, 'op': 'memory_read_wait'}
  // 19 {'element_size': 2, 'literal': False, 'right': False, 'unsigned': False, 'op': 'memory_read'}
  // 20 {'literal': False, 'right': False, 'unsigned': True, 'op': '<'}
  // 21 {'literal': False, 'right': False, 'unsigned': True, 'op': '!='}
  // 22 {'literal': True, 'right': False, 'unsigned': False, 'op': 'jmp_if_true'}
  // 23 {'element_size': 2, 'literal': False, 'right': False, 'unsigned': False, 'op': 'memory_write'}
  // 24 {'right': False, 'file_': '/media/sdb1/Projects/Chips-Demo/source/server.h', 'unsigned': True, 'literal': False, 'line': 107, 'op': 'report'}
  // 25 {'literal': True, 'right': True, 'unsigned': True, 'op': '=='}
  // 26 {'literal': True, 'right': True, 'unsigned': True, 'op': '!='}
  // 27 {'literal': True, 'right': True, 'unsigned': True, 'op': '<'}
  // 28 {'literal': False, 'right': False, 'unsigned': True, 'op': '=='}
  // 29 {'literal': True, 'right': False, 'unsigned': True, 'op': '|'}
  // 30 {'literal': True, 'right': True, 'unsigned': True, 'op': '<='}
  // 31 {'literal': True, 'right': True, 'unsigned': True, 'op': '>>'}
  // 32 {'literal': True, 'right': True, 'unsigned': True, 'op': '<<'}
  // 33 {'literal': False, 'right': False, 'unsigned': True, 'op': '-'}
  // 34 {'literal': True, 'right': True, 'unsigned': True, 'op': '-'}
  // 35 {'literal': False, 'right': False, 'unsigned': True, 'op': '<='}
  // 36 {'literal': True, 'right': True, 'unsigned': True, 'op': '|'}
  // 37 {'input': 'socket', 'literal': False, 'right': False, 'unsigned': False, 'op': 'ready'}
  // 38 {'literal': True, 'right': True, 'unsigned': False, 'op': '=='}
  // 39 {'literal': False, 'right': False, 'unsigned': False, 'op': 'wait_clocks'}
  // Intructions
  // ===========
  
  initial
  begin
    instructions[0] = {6'd0, 8'd10, 8'd0, 32'd1};//{'dest': 10, 'literal': 1, 'op': 'literal'}
    instructions[1] = {6'd0, 8'd11, 8'd0, 32'd515};//{'dest': 11, 'literal': 515, 'op': 'literal'}
    instructions[2] = {6'd0, 8'd12, 8'd0, 32'd1029};//{'dest': 12, 'literal': 1029, 'op': 'literal'}
    instructions[3] = {6'd0, 8'd13, 8'd0, 32'd49320};//{'dest': 13, 'literal': 49320, 'op': 'literal'}
    instructions[4] = {6'd0, 8'd14, 8'd0, 32'd257};//{'dest': 14, 'literal': 257, 'op': 'literal'}
    instructions[5] = {6'd0, 8'd15, 8'd0, 32'd80};//{'dest': 15, 'literal': 80, 'op': 'literal'}
    instructions[6] = {6'd0, 8'd16, 8'd0, 32'd0};//{'dest': 16, 'literal': 0, 'op': 'literal'}
    instructions[7] = {6'd0, 8'd17, 8'd0, 32'd0};//{'dest': 17, 'literal': 0, 'op': 'literal'}
    instructions[8] = {6'd0, 8'd46, 8'd0, 32'd512};//{'dest': 46, 'literal': 512, 'op': 'literal'}
    instructions[9] = {6'd0, 8'd47, 8'd0, 32'd528};//{'dest': 47, 'literal': 528, 'op': 'literal'}
    instructions[10] = {6'd0, 8'd48, 8'd0, 32'd544};//{'dest': 48, 'literal': 544, 'op': 'literal'}
    instructions[11] = {6'd0, 8'd49, 8'd0, 32'd560};//{'dest': 49, 'literal': 560, 'op': 'literal'}
    instructions[12] = {6'd0, 8'd50, 8'd0, 32'd576};//{'dest': 50, 'literal': 576, 'op': 'literal'}
    instructions[13] = {6'd0, 8'd51, 8'd0, 32'd0};//{'dest': 51, 'literal': 0, 'op': 'literal'}
    instructions[14] = {6'd0, 8'd80, 8'd0, 32'd0};//{'dest': 80, 'literal': 0, 'op': 'literal'}
    instructions[15] = {6'd0, 8'd81, 8'd0, 32'd0};//{'dest': 81, 'literal': 0, 'op': 'literal'}
    instructions[16] = {6'd0, 8'd82, 8'd0, 32'd0};//{'dest': 82, 'literal': 0, 'op': 'literal'}
    instructions[17] = {6'd0, 8'd83, 8'd0, 32'd0};//{'dest': 83, 'literal': 0, 'op': 'literal'}
    instructions[18] = {6'd0, 8'd84, 8'd0, 32'd608};//{'dest': 84, 'literal': 608, 'op': 'literal'}
    instructions[19] = {6'd0, 8'd85, 8'd0, 32'd610};//{'dest': 85, 'literal': 610, 'op': 'literal'}
    instructions[20] = {6'd0, 8'd86, 8'd0, 32'd612};//{'dest': 86, 'literal': 612, 'op': 'literal'}
    instructions[21] = {6'd0, 8'd87, 8'd0, 32'd1460};//{'dest': 87, 'literal': 1460, 'op': 'literal'}
    instructions[22] = {6'd0, 8'd88, 8'd0, 32'd0};//{'dest': 88, 'literal': 0, 'op': 'literal'}
    instructions[23] = {6'd0, 8'd89, 8'd0, 32'd0};//{'dest': 89, 'literal': 0, 'op': 'literal'}
    instructions[24] = {6'd0, 8'd90, 8'd0, 32'd0};//{'dest': 90, 'literal': 0, 'op': 'literal'}
    instructions[25] = {6'd0, 8'd91, 8'd0, 32'd0};//{'dest': 91, 'literal': 0, 'op': 'literal'}
    instructions[26] = {6'd0, 8'd92, 8'd0, 32'd0};//{'dest': 92, 'literal': 0, 'op': 'literal'}
    instructions[27] = {6'd0, 8'd93, 8'd0, 32'd0};//{'dest': 93, 'literal': 0, 'op': 'literal'}
    instructions[28] = {6'd0, 8'd94, 8'd0, 32'd0};//{'dest': 94, 'literal': 0, 'op': 'literal'}
    instructions[29] = {6'd0, 8'd95, 8'd0, 32'd0};//{'dest': 95, 'literal': 0, 'op': 'literal'}
    instructions[30] = {6'd0, 8'd96, 8'd0, 32'd614};//{'dest': 96, 'literal': 614, 'op': 'literal'}
    instructions[31] = {6'd0, 8'd97, 8'd0, 32'd616};//{'dest': 97, 'literal': 616, 'op': 'literal'}
    instructions[32] = {6'd0, 8'd98, 8'd0, 32'd0};//{'dest': 98, 'literal': 0, 'op': 'literal'}
    instructions[33] = {6'd0, 8'd99, 8'd0, 32'd0};//{'dest': 99, 'literal': 0, 'op': 'literal'}
    instructions[34] = {6'd0, 8'd100, 8'd0, 32'd0};//{'dest': 100, 'literal': 0, 'op': 'literal'}
    instructions[35] = {6'd0, 8'd101, 8'd0, 32'd0};//{'dest': 101, 'literal': 0, 'op': 'literal'}
    instructions[36] = {6'd0, 8'd108, 8'd0, 32'd0};//{'dest': 108, 'literal': 0, 'op': 'literal'}
    instructions[37] = {6'd0, 8'd109, 8'd0, 32'd0};//{'dest': 109, 'literal': 0, 'op': 'literal'}
    instructions[38] = {6'd1, 8'd132, 8'd0, 32'd2432};//{'dest': 132, 'label': 2432, 'op': 'jmp_and_link'}
    instructions[39] = {6'd2, 8'd0, 8'd0, 32'd0};//{'op': 'stop'}
    instructions[40] = {6'd3, 8'd148, 8'd1, 32'd0};//{'dest': 148, 'src': 1, 'op': 'move'}
    instructions[41] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[42] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[43] = {6'd5, 8'd0, 8'd148, 32'd0};//{'src': 148, 'output': 'eth_tx', 'op': 'write'}
    instructions[44] = {6'd6, 8'd0, 8'd0, 32'd0};//{'src': 0, 'op': 'jmp_to_reg'}
    instructions[45] = {6'd3, 8'd148, 8'd3, 32'd0};//{'dest': 148, 'src': 3, 'op': 'move'}
    instructions[46] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[47] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[48] = {6'd7, 8'd0, 8'd148, 32'd0};//{'src': 148, 'output': 'socket', 'op': 'write'}
    instructions[49] = {6'd6, 8'd0, 8'd2, 32'd0};//{'src': 2, 'op': 'jmp_to_reg'}
    instructions[50] = {6'd8, 8'd5, 8'd0, 32'd0};//{'dest': 5, 'input': 'eth_rx', 'op': 'read'}
    instructions[51] = {6'd6, 8'd0, 8'd4, 32'd0};//{'src': 4, 'op': 'jmp_to_reg'}
    instructions[52] = {6'd9, 8'd7, 8'd0, 32'd0};//{'dest': 7, 'input': 'eth_rx', 'op': 'ready'}
    instructions[53] = {6'd6, 8'd0, 8'd6, 32'd0};//{'src': 6, 'op': 'jmp_to_reg'}
    instructions[54] = {6'd10, 8'd9, 8'd0, 32'd0};//{'dest': 9, 'input': 'socket', 'op': 'read'}
    instructions[55] = {6'd6, 8'd0, 8'd8, 32'd0};//{'src': 8, 'op': 'jmp_to_reg'}
    instructions[56] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[57] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[58] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[59] = {6'd3, 8'd17, 8'd148, 32'd0};//{'dest': 17, 'src': 148, 'op': 'move'}
    instructions[60] = {6'd6, 8'd0, 8'd18, 32'd0};//{'src': 18, 'op': 'jmp_to_reg'}
    instructions[61] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[62] = {6'd3, 8'd149, 8'd17, 32'd0};//{'dest': 149, 'src': 17, 'op': 'move'}
    instructions[63] = {6'd3, 8'd150, 8'd20, 32'd0};//{'dest': 150, 'src': 20, 'op': 'move'}
    instructions[64] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[65] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[66] = {6'd11, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '+'}
    instructions[67] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[68] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[69] = {6'd3, 8'd17, 8'd148, 32'd0};//{'dest': 17, 'src': 148, 'op': 'move'}
    instructions[70] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[71] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[72] = {6'd3, 8'd149, 8'd17, 32'd0};//{'dest': 149, 'src': 17, 'op': 'move'}
    instructions[73] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[74] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[75] = {6'd12, 8'd148, 8'd149, 32'd65536};//{'dest': 148, 'src': 149, 'right': 65536, 'signed': False, 'op': '&'}
    instructions[76] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[77] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[78] = {6'd13, 8'd0, 8'd148, 32'd96};//{'src': 148, 'label': 96, 'op': 'jmp_if_false'}
    instructions[79] = {6'd3, 8'd149, 8'd17, 32'd0};//{'dest': 149, 'src': 17, 'op': 'move'}
    instructions[80] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[81] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[82] = {6'd12, 8'd148, 8'd149, 32'd65535};//{'dest': 148, 'src': 149, 'right': 65535, 'signed': False, 'op': '&'}
    instructions[83] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[84] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[85] = {6'd3, 8'd17, 8'd148, 32'd0};//{'dest': 17, 'src': 148, 'op': 'move'}
    instructions[86] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[87] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[88] = {6'd3, 8'd149, 8'd17, 32'd0};//{'dest': 149, 'src': 17, 'op': 'move'}
    instructions[89] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[90] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[91] = {6'd14, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '+'}
    instructions[92] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[93] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[94] = {6'd3, 8'd17, 8'd148, 32'd0};//{'dest': 17, 'src': 148, 'op': 'move'}
    instructions[95] = {6'd15, 8'd0, 8'd0, 32'd96};//{'label': 96, 'op': 'goto'}
    instructions[96] = {6'd6, 8'd0, 8'd19, 32'd0};//{'src': 19, 'op': 'jmp_to_reg'}
    instructions[97] = {6'd3, 8'd148, 8'd17, 32'd0};//{'dest': 148, 'src': 17, 'op': 'move'}
    instructions[98] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[99] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[100] = {6'd16, 8'd22, 8'd148, 32'd0};//{'dest': 22, 'src': 148, 'op': '~'}
    instructions[101] = {6'd6, 8'd0, 8'd21, 32'd0};//{'src': 21, 'op': 'jmp_to_reg'}
    instructions[102] = {6'd0, 8'd28, 8'd0, 32'd0};//{'dest': 28, 'literal': 0, 'op': 'literal'}
    instructions[103] = {6'd0, 8'd29, 8'd0, 32'd0};//{'dest': 29, 'literal': 0, 'op': 'literal'}
    instructions[104] = {6'd0, 8'd30, 8'd0, 32'd0};//{'dest': 30, 'literal': 0, 'op': 'literal'}
    instructions[105] = {6'd0, 8'd150, 8'd0, 32'd0};//{'dest': 150, 'literal': 0, 'op': 'literal'}
    instructions[106] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[107] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[108] = {6'd11, 8'd151, 8'd150, 32'd26};//{'dest': 151, 'src': 150, 'srcb': 26, 'signed': False, 'op': '+'}
    instructions[109] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[110] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[111] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18319552, 'op': 'memory_read_request'}
    instructions[112] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[113] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18319552, 'op': 'memory_read_wait'}
    instructions[114] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18319552, 'element_size': 2, 'op': 'memory_read'}
    instructions[115] = {6'd3, 8'd150, 8'd27, 32'd0};//{'dest': 150, 'src': 27, 'op': 'move'}
    instructions[116] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[117] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[118] = {6'd11, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '+'}
    instructions[119] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[120] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[121] = {6'd3, 8'd28, 8'd148, 32'd0};//{'dest': 28, 'src': 148, 'op': 'move'}
    instructions[122] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[123] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[124] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[125] = {6'd11, 8'd150, 8'd149, 32'd26};//{'dest': 150, 'src': 149, 'srcb': 26, 'signed': False, 'op': '+'}
    instructions[126] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[127] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[128] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18320056, 'op': 'memory_read_request'}
    instructions[129] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[130] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18320056, 'op': 'memory_read_wait'}
    instructions[131] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18320056, 'element_size': 2, 'op': 'memory_read'}
    instructions[132] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[133] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[134] = {6'd3, 8'd29, 8'd148, 32'd0};//{'dest': 29, 'src': 148, 'op': 'move'}
    instructions[135] = {6'd3, 8'd149, 8'd28, 32'd0};//{'dest': 149, 'src': 28, 'op': 'move'}
    instructions[136] = {6'd3, 8'd150, 8'd27, 32'd0};//{'dest': 150, 'src': 27, 'op': 'move'}
    instructions[137] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[138] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[139] = {6'd20, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '<'}
    instructions[140] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[141] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[142] = {6'd13, 8'd0, 8'd148, 32'd151};//{'src': 148, 'label': 151, 'op': 'jmp_if_false'}
    instructions[143] = {6'd3, 8'd149, 8'd29, 32'd0};//{'dest': 149, 'src': 29, 'op': 'move'}
    instructions[144] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[145] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[146] = {6'd14, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '+'}
    instructions[147] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[148] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[149] = {6'd3, 8'd29, 8'd148, 32'd0};//{'dest': 29, 'src': 148, 'op': 'move'}
    instructions[150] = {6'd15, 8'd0, 8'd0, 32'd151};//{'label': 151, 'op': 'goto'}
    instructions[151] = {6'd3, 8'd149, 8'd28, 32'd0};//{'dest': 149, 'src': 28, 'op': 'move'}
    instructions[152] = {6'd0, 8'd151, 8'd0, 32'd0};//{'dest': 151, 'literal': 0, 'op': 'literal'}
    instructions[153] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[154] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[155] = {6'd11, 8'd152, 8'd151, 32'd25};//{'dest': 152, 'src': 151, 'srcb': 25, 'signed': False, 'op': '+'}
    instructions[156] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[157] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[158] = {6'd17, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 18325448, 'op': 'memory_read_request'}
    instructions[159] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[160] = {6'd18, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 18325448, 'op': 'memory_read_wait'}
    instructions[161] = {6'd19, 8'd150, 8'd152, 32'd0};//{'dest': 150, 'src': 152, 'sequence': 18325448, 'element_size': 2, 'op': 'memory_read'}
    instructions[162] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[163] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[164] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[165] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[166] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[167] = {6'd22, 8'd0, 8'd148, 32'd182};//{'src': 148, 'label': 182, 'op': 'jmp_if_true'}
    instructions[168] = {6'd3, 8'd149, 8'd29, 32'd0};//{'dest': 149, 'src': 29, 'op': 'move'}
    instructions[169] = {6'd0, 8'd151, 8'd0, 32'd1};//{'dest': 151, 'literal': 1, 'op': 'literal'}
    instructions[170] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[171] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[172] = {6'd11, 8'd152, 8'd151, 32'd25};//{'dest': 152, 'src': 151, 'srcb': 25, 'signed': False, 'op': '+'}
    instructions[173] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[174] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[175] = {6'd17, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 18325800, 'op': 'memory_read_request'}
    instructions[176] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[177] = {6'd18, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 18325800, 'op': 'memory_read_wait'}
    instructions[178] = {6'd19, 8'd150, 8'd152, 32'd0};//{'dest': 150, 'src': 152, 'sequence': 18325800, 'element_size': 2, 'op': 'memory_read'}
    instructions[179] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[180] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[181] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[182] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[183] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[184] = {6'd13, 8'd0, 8'd148, 32'd206};//{'src': 148, 'label': 206, 'op': 'jmp_if_false'}
    instructions[185] = {6'd3, 8'd148, 8'd28, 32'd0};//{'dest': 148, 'src': 28, 'op': 'move'}
    instructions[186] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[187] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[188] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[189] = {6'd11, 8'd150, 8'd149, 32'd25};//{'dest': 150, 'src': 149, 'srcb': 25, 'signed': False, 'op': '+'}
    instructions[190] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[191] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[192] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[193] = {6'd3, 8'd148, 8'd29, 32'd0};//{'dest': 148, 'src': 29, 'op': 'move'}
    instructions[194] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[195] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[196] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[197] = {6'd11, 8'd150, 8'd149, 32'd25};//{'dest': 150, 'src': 149, 'srcb': 25, 'signed': False, 'op': '+'}
    instructions[198] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[199] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[200] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[201] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[202] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[203] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[204] = {6'd3, 8'd30, 8'd148, 32'd0};//{'dest': 30, 'src': 148, 'op': 'move'}
    instructions[205] = {6'd15, 8'd0, 8'd0, 32'd206};//{'label': 206, 'op': 'goto'}
    instructions[206] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[207] = {6'd3, 8'd24, 8'd30, 32'd0};//{'dest': 24, 'src': 30, 'op': 'move'}
    instructions[208] = {6'd6, 8'd0, 8'd23, 32'd0};//{'src': 23, 'op': 'jmp_to_reg'}
    instructions[209] = {6'd0, 8'd38, 8'd0, 32'd0};//{'dest': 38, 'literal': 0, 'op': 'literal'}
    instructions[210] = {6'd0, 8'd39, 8'd0, 32'd0};//{'dest': 39, 'literal': 0, 'op': 'literal'}
    instructions[211] = {6'd3, 8'd148, 8'd33, 32'd0};//{'dest': 148, 'src': 33, 'op': 'move'}
    instructions[212] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[213] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[214] = {6'd24, 8'd0, 8'd148, 32'd0};//{'src': 148, 'line': 107, 'signed': False, 'file': '/media/sdb1/Projects/Chips-Demo/source/server.h', 'op': 'report'}
    instructions[215] = {6'd3, 8'd148, 8'd34, 32'd0};//{'dest': 148, 'src': 34, 'op': 'move'}
    instructions[216] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[217] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[218] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[219] = {6'd11, 8'd150, 8'd149, 32'd32};//{'dest': 150, 'src': 149, 'srcb': 32, 'signed': False, 'op': '+'}
    instructions[220] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[221] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[222] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[223] = {6'd3, 8'd148, 8'd35, 32'd0};//{'dest': 148, 'src': 35, 'op': 'move'}
    instructions[224] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[225] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[226] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[227] = {6'd11, 8'd150, 8'd149, 32'd32};//{'dest': 150, 'src': 149, 'srcb': 32, 'signed': False, 'op': '+'}
    instructions[228] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[229] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[230] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[231] = {6'd3, 8'd148, 8'd36, 32'd0};//{'dest': 148, 'src': 36, 'op': 'move'}
    instructions[232] = {6'd0, 8'd149, 8'd0, 32'd2};//{'dest': 149, 'literal': 2, 'op': 'literal'}
    instructions[233] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[234] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[235] = {6'd11, 8'd150, 8'd149, 32'd32};//{'dest': 150, 'src': 149, 'srcb': 32, 'signed': False, 'op': '+'}
    instructions[236] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[237] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[238] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[239] = {6'd3, 8'd148, 8'd10, 32'd0};//{'dest': 148, 'src': 10, 'op': 'move'}
    instructions[240] = {6'd0, 8'd149, 8'd0, 32'd3};//{'dest': 149, 'literal': 3, 'op': 'literal'}
    instructions[241] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[242] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[243] = {6'd11, 8'd150, 8'd149, 32'd32};//{'dest': 150, 'src': 149, 'srcb': 32, 'signed': False, 'op': '+'}
    instructions[244] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[245] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[246] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[247] = {6'd3, 8'd148, 8'd11, 32'd0};//{'dest': 148, 'src': 11, 'op': 'move'}
    instructions[248] = {6'd0, 8'd149, 8'd0, 32'd4};//{'dest': 149, 'literal': 4, 'op': 'literal'}
    instructions[249] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[250] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[251] = {6'd11, 8'd150, 8'd149, 32'd32};//{'dest': 150, 'src': 149, 'srcb': 32, 'signed': False, 'op': '+'}
    instructions[252] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[253] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[254] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[255] = {6'd3, 8'd148, 8'd12, 32'd0};//{'dest': 148, 'src': 12, 'op': 'move'}
    instructions[256] = {6'd0, 8'd149, 8'd0, 32'd5};//{'dest': 149, 'literal': 5, 'op': 'literal'}
    instructions[257] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[258] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[259] = {6'd11, 8'd150, 8'd149, 32'd32};//{'dest': 150, 'src': 149, 'srcb': 32, 'signed': False, 'op': '+'}
    instructions[260] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[261] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[262] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[263] = {6'd3, 8'd148, 8'd37, 32'd0};//{'dest': 148, 'src': 37, 'op': 'move'}
    instructions[264] = {6'd0, 8'd149, 8'd0, 32'd6};//{'dest': 149, 'literal': 6, 'op': 'literal'}
    instructions[265] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[266] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[267] = {6'd11, 8'd150, 8'd149, 32'd32};//{'dest': 150, 'src': 149, 'srcb': 32, 'signed': False, 'op': '+'}
    instructions[268] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[269] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[270] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[271] = {6'd3, 8'd1, 8'd33, 32'd0};//{'dest': 1, 'src': 33, 'op': 'move'}
    instructions[272] = {6'd1, 8'd0, 8'd0, 32'd40};//{'dest': 0, 'label': 40, 'op': 'jmp_and_link'}
    instructions[273] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[274] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[275] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[276] = {6'd3, 8'd39, 8'd148, 32'd0};//{'dest': 39, 'src': 148, 'op': 'move'}
    instructions[277] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[278] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[279] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[280] = {6'd3, 8'd38, 8'd148, 32'd0};//{'dest': 38, 'src': 148, 'op': 'move'}
    instructions[281] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[282] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[283] = {6'd3, 8'd149, 8'd38, 32'd0};//{'dest': 149, 'src': 38, 'op': 'move'}
    instructions[284] = {6'd3, 8'd150, 8'd33, 32'd0};//{'dest': 150, 'src': 33, 'op': 'move'}
    instructions[285] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[286] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[287] = {6'd20, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '<'}
    instructions[288] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[289] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[290] = {6'd13, 8'd0, 8'd148, 32'd312};//{'src': 148, 'label': 312, 'op': 'jmp_if_false'}
    instructions[291] = {6'd3, 8'd149, 8'd39, 32'd0};//{'dest': 149, 'src': 39, 'op': 'move'}
    instructions[292] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[293] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[294] = {6'd11, 8'd150, 8'd149, 32'd32};//{'dest': 150, 'src': 149, 'srcb': 32, 'signed': False, 'op': '+'}
    instructions[295] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[296] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[297] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18332920, 'op': 'memory_read_request'}
    instructions[298] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[299] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18332920, 'op': 'memory_read_wait'}
    instructions[300] = {6'd19, 8'd1, 8'd150, 32'd0};//{'dest': 1, 'src': 150, 'sequence': 18332920, 'element_size': 2, 'op': 'memory_read'}
    instructions[301] = {6'd1, 8'd0, 8'd0, 32'd40};//{'dest': 0, 'label': 40, 'op': 'jmp_and_link'}
    instructions[302] = {6'd3, 8'd148, 8'd39, 32'd0};//{'dest': 148, 'src': 39, 'op': 'move'}
    instructions[303] = {6'd14, 8'd39, 8'd39, 32'd1};//{'dest': 39, 'src': 39, 'right': 1, 'signed': False, 'op': '+'}
    instructions[304] = {6'd3, 8'd149, 8'd38, 32'd0};//{'dest': 149, 'src': 38, 'op': 'move'}
    instructions[305] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[306] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[307] = {6'd14, 8'd148, 8'd149, 32'd2};//{'dest': 148, 'src': 149, 'right': 2, 'signed': False, 'op': '+'}
    instructions[308] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[309] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[310] = {6'd3, 8'd38, 8'd148, 32'd0};//{'dest': 38, 'src': 148, 'op': 'move'}
    instructions[311] = {6'd15, 8'd0, 8'd0, 32'd281};//{'label': 281, 'op': 'goto'}
    instructions[312] = {6'd6, 8'd0, 8'd31, 32'd0};//{'src': 31, 'op': 'jmp_to_reg'}
    instructions[313] = {6'd0, 8'd43, 8'd0, 32'd0};//{'dest': 43, 'literal': 0, 'op': 'literal'}
    instructions[314] = {6'd0, 8'd44, 8'd0, 32'd0};//{'dest': 44, 'literal': 0, 'op': 'literal'}
    instructions[315] = {6'd0, 8'd45, 8'd0, 32'd0};//{'dest': 45, 'literal': 0, 'op': 'literal'}
    instructions[316] = {6'd1, 8'd6, 8'd0, 32'd52};//{'dest': 6, 'label': 52, 'op': 'jmp_and_link'}
    instructions[317] = {6'd3, 8'd149, 8'd7, 32'd0};//{'dest': 149, 'src': 7, 'op': 'move'}
    instructions[318] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[319] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[320] = {6'd25, 8'd148, 8'd149, 32'd0};//{'dest': 148, 'src': 149, 'right': 0, 'signed': False, 'op': '=='}
    instructions[321] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[322] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[323] = {6'd13, 8'd0, 8'd148, 32'd327};//{'src': 148, 'label': 327, 'op': 'jmp_if_false'}
    instructions[324] = {6'd0, 8'd41, 8'd0, 32'd0};//{'dest': 41, 'literal': 0, 'op': 'literal'}
    instructions[325] = {6'd6, 8'd0, 8'd40, 32'd0};//{'src': 40, 'op': 'jmp_to_reg'}
    instructions[326] = {6'd15, 8'd0, 8'd0, 32'd327};//{'label': 327, 'op': 'goto'}
    instructions[327] = {6'd1, 8'd4, 8'd0, 32'd50};//{'dest': 4, 'label': 50, 'op': 'jmp_and_link'}
    instructions[328] = {6'd3, 8'd148, 8'd5, 32'd0};//{'dest': 148, 'src': 5, 'op': 'move'}
    instructions[329] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[330] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[331] = {6'd3, 8'd43, 8'd148, 32'd0};//{'dest': 43, 'src': 148, 'op': 'move'}
    instructions[332] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[333] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[334] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[335] = {6'd3, 8'd44, 8'd148, 32'd0};//{'dest': 44, 'src': 148, 'op': 'move'}
    instructions[336] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[337] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[338] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[339] = {6'd3, 8'd45, 8'd148, 32'd0};//{'dest': 45, 'src': 148, 'op': 'move'}
    instructions[340] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[341] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[342] = {6'd3, 8'd149, 8'd45, 32'd0};//{'dest': 149, 'src': 45, 'op': 'move'}
    instructions[343] = {6'd3, 8'd150, 8'd43, 32'd0};//{'dest': 150, 'src': 43, 'op': 'move'}
    instructions[344] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[345] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[346] = {6'd20, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '<'}
    instructions[347] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[348] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[349] = {6'd13, 8'd0, 8'd148, 32'd369};//{'src': 148, 'label': 369, 'op': 'jmp_if_false'}
    instructions[350] = {6'd1, 8'd4, 8'd0, 32'd50};//{'dest': 4, 'label': 50, 'op': 'jmp_and_link'}
    instructions[351] = {6'd3, 8'd148, 8'd5, 32'd0};//{'dest': 148, 'src': 5, 'op': 'move'}
    instructions[352] = {6'd3, 8'd149, 8'd44, 32'd0};//{'dest': 149, 'src': 44, 'op': 'move'}
    instructions[353] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[354] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[355] = {6'd11, 8'd150, 8'd149, 32'd42};//{'dest': 150, 'src': 149, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[356] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[357] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[358] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[359] = {6'd3, 8'd148, 8'd44, 32'd0};//{'dest': 148, 'src': 44, 'op': 'move'}
    instructions[360] = {6'd14, 8'd44, 8'd44, 32'd1};//{'dest': 44, 'src': 44, 'right': 1, 'signed': False, 'op': '+'}
    instructions[361] = {6'd3, 8'd149, 8'd45, 32'd0};//{'dest': 149, 'src': 45, 'op': 'move'}
    instructions[362] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[363] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[364] = {6'd14, 8'd148, 8'd149, 32'd2};//{'dest': 148, 'src': 149, 'right': 2, 'signed': False, 'op': '+'}
    instructions[365] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[366] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[367] = {6'd3, 8'd45, 8'd148, 32'd0};//{'dest': 45, 'src': 148, 'op': 'move'}
    instructions[368] = {6'd15, 8'd0, 8'd0, 32'd340};//{'label': 340, 'op': 'goto'}
    instructions[369] = {6'd0, 8'd150, 8'd0, 32'd0};//{'dest': 150, 'literal': 0, 'op': 'literal'}
    instructions[370] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[371] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[372] = {6'd11, 8'd151, 8'd150, 32'd42};//{'dest': 151, 'src': 150, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[373] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[374] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[375] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18333640, 'op': 'memory_read_request'}
    instructions[376] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[377] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18333640, 'op': 'memory_read_wait'}
    instructions[378] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18333640, 'element_size': 2, 'op': 'memory_read'}
    instructions[379] = {6'd3, 8'd150, 8'd10, 32'd0};//{'dest': 150, 'src': 10, 'op': 'move'}
    instructions[380] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[381] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[382] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[383] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[384] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[385] = {6'd13, 8'd0, 8'd148, 32'd399};//{'src': 148, 'label': 399, 'op': 'jmp_if_false'}
    instructions[386] = {6'd0, 8'd150, 8'd0, 32'd0};//{'dest': 150, 'literal': 0, 'op': 'literal'}
    instructions[387] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[388] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[389] = {6'd11, 8'd151, 8'd150, 32'd42};//{'dest': 151, 'src': 150, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[390] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[391] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[392] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18333992, 'op': 'memory_read_request'}
    instructions[393] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[394] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18333992, 'op': 'memory_read_wait'}
    instructions[395] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18333992, 'element_size': 2, 'op': 'memory_read'}
    instructions[396] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[397] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[398] = {6'd26, 8'd148, 8'd149, 32'd65535};//{'dest': 148, 'src': 149, 'right': 65535, 'signed': False, 'op': '!='}
    instructions[399] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[400] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[401] = {6'd13, 8'd0, 8'd148, 32'd405};//{'src': 148, 'label': 405, 'op': 'jmp_if_false'}
    instructions[402] = {6'd0, 8'd41, 8'd0, 32'd0};//{'dest': 41, 'literal': 0, 'op': 'literal'}
    instructions[403] = {6'd6, 8'd0, 8'd40, 32'd0};//{'src': 40, 'op': 'jmp_to_reg'}
    instructions[404] = {6'd15, 8'd0, 8'd0, 32'd405};//{'label': 405, 'op': 'goto'}
    instructions[405] = {6'd0, 8'd150, 8'd0, 32'd1};//{'dest': 150, 'literal': 1, 'op': 'literal'}
    instructions[406] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[407] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[408] = {6'd11, 8'd151, 8'd150, 32'd42};//{'dest': 151, 'src': 150, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[409] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[410] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[411] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18334568, 'op': 'memory_read_request'}
    instructions[412] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[413] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18334568, 'op': 'memory_read_wait'}
    instructions[414] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18334568, 'element_size': 2, 'op': 'memory_read'}
    instructions[415] = {6'd3, 8'd150, 8'd11, 32'd0};//{'dest': 150, 'src': 11, 'op': 'move'}
    instructions[416] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[417] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[418] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[419] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[420] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[421] = {6'd13, 8'd0, 8'd148, 32'd435};//{'src': 148, 'label': 435, 'op': 'jmp_if_false'}
    instructions[422] = {6'd0, 8'd150, 8'd0, 32'd1};//{'dest': 150, 'literal': 1, 'op': 'literal'}
    instructions[423] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[424] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[425] = {6'd11, 8'd151, 8'd150, 32'd42};//{'dest': 151, 'src': 150, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[426] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[427] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[428] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18334856, 'op': 'memory_read_request'}
    instructions[429] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[430] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18334856, 'op': 'memory_read_wait'}
    instructions[431] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18334856, 'element_size': 2, 'op': 'memory_read'}
    instructions[432] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[433] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[434] = {6'd26, 8'd148, 8'd149, 32'd65535};//{'dest': 148, 'src': 149, 'right': 65535, 'signed': False, 'op': '!='}
    instructions[435] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[436] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[437] = {6'd13, 8'd0, 8'd148, 32'd441};//{'src': 148, 'label': 441, 'op': 'jmp_if_false'}
    instructions[438] = {6'd0, 8'd41, 8'd0, 32'd0};//{'dest': 41, 'literal': 0, 'op': 'literal'}
    instructions[439] = {6'd6, 8'd0, 8'd40, 32'd0};//{'src': 40, 'op': 'jmp_to_reg'}
    instructions[440] = {6'd15, 8'd0, 8'd0, 32'd441};//{'label': 441, 'op': 'goto'}
    instructions[441] = {6'd0, 8'd150, 8'd0, 32'd2};//{'dest': 150, 'literal': 2, 'op': 'literal'}
    instructions[442] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[443] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[444] = {6'd11, 8'd151, 8'd150, 32'd42};//{'dest': 151, 'src': 150, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[445] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[446] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[447] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18335432, 'op': 'memory_read_request'}
    instructions[448] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[449] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18335432, 'op': 'memory_read_wait'}
    instructions[450] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18335432, 'element_size': 2, 'op': 'memory_read'}
    instructions[451] = {6'd3, 8'd150, 8'd12, 32'd0};//{'dest': 150, 'src': 12, 'op': 'move'}
    instructions[452] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[453] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[454] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[455] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[456] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[457] = {6'd13, 8'd0, 8'd148, 32'd471};//{'src': 148, 'label': 471, 'op': 'jmp_if_false'}
    instructions[458] = {6'd0, 8'd150, 8'd0, 32'd2};//{'dest': 150, 'literal': 2, 'op': 'literal'}
    instructions[459] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[460] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[461] = {6'd11, 8'd151, 8'd150, 32'd42};//{'dest': 151, 'src': 150, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[462] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[463] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[464] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18335720, 'op': 'memory_read_request'}
    instructions[465] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[466] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18335720, 'op': 'memory_read_wait'}
    instructions[467] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18335720, 'element_size': 2, 'op': 'memory_read'}
    instructions[468] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[469] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[470] = {6'd26, 8'd148, 8'd149, 32'd65535};//{'dest': 148, 'src': 149, 'right': 65535, 'signed': False, 'op': '!='}
    instructions[471] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[472] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[473] = {6'd13, 8'd0, 8'd148, 32'd477};//{'src': 148, 'label': 477, 'op': 'jmp_if_false'}
    instructions[474] = {6'd0, 8'd41, 8'd0, 32'd0};//{'dest': 41, 'literal': 0, 'op': 'literal'}
    instructions[475] = {6'd6, 8'd0, 8'd40, 32'd0};//{'src': 40, 'op': 'jmp_to_reg'}
    instructions[476] = {6'd15, 8'd0, 8'd0, 32'd477};//{'label': 477, 'op': 'goto'}
    instructions[477] = {6'd0, 8'd150, 8'd0, 32'd6};//{'dest': 150, 'literal': 6, 'op': 'literal'}
    instructions[478] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[479] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[480] = {6'd11, 8'd151, 8'd150, 32'd42};//{'dest': 151, 'src': 150, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[481] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[482] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[483] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18336296, 'op': 'memory_read_request'}
    instructions[484] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[485] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18336296, 'op': 'memory_read_wait'}
    instructions[486] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18336296, 'element_size': 2, 'op': 'memory_read'}
    instructions[487] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[488] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[489] = {6'd25, 8'd148, 8'd149, 32'd2054};//{'dest': 148, 'src': 149, 'right': 2054, 'signed': False, 'op': '=='}
    instructions[490] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[491] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[492] = {6'd13, 8'd0, 8'd148, 32'd704};//{'src': 148, 'label': 704, 'op': 'jmp_if_false'}
    instructions[493] = {6'd0, 8'd150, 8'd0, 32'd10};//{'dest': 150, 'literal': 10, 'op': 'literal'}
    instructions[494] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[495] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[496] = {6'd11, 8'd151, 8'd150, 32'd42};//{'dest': 151, 'src': 150, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[497] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[498] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[499] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18336800, 'op': 'memory_read_request'}
    instructions[500] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[501] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18336800, 'op': 'memory_read_wait'}
    instructions[502] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18336800, 'element_size': 2, 'op': 'memory_read'}
    instructions[503] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[504] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[505] = {6'd25, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '=='}
    instructions[506] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[507] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[508] = {6'd13, 8'd0, 8'd148, 32'd701};//{'src': 148, 'label': 701, 'op': 'jmp_if_false'}
    instructions[509] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[510] = {6'd0, 8'd149, 8'd0, 32'd7};//{'dest': 149, 'literal': 7, 'op': 'literal'}
    instructions[511] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[512] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[513] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[514] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[515] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[516] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[517] = {6'd0, 8'd148, 8'd0, 32'd2048};//{'dest': 148, 'literal': 2048, 'op': 'literal'}
    instructions[518] = {6'd0, 8'd149, 8'd0, 32'd8};//{'dest': 149, 'literal': 8, 'op': 'literal'}
    instructions[519] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[520] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[521] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[522] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[523] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[524] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[525] = {6'd0, 8'd148, 8'd0, 32'd1540};//{'dest': 148, 'literal': 1540, 'op': 'literal'}
    instructions[526] = {6'd0, 8'd149, 8'd0, 32'd9};//{'dest': 149, 'literal': 9, 'op': 'literal'}
    instructions[527] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[528] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[529] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[530] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[531] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[532] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[533] = {6'd0, 8'd148, 8'd0, 32'd2};//{'dest': 148, 'literal': 2, 'op': 'literal'}
    instructions[534] = {6'd0, 8'd149, 8'd0, 32'd10};//{'dest': 149, 'literal': 10, 'op': 'literal'}
    instructions[535] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[536] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[537] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[538] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[539] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[540] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[541] = {6'd3, 8'd148, 8'd10, 32'd0};//{'dest': 148, 'src': 10, 'op': 'move'}
    instructions[542] = {6'd0, 8'd149, 8'd0, 32'd11};//{'dest': 149, 'literal': 11, 'op': 'literal'}
    instructions[543] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[544] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[545] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[546] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[547] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[548] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[549] = {6'd3, 8'd148, 8'd11, 32'd0};//{'dest': 148, 'src': 11, 'op': 'move'}
    instructions[550] = {6'd0, 8'd149, 8'd0, 32'd12};//{'dest': 149, 'literal': 12, 'op': 'literal'}
    instructions[551] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[552] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[553] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[554] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[555] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[556] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[557] = {6'd3, 8'd148, 8'd12, 32'd0};//{'dest': 148, 'src': 12, 'op': 'move'}
    instructions[558] = {6'd0, 8'd149, 8'd0, 32'd13};//{'dest': 149, 'literal': 13, 'op': 'literal'}
    instructions[559] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[560] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[561] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[562] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[563] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[564] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[565] = {6'd3, 8'd148, 8'd13, 32'd0};//{'dest': 148, 'src': 13, 'op': 'move'}
    instructions[566] = {6'd0, 8'd149, 8'd0, 32'd14};//{'dest': 149, 'literal': 14, 'op': 'literal'}
    instructions[567] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[568] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[569] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[570] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[571] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[572] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[573] = {6'd3, 8'd148, 8'd14, 32'd0};//{'dest': 148, 'src': 14, 'op': 'move'}
    instructions[574] = {6'd0, 8'd149, 8'd0, 32'd15};//{'dest': 149, 'literal': 15, 'op': 'literal'}
    instructions[575] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[576] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[577] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[578] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[579] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[580] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[581] = {6'd0, 8'd149, 8'd0, 32'd11};//{'dest': 149, 'literal': 11, 'op': 'literal'}
    instructions[582] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[583] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[584] = {6'd11, 8'd150, 8'd149, 32'd42};//{'dest': 150, 'src': 149, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[585] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[586] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[587] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18340680, 'op': 'memory_read_request'}
    instructions[588] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[589] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18340680, 'op': 'memory_read_wait'}
    instructions[590] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18340680, 'element_size': 2, 'op': 'memory_read'}
    instructions[591] = {6'd0, 8'd149, 8'd0, 32'd16};//{'dest': 149, 'literal': 16, 'op': 'literal'}
    instructions[592] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[593] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[594] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[595] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[596] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[597] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[598] = {6'd0, 8'd149, 8'd0, 32'd12};//{'dest': 149, 'literal': 12, 'op': 'literal'}
    instructions[599] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[600] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[601] = {6'd11, 8'd150, 8'd149, 32'd42};//{'dest': 150, 'src': 149, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[602] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[603] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[604] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18341112, 'op': 'memory_read_request'}
    instructions[605] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[606] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18341112, 'op': 'memory_read_wait'}
    instructions[607] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18341112, 'element_size': 2, 'op': 'memory_read'}
    instructions[608] = {6'd0, 8'd149, 8'd0, 32'd17};//{'dest': 149, 'literal': 17, 'op': 'literal'}
    instructions[609] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[610] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[611] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[612] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[613] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[614] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[615] = {6'd0, 8'd149, 8'd0, 32'd13};//{'dest': 149, 'literal': 13, 'op': 'literal'}
    instructions[616] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[617] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[618] = {6'd11, 8'd150, 8'd149, 32'd42};//{'dest': 150, 'src': 149, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[619] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[620] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[621] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18341544, 'op': 'memory_read_request'}
    instructions[622] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[623] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18341544, 'op': 'memory_read_wait'}
    instructions[624] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18341544, 'element_size': 2, 'op': 'memory_read'}
    instructions[625] = {6'd0, 8'd149, 8'd0, 32'd18};//{'dest': 149, 'literal': 18, 'op': 'literal'}
    instructions[626] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[627] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[628] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[629] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[630] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[631] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[632] = {6'd0, 8'd149, 8'd0, 32'd14};//{'dest': 149, 'literal': 14, 'op': 'literal'}
    instructions[633] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[634] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[635] = {6'd11, 8'd150, 8'd149, 32'd42};//{'dest': 150, 'src': 149, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[636] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[637] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[638] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18342040, 'op': 'memory_read_request'}
    instructions[639] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[640] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18342040, 'op': 'memory_read_wait'}
    instructions[641] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18342040, 'element_size': 2, 'op': 'memory_read'}
    instructions[642] = {6'd0, 8'd149, 8'd0, 32'd19};//{'dest': 149, 'literal': 19, 'op': 'literal'}
    instructions[643] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[644] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[645] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[646] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[647] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[648] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[649] = {6'd0, 8'd149, 8'd0, 32'd15};//{'dest': 149, 'literal': 15, 'op': 'literal'}
    instructions[650] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[651] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[652] = {6'd11, 8'd150, 8'd149, 32'd42};//{'dest': 150, 'src': 149, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[653] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[654] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[655] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18342472, 'op': 'memory_read_request'}
    instructions[656] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[657] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18342472, 'op': 'memory_read_wait'}
    instructions[658] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18342472, 'element_size': 2, 'op': 'memory_read'}
    instructions[659] = {6'd0, 8'd149, 8'd0, 32'd20};//{'dest': 149, 'literal': 20, 'op': 'literal'}
    instructions[660] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[661] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[662] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[663] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[664] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[665] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[666] = {6'd3, 8'd32, 8'd16, 32'd0};//{'dest': 32, 'src': 16, 'op': 'move'}
    instructions[667] = {6'd0, 8'd33, 8'd0, 32'd64};//{'dest': 33, 'literal': 64, 'op': 'literal'}
    instructions[668] = {6'd0, 8'd149, 8'd0, 32'd11};//{'dest': 149, 'literal': 11, 'op': 'literal'}
    instructions[669] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[670] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[671] = {6'd11, 8'd150, 8'd149, 32'd42};//{'dest': 150, 'src': 149, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[672] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[673] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[674] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18347360, 'op': 'memory_read_request'}
    instructions[675] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[676] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18347360, 'op': 'memory_read_wait'}
    instructions[677] = {6'd19, 8'd34, 8'd150, 32'd0};//{'dest': 34, 'src': 150, 'sequence': 18347360, 'element_size': 2, 'op': 'memory_read'}
    instructions[678] = {6'd0, 8'd149, 8'd0, 32'd12};//{'dest': 149, 'literal': 12, 'op': 'literal'}
    instructions[679] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[680] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[681] = {6'd11, 8'd150, 8'd149, 32'd42};//{'dest': 150, 'src': 149, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[682] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[683] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[684] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18347504, 'op': 'memory_read_request'}
    instructions[685] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[686] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18347504, 'op': 'memory_read_wait'}
    instructions[687] = {6'd19, 8'd35, 8'd150, 32'd0};//{'dest': 35, 'src': 150, 'sequence': 18347504, 'element_size': 2, 'op': 'memory_read'}
    instructions[688] = {6'd0, 8'd149, 8'd0, 32'd13};//{'dest': 149, 'literal': 13, 'op': 'literal'}
    instructions[689] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[690] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[691] = {6'd11, 8'd150, 8'd149, 32'd42};//{'dest': 150, 'src': 149, 'srcb': 42, 'signed': False, 'op': '+'}
    instructions[692] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[693] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[694] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18347648, 'op': 'memory_read_request'}
    instructions[695] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[696] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18347648, 'op': 'memory_read_wait'}
    instructions[697] = {6'd19, 8'd36, 8'd150, 32'd0};//{'dest': 36, 'src': 150, 'sequence': 18347648, 'element_size': 2, 'op': 'memory_read'}
    instructions[698] = {6'd0, 8'd37, 8'd0, 32'd2054};//{'dest': 37, 'literal': 2054, 'op': 'literal'}
    instructions[699] = {6'd1, 8'd31, 8'd0, 32'd209};//{'dest': 31, 'label': 209, 'op': 'jmp_and_link'}
    instructions[700] = {6'd15, 8'd0, 8'd0, 32'd701};//{'label': 701, 'op': 'goto'}
    instructions[701] = {6'd0, 8'd41, 8'd0, 32'd0};//{'dest': 41, 'literal': 0, 'op': 'literal'}
    instructions[702] = {6'd6, 8'd0, 8'd40, 32'd0};//{'src': 40, 'op': 'jmp_to_reg'}
    instructions[703] = {6'd15, 8'd0, 8'd0, 32'd704};//{'label': 704, 'op': 'goto'}
    instructions[704] = {6'd3, 8'd41, 8'd43, 32'd0};//{'dest': 41, 'src': 43, 'op': 'move'}
    instructions[705] = {6'd6, 8'd0, 8'd40, 32'd0};//{'src': 40, 'op': 'jmp_to_reg'}
    instructions[706] = {6'd0, 8'd56, 8'd0, 32'd0};//{'dest': 56, 'literal': 0, 'op': 'literal'}
    instructions[707] = {6'd0, 8'd57, 8'd0, 32'd0};//{'dest': 57, 'literal': 0, 'op': 'literal'}
    instructions[708] = {6'd0, 8'd58, 8'd0, 32'd592};//{'dest': 58, 'literal': 592, 'op': 'literal'}
    instructions[709] = {6'd0, 8'd59, 8'd0, 32'd0};//{'dest': 59, 'literal': 0, 'op': 'literal'}
    instructions[710] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[711] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[712] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[713] = {6'd3, 8'd59, 8'd148, 32'd0};//{'dest': 59, 'src': 148, 'op': 'move'}
    instructions[714] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[715] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[716] = {6'd3, 8'd149, 8'd59, 32'd0};//{'dest': 149, 'src': 59, 'op': 'move'}
    instructions[717] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[718] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[719] = {6'd27, 8'd148, 8'd149, 32'd16};//{'dest': 148, 'src': 149, 'right': 16, 'signed': False, 'op': '<'}
    instructions[720] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[721] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[722] = {6'd13, 8'd0, 8'd148, 32'd763};//{'src': 148, 'label': 763, 'op': 'jmp_if_false'}
    instructions[723] = {6'd3, 8'd150, 8'd59, 32'd0};//{'dest': 150, 'src': 59, 'op': 'move'}
    instructions[724] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[725] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[726] = {6'd11, 8'd151, 8'd150, 32'd46};//{'dest': 151, 'src': 150, 'srcb': 46, 'signed': False, 'op': '+'}
    instructions[727] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[728] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[729] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18347288, 'op': 'memory_read_request'}
    instructions[730] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[731] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18347288, 'op': 'memory_read_wait'}
    instructions[732] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18347288, 'element_size': 2, 'op': 'memory_read'}
    instructions[733] = {6'd3, 8'd150, 8'd54, 32'd0};//{'dest': 150, 'src': 54, 'op': 'move'}
    instructions[734] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[735] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[736] = {6'd28, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '=='}
    instructions[737] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[738] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[739] = {6'd13, 8'd0, 8'd148, 32'd754};//{'src': 148, 'label': 754, 'op': 'jmp_if_false'}
    instructions[740] = {6'd3, 8'd150, 8'd59, 32'd0};//{'dest': 150, 'src': 59, 'op': 'move'}
    instructions[741] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[742] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[743] = {6'd11, 8'd151, 8'd150, 32'd47};//{'dest': 151, 'src': 150, 'srcb': 47, 'signed': False, 'op': '+'}
    instructions[744] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[745] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[746] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18348008, 'op': 'memory_read_request'}
    instructions[747] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[748] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18348008, 'op': 'memory_read_wait'}
    instructions[749] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18348008, 'element_size': 2, 'op': 'memory_read'}
    instructions[750] = {6'd3, 8'd150, 8'd55, 32'd0};//{'dest': 150, 'src': 55, 'op': 'move'}
    instructions[751] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[752] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[753] = {6'd28, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '=='}
    instructions[754] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[755] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[756] = {6'd13, 8'd0, 8'd148, 32'd760};//{'src': 148, 'label': 760, 'op': 'jmp_if_false'}
    instructions[757] = {6'd3, 8'd53, 8'd59, 32'd0};//{'dest': 53, 'src': 59, 'op': 'move'}
    instructions[758] = {6'd6, 8'd0, 8'd52, 32'd0};//{'src': 52, 'op': 'jmp_to_reg'}
    instructions[759] = {6'd15, 8'd0, 8'd0, 32'd760};//{'label': 760, 'op': 'goto'}
    instructions[760] = {6'd3, 8'd148, 8'd59, 32'd0};//{'dest': 148, 'src': 59, 'op': 'move'}
    instructions[761] = {6'd14, 8'd59, 8'd59, 32'd1};//{'dest': 59, 'src': 59, 'right': 1, 'signed': False, 'op': '+'}
    instructions[762] = {6'd15, 8'd0, 8'd0, 32'd714};//{'label': 714, 'op': 'goto'}
    instructions[763] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[764] = {6'd0, 8'd149, 8'd0, 32'd7};//{'dest': 149, 'literal': 7, 'op': 'literal'}
    instructions[765] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[766] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[767] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[768] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[769] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[770] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[771] = {6'd0, 8'd148, 8'd0, 32'd2048};//{'dest': 148, 'literal': 2048, 'op': 'literal'}
    instructions[772] = {6'd0, 8'd149, 8'd0, 32'd8};//{'dest': 149, 'literal': 8, 'op': 'literal'}
    instructions[773] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[774] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[775] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[776] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[777] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[778] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[779] = {6'd0, 8'd148, 8'd0, 32'd1540};//{'dest': 148, 'literal': 1540, 'op': 'literal'}
    instructions[780] = {6'd0, 8'd149, 8'd0, 32'd9};//{'dest': 149, 'literal': 9, 'op': 'literal'}
    instructions[781] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[782] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[783] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[784] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[785] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[786] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[787] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[788] = {6'd0, 8'd149, 8'd0, 32'd10};//{'dest': 149, 'literal': 10, 'op': 'literal'}
    instructions[789] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[790] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[791] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[792] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[793] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[794] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[795] = {6'd3, 8'd148, 8'd10, 32'd0};//{'dest': 148, 'src': 10, 'op': 'move'}
    instructions[796] = {6'd0, 8'd149, 8'd0, 32'd11};//{'dest': 149, 'literal': 11, 'op': 'literal'}
    instructions[797] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[798] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[799] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[800] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[801] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[802] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[803] = {6'd3, 8'd148, 8'd11, 32'd0};//{'dest': 148, 'src': 11, 'op': 'move'}
    instructions[804] = {6'd0, 8'd149, 8'd0, 32'd12};//{'dest': 149, 'literal': 12, 'op': 'literal'}
    instructions[805] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[806] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[807] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[808] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[809] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[810] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[811] = {6'd3, 8'd148, 8'd12, 32'd0};//{'dest': 148, 'src': 12, 'op': 'move'}
    instructions[812] = {6'd0, 8'd149, 8'd0, 32'd13};//{'dest': 149, 'literal': 13, 'op': 'literal'}
    instructions[813] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[814] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[815] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[816] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[817] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[818] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[819] = {6'd3, 8'd148, 8'd13, 32'd0};//{'dest': 148, 'src': 13, 'op': 'move'}
    instructions[820] = {6'd0, 8'd149, 8'd0, 32'd14};//{'dest': 149, 'literal': 14, 'op': 'literal'}
    instructions[821] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[822] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[823] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[824] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[825] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[826] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[827] = {6'd3, 8'd148, 8'd14, 32'd0};//{'dest': 148, 'src': 14, 'op': 'move'}
    instructions[828] = {6'd0, 8'd149, 8'd0, 32'd15};//{'dest': 149, 'literal': 15, 'op': 'literal'}
    instructions[829] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[830] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[831] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[832] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[833] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[834] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[835] = {6'd3, 8'd148, 8'd54, 32'd0};//{'dest': 148, 'src': 54, 'op': 'move'}
    instructions[836] = {6'd0, 8'd149, 8'd0, 32'd19};//{'dest': 149, 'literal': 19, 'op': 'literal'}
    instructions[837] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[838] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[839] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[840] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[841] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[842] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[843] = {6'd3, 8'd148, 8'd55, 32'd0};//{'dest': 148, 'src': 55, 'op': 'move'}
    instructions[844] = {6'd0, 8'd149, 8'd0, 32'd20};//{'dest': 149, 'literal': 20, 'op': 'literal'}
    instructions[845] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[846] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[847] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[848] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[849] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[850] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[851] = {6'd3, 8'd32, 8'd16, 32'd0};//{'dest': 32, 'src': 16, 'op': 'move'}
    instructions[852] = {6'd0, 8'd33, 8'd0, 32'd64};//{'dest': 33, 'literal': 64, 'op': 'literal'}
    instructions[853] = {6'd0, 8'd34, 8'd0, 32'd65535};//{'dest': 34, 'literal': 65535, 'op': 'literal'}
    instructions[854] = {6'd0, 8'd35, 8'd0, 32'd65535};//{'dest': 35, 'literal': 65535, 'op': 'literal'}
    instructions[855] = {6'd0, 8'd36, 8'd0, 32'd65535};//{'dest': 36, 'literal': 65535, 'op': 'literal'}
    instructions[856] = {6'd0, 8'd37, 8'd0, 32'd2054};//{'dest': 37, 'literal': 2054, 'op': 'literal'}
    instructions[857] = {6'd1, 8'd31, 8'd0, 32'd209};//{'dest': 31, 'label': 209, 'op': 'jmp_and_link'}
    instructions[858] = {6'd1, 8'd4, 8'd0, 32'd50};//{'dest': 4, 'label': 50, 'op': 'jmp_and_link'}
    instructions[859] = {6'd3, 8'd148, 8'd5, 32'd0};//{'dest': 148, 'src': 5, 'op': 'move'}
    instructions[860] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[861] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[862] = {6'd3, 8'd56, 8'd148, 32'd0};//{'dest': 56, 'src': 148, 'op': 'move'}
    instructions[863] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[864] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[865] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[866] = {6'd3, 8'd59, 8'd148, 32'd0};//{'dest': 59, 'src': 148, 'op': 'move'}
    instructions[867] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[868] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[869] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[870] = {6'd3, 8'd57, 8'd148, 32'd0};//{'dest': 57, 'src': 148, 'op': 'move'}
    instructions[871] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[872] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[873] = {6'd3, 8'd149, 8'd57, 32'd0};//{'dest': 149, 'src': 57, 'op': 'move'}
    instructions[874] = {6'd3, 8'd150, 8'd56, 32'd0};//{'dest': 150, 'src': 56, 'op': 'move'}
    instructions[875] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[876] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[877] = {6'd20, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '<'}
    instructions[878] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[879] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[880] = {6'd13, 8'd0, 8'd148, 32'd910};//{'src': 148, 'label': 910, 'op': 'jmp_if_false'}
    instructions[881] = {6'd3, 8'd149, 8'd59, 32'd0};//{'dest': 149, 'src': 59, 'op': 'move'}
    instructions[882] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[883] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[884] = {6'd27, 8'd148, 8'd149, 32'd16};//{'dest': 148, 'src': 149, 'right': 16, 'signed': False, 'op': '<'}
    instructions[885] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[886] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[887] = {6'd13, 8'd0, 8'd148, 32'd898};//{'src': 148, 'label': 898, 'op': 'jmp_if_false'}
    instructions[888] = {6'd1, 8'd4, 8'd0, 32'd50};//{'dest': 4, 'label': 50, 'op': 'jmp_and_link'}
    instructions[889] = {6'd3, 8'd148, 8'd5, 32'd0};//{'dest': 148, 'src': 5, 'op': 'move'}
    instructions[890] = {6'd3, 8'd149, 8'd59, 32'd0};//{'dest': 149, 'src': 59, 'op': 'move'}
    instructions[891] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[892] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[893] = {6'd11, 8'd150, 8'd149, 32'd58};//{'dest': 150, 'src': 149, 'srcb': 58, 'signed': False, 'op': '+'}
    instructions[894] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[895] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[896] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[897] = {6'd15, 8'd0, 8'd0, 32'd900};//{'label': 900, 'op': 'goto'}
    instructions[898] = {6'd1, 8'd4, 8'd0, 32'd50};//{'dest': 4, 'label': 50, 'op': 'jmp_and_link'}
    instructions[899] = {6'd3, 8'd148, 8'd5, 32'd0};//{'dest': 148, 'src': 5, 'op': 'move'}
    instructions[900] = {6'd3, 8'd148, 8'd59, 32'd0};//{'dest': 148, 'src': 59, 'op': 'move'}
    instructions[901] = {6'd14, 8'd59, 8'd59, 32'd1};//{'dest': 59, 'src': 59, 'right': 1, 'signed': False, 'op': '+'}
    instructions[902] = {6'd3, 8'd149, 8'd57, 32'd0};//{'dest': 149, 'src': 57, 'op': 'move'}
    instructions[903] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[904] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[905] = {6'd14, 8'd148, 8'd149, 32'd2};//{'dest': 148, 'src': 149, 'right': 2, 'signed': False, 'op': '+'}
    instructions[906] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[907] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[908] = {6'd3, 8'd57, 8'd148, 32'd0};//{'dest': 57, 'src': 148, 'op': 'move'}
    instructions[909] = {6'd15, 8'd0, 8'd0, 32'd871};//{'label': 871, 'op': 'goto'}
    instructions[910] = {6'd0, 8'd150, 8'd0, 32'd6};//{'dest': 150, 'literal': 6, 'op': 'literal'}
    instructions[911] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[912] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[913] = {6'd11, 8'd151, 8'd150, 32'd58};//{'dest': 151, 'src': 150, 'srcb': 58, 'signed': False, 'op': '+'}
    instructions[914] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[915] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[916] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18357208, 'op': 'memory_read_request'}
    instructions[917] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[918] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18357208, 'op': 'memory_read_wait'}
    instructions[919] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18357208, 'element_size': 2, 'op': 'memory_read'}
    instructions[920] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[921] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[922] = {6'd25, 8'd148, 8'd149, 32'd2054};//{'dest': 148, 'src': 149, 'right': 2054, 'signed': False, 'op': '=='}
    instructions[923] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[924] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[925] = {6'd13, 8'd0, 8'd148, 32'd939};//{'src': 148, 'label': 939, 'op': 'jmp_if_false'}
    instructions[926] = {6'd0, 8'd150, 8'd0, 32'd10};//{'dest': 150, 'literal': 10, 'op': 'literal'}
    instructions[927] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[928] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[929] = {6'd11, 8'd151, 8'd150, 32'd58};//{'dest': 151, 'src': 150, 'srcb': 58, 'signed': False, 'op': '+'}
    instructions[930] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[931] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[932] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18357496, 'op': 'memory_read_request'}
    instructions[933] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[934] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18357496, 'op': 'memory_read_wait'}
    instructions[935] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18357496, 'element_size': 2, 'op': 'memory_read'}
    instructions[936] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[937] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[938] = {6'd25, 8'd148, 8'd149, 32'd2};//{'dest': 148, 'src': 149, 'right': 2, 'signed': False, 'op': '=='}
    instructions[939] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[940] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[941] = {6'd13, 8'd0, 8'd148, 32'd1067};//{'src': 148, 'label': 1067, 'op': 'jmp_if_false'}
    instructions[942] = {6'd0, 8'd150, 8'd0, 32'd14};//{'dest': 150, 'literal': 14, 'op': 'literal'}
    instructions[943] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[944] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[945] = {6'd11, 8'd151, 8'd150, 32'd58};//{'dest': 151, 'src': 150, 'srcb': 58, 'signed': False, 'op': '+'}
    instructions[946] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[947] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[948] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18358072, 'op': 'memory_read_request'}
    instructions[949] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[950] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18358072, 'op': 'memory_read_wait'}
    instructions[951] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18358072, 'element_size': 2, 'op': 'memory_read'}
    instructions[952] = {6'd3, 8'd150, 8'd54, 32'd0};//{'dest': 150, 'src': 54, 'op': 'move'}
    instructions[953] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[954] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[955] = {6'd28, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '=='}
    instructions[956] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[957] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[958] = {6'd13, 8'd0, 8'd148, 32'd973};//{'src': 148, 'label': 973, 'op': 'jmp_if_false'}
    instructions[959] = {6'd0, 8'd150, 8'd0, 32'd15};//{'dest': 150, 'literal': 15, 'op': 'literal'}
    instructions[960] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[961] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[962] = {6'd11, 8'd151, 8'd150, 32'd58};//{'dest': 151, 'src': 150, 'srcb': 58, 'signed': False, 'op': '+'}
    instructions[963] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[964] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[965] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18358424, 'op': 'memory_read_request'}
    instructions[966] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[967] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18358424, 'op': 'memory_read_wait'}
    instructions[968] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18358424, 'element_size': 2, 'op': 'memory_read'}
    instructions[969] = {6'd3, 8'd150, 8'd55, 32'd0};//{'dest': 150, 'src': 55, 'op': 'move'}
    instructions[970] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[971] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[972] = {6'd28, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '=='}
    instructions[973] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[974] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[975] = {6'd13, 8'd0, 8'd148, 32'd1066};//{'src': 148, 'label': 1066, 'op': 'jmp_if_false'}
    instructions[976] = {6'd3, 8'd148, 8'd54, 32'd0};//{'dest': 148, 'src': 54, 'op': 'move'}
    instructions[977] = {6'd3, 8'd149, 8'd51, 32'd0};//{'dest': 149, 'src': 51, 'op': 'move'}
    instructions[978] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[979] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[980] = {6'd11, 8'd150, 8'd149, 32'd46};//{'dest': 150, 'src': 149, 'srcb': 46, 'signed': False, 'op': '+'}
    instructions[981] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[982] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[983] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[984] = {6'd3, 8'd148, 8'd55, 32'd0};//{'dest': 148, 'src': 55, 'op': 'move'}
    instructions[985] = {6'd3, 8'd149, 8'd51, 32'd0};//{'dest': 149, 'src': 51, 'op': 'move'}
    instructions[986] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[987] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[988] = {6'd11, 8'd150, 8'd149, 32'd47};//{'dest': 150, 'src': 149, 'srcb': 47, 'signed': False, 'op': '+'}
    instructions[989] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[990] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[991] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[992] = {6'd0, 8'd149, 8'd0, 32'd11};//{'dest': 149, 'literal': 11, 'op': 'literal'}
    instructions[993] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[994] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[995] = {6'd11, 8'd150, 8'd149, 32'd58};//{'dest': 150, 'src': 149, 'srcb': 58, 'signed': False, 'op': '+'}
    instructions[996] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[997] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[998] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18359792, 'op': 'memory_read_request'}
    instructions[999] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1000] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18359792, 'op': 'memory_read_wait'}
    instructions[1001] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18359792, 'element_size': 2, 'op': 'memory_read'}
    instructions[1002] = {6'd3, 8'd149, 8'd51, 32'd0};//{'dest': 149, 'src': 51, 'op': 'move'}
    instructions[1003] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1004] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1005] = {6'd11, 8'd150, 8'd149, 32'd48};//{'dest': 150, 'src': 149, 'srcb': 48, 'signed': False, 'op': '+'}
    instructions[1006] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1007] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1008] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1009] = {6'd0, 8'd149, 8'd0, 32'd12};//{'dest': 149, 'literal': 12, 'op': 'literal'}
    instructions[1010] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1011] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1012] = {6'd11, 8'd150, 8'd149, 32'd58};//{'dest': 150, 'src': 149, 'srcb': 58, 'signed': False, 'op': '+'}
    instructions[1013] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1014] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1015] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18360224, 'op': 'memory_read_request'}
    instructions[1016] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1017] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18360224, 'op': 'memory_read_wait'}
    instructions[1018] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18360224, 'element_size': 2, 'op': 'memory_read'}
    instructions[1019] = {6'd3, 8'd149, 8'd51, 32'd0};//{'dest': 149, 'src': 51, 'op': 'move'}
    instructions[1020] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1021] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1022] = {6'd11, 8'd150, 8'd149, 32'd49};//{'dest': 150, 'src': 149, 'srcb': 49, 'signed': False, 'op': '+'}
    instructions[1023] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1024] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1025] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1026] = {6'd0, 8'd149, 8'd0, 32'd13};//{'dest': 149, 'literal': 13, 'op': 'literal'}
    instructions[1027] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1028] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1029] = {6'd11, 8'd150, 8'd149, 32'd58};//{'dest': 150, 'src': 149, 'srcb': 58, 'signed': False, 'op': '+'}
    instructions[1030] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1031] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1032] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18360656, 'op': 'memory_read_request'}
    instructions[1033] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1034] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18360656, 'op': 'memory_read_wait'}
    instructions[1035] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18360656, 'element_size': 2, 'op': 'memory_read'}
    instructions[1036] = {6'd3, 8'd149, 8'd51, 32'd0};//{'dest': 149, 'src': 51, 'op': 'move'}
    instructions[1037] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1038] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1039] = {6'd11, 8'd150, 8'd149, 32'd50};//{'dest': 150, 'src': 149, 'srcb': 50, 'signed': False, 'op': '+'}
    instructions[1040] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1041] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1042] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1043] = {6'd3, 8'd148, 8'd51, 32'd0};//{'dest': 148, 'src': 51, 'op': 'move'}
    instructions[1044] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1045] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1046] = {6'd3, 8'd59, 8'd148, 32'd0};//{'dest': 59, 'src': 148, 'op': 'move'}
    instructions[1047] = {6'd3, 8'd148, 8'd51, 32'd0};//{'dest': 148, 'src': 51, 'op': 'move'}
    instructions[1048] = {6'd14, 8'd51, 8'd51, 32'd1};//{'dest': 51, 'src': 51, 'right': 1, 'signed': False, 'op': '+'}
    instructions[1049] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1050] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1051] = {6'd3, 8'd149, 8'd51, 32'd0};//{'dest': 149, 'src': 51, 'op': 'move'}
    instructions[1052] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1053] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1054] = {6'd25, 8'd148, 8'd149, 32'd16};//{'dest': 148, 'src': 149, 'right': 16, 'signed': False, 'op': '=='}
    instructions[1055] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1056] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1057] = {6'd13, 8'd0, 8'd148, 32'd1063};//{'src': 148, 'label': 1063, 'op': 'jmp_if_false'}
    instructions[1058] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[1059] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1060] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1061] = {6'd3, 8'd51, 8'd148, 32'd0};//{'dest': 51, 'src': 148, 'op': 'move'}
    instructions[1062] = {6'd15, 8'd0, 8'd0, 32'd1063};//{'label': 1063, 'op': 'goto'}
    instructions[1063] = {6'd3, 8'd53, 8'd59, 32'd0};//{'dest': 53, 'src': 59, 'op': 'move'}
    instructions[1064] = {6'd6, 8'd0, 8'd52, 32'd0};//{'src': 52, 'op': 'jmp_to_reg'}
    instructions[1065] = {6'd15, 8'd0, 8'd0, 32'd1066};//{'label': 1066, 'op': 'goto'}
    instructions[1066] = {6'd15, 8'd0, 8'd0, 32'd1067};//{'label': 1067, 'op': 'goto'}
    instructions[1067] = {6'd15, 8'd0, 8'd0, 32'd858};//{'label': 858, 'op': 'goto'}
    instructions[1068] = {6'd0, 8'd66, 8'd0, 32'd0};//{'dest': 66, 'literal': 0, 'op': 'literal'}
    instructions[1069] = {6'd0, 8'd67, 8'd0, 32'd0};//{'dest': 67, 'literal': 0, 'op': 'literal'}
    instructions[1070] = {6'd0, 8'd68, 8'd0, 32'd0};//{'dest': 68, 'literal': 0, 'op': 'literal'}
    instructions[1071] = {6'd3, 8'd54, 8'd64, 32'd0};//{'dest': 54, 'src': 64, 'op': 'move'}
    instructions[1072] = {6'd3, 8'd55, 8'd65, 32'd0};//{'dest': 55, 'src': 65, 'op': 'move'}
    instructions[1073] = {6'd1, 8'd52, 8'd0, 32'd706};//{'dest': 52, 'label': 706, 'op': 'jmp_and_link'}
    instructions[1074] = {6'd3, 8'd148, 8'd53, 32'd0};//{'dest': 148, 'src': 53, 'op': 'move'}
    instructions[1075] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1076] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1077] = {6'd3, 8'd68, 8'd148, 32'd0};//{'dest': 68, 'src': 148, 'op': 'move'}
    instructions[1078] = {6'd0, 8'd148, 8'd0, 32'd17664};//{'dest': 148, 'literal': 17664, 'op': 'literal'}
    instructions[1079] = {6'd0, 8'd149, 8'd0, 32'd7};//{'dest': 149, 'literal': 7, 'op': 'literal'}
    instructions[1080] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1081] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1082] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1083] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1084] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1085] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1086] = {6'd3, 8'd148, 8'd62, 32'd0};//{'dest': 148, 'src': 62, 'op': 'move'}
    instructions[1087] = {6'd0, 8'd149, 8'd0, 32'd8};//{'dest': 149, 'literal': 8, 'op': 'literal'}
    instructions[1088] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1089] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1090] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1091] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1092] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1093] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1094] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[1095] = {6'd0, 8'd149, 8'd0, 32'd9};//{'dest': 149, 'literal': 9, 'op': 'literal'}
    instructions[1096] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1097] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1098] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1099] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1100] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1101] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1102] = {6'd0, 8'd148, 8'd0, 32'd16384};//{'dest': 148, 'literal': 16384, 'op': 'literal'}
    instructions[1103] = {6'd0, 8'd149, 8'd0, 32'd10};//{'dest': 149, 'literal': 10, 'op': 'literal'}
    instructions[1104] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1105] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1106] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1107] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1108] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1109] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1110] = {6'd3, 8'd149, 8'd63, 32'd0};//{'dest': 149, 'src': 63, 'op': 'move'}
    instructions[1111] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1112] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1113] = {6'd29, 8'd148, 8'd149, 32'd65280};//{'dest': 148, 'src': 149, 'left': 65280, 'signed': False, 'op': '|'}
    instructions[1114] = {6'd0, 8'd149, 8'd0, 32'd11};//{'dest': 149, 'literal': 11, 'op': 'literal'}
    instructions[1115] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1116] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1117] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1118] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1119] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1120] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1121] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[1122] = {6'd0, 8'd149, 8'd0, 32'd12};//{'dest': 149, 'literal': 12, 'op': 'literal'}
    instructions[1123] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1124] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1125] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1126] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1127] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1128] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1129] = {6'd3, 8'd148, 8'd13, 32'd0};//{'dest': 148, 'src': 13, 'op': 'move'}
    instructions[1130] = {6'd0, 8'd149, 8'd0, 32'd13};//{'dest': 149, 'literal': 13, 'op': 'literal'}
    instructions[1131] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1132] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1133] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1134] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1135] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1136] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1137] = {6'd3, 8'd148, 8'd14, 32'd0};//{'dest': 148, 'src': 14, 'op': 'move'}
    instructions[1138] = {6'd0, 8'd149, 8'd0, 32'd14};//{'dest': 149, 'literal': 14, 'op': 'literal'}
    instructions[1139] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1140] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1141] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1142] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1143] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1144] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1145] = {6'd3, 8'd148, 8'd64, 32'd0};//{'dest': 148, 'src': 64, 'op': 'move'}
    instructions[1146] = {6'd0, 8'd149, 8'd0, 32'd15};//{'dest': 149, 'literal': 15, 'op': 'literal'}
    instructions[1147] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1148] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1149] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1150] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1151] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1152] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1153] = {6'd3, 8'd148, 8'd65, 32'd0};//{'dest': 148, 'src': 65, 'op': 'move'}
    instructions[1154] = {6'd0, 8'd149, 8'd0, 32'd16};//{'dest': 149, 'literal': 16, 'op': 'literal'}
    instructions[1155] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1156] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1157] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1158] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1159] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1160] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1161] = {6'd3, 8'd149, 8'd62, 32'd0};//{'dest': 149, 'src': 62, 'op': 'move'}
    instructions[1162] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1163] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1164] = {6'd14, 8'd148, 8'd149, 32'd14};//{'dest': 148, 'src': 149, 'right': 14, 'signed': False, 'op': '+'}
    instructions[1165] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1166] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1167] = {6'd3, 8'd66, 8'd148, 32'd0};//{'dest': 66, 'src': 148, 'op': 'move'}
    instructions[1168] = {6'd1, 8'd18, 8'd0, 32'd56};//{'dest': 18, 'label': 56, 'op': 'jmp_and_link'}
    instructions[1169] = {6'd0, 8'd148, 8'd0, 32'd7};//{'dest': 148, 'literal': 7, 'op': 'literal'}
    instructions[1170] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1171] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1172] = {6'd3, 8'd67, 8'd148, 32'd0};//{'dest': 67, 'src': 148, 'op': 'move'}
    instructions[1173] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1174] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1175] = {6'd3, 8'd149, 8'd67, 32'd0};//{'dest': 149, 'src': 67, 'op': 'move'}
    instructions[1176] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1177] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1178] = {6'd30, 8'd148, 8'd149, 32'd16};//{'dest': 148, 'src': 149, 'right': 16, 'signed': False, 'op': '<='}
    instructions[1179] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1180] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1181] = {6'd13, 8'd0, 8'd148, 32'd1196};//{'src': 148, 'label': 1196, 'op': 'jmp_if_false'}
    instructions[1182] = {6'd3, 8'd149, 8'd67, 32'd0};//{'dest': 149, 'src': 67, 'op': 'move'}
    instructions[1183] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1184] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1185] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1186] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1187] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1188] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18373736, 'op': 'memory_read_request'}
    instructions[1189] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1190] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18373736, 'op': 'memory_read_wait'}
    instructions[1191] = {6'd19, 8'd20, 8'd150, 32'd0};//{'dest': 20, 'src': 150, 'sequence': 18373736, 'element_size': 2, 'op': 'memory_read'}
    instructions[1192] = {6'd1, 8'd19, 8'd0, 32'd61};//{'dest': 19, 'label': 61, 'op': 'jmp_and_link'}
    instructions[1193] = {6'd3, 8'd148, 8'd67, 32'd0};//{'dest': 148, 'src': 67, 'op': 'move'}
    instructions[1194] = {6'd14, 8'd67, 8'd67, 32'd1};//{'dest': 67, 'src': 67, 'right': 1, 'signed': False, 'op': '+'}
    instructions[1195] = {6'd15, 8'd0, 8'd0, 32'd1173};//{'label': 1173, 'op': 'goto'}
    instructions[1196] = {6'd1, 8'd21, 8'd0, 32'd97};//{'dest': 21, 'label': 97, 'op': 'jmp_and_link'}
    instructions[1197] = {6'd3, 8'd148, 8'd22, 32'd0};//{'dest': 148, 'src': 22, 'op': 'move'}
    instructions[1198] = {6'd0, 8'd149, 8'd0, 32'd12};//{'dest': 149, 'literal': 12, 'op': 'literal'}
    instructions[1199] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1200] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1201] = {6'd11, 8'd150, 8'd149, 32'd61};//{'dest': 150, 'src': 149, 'srcb': 61, 'signed': False, 'op': '+'}
    instructions[1202] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1203] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1204] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1205] = {6'd3, 8'd149, 8'd66, 32'd0};//{'dest': 149, 'src': 66, 'op': 'move'}
    instructions[1206] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1207] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1208] = {6'd27, 8'd148, 8'd149, 32'd64};//{'dest': 148, 'src': 149, 'right': 64, 'signed': False, 'op': '<'}
    instructions[1209] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1210] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1211] = {6'd13, 8'd0, 8'd148, 32'd1217};//{'src': 148, 'label': 1217, 'op': 'jmp_if_false'}
    instructions[1212] = {6'd0, 8'd148, 8'd0, 32'd64};//{'dest': 148, 'literal': 64, 'op': 'literal'}
    instructions[1213] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1214] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1215] = {6'd3, 8'd66, 8'd148, 32'd0};//{'dest': 66, 'src': 148, 'op': 'move'}
    instructions[1216] = {6'd15, 8'd0, 8'd0, 32'd1217};//{'label': 1217, 'op': 'goto'}
    instructions[1217] = {6'd3, 8'd32, 8'd61, 32'd0};//{'dest': 32, 'src': 61, 'op': 'move'}
    instructions[1218] = {6'd3, 8'd33, 8'd66, 32'd0};//{'dest': 33, 'src': 66, 'op': 'move'}
    instructions[1219] = {6'd3, 8'd149, 8'd68, 32'd0};//{'dest': 149, 'src': 68, 'op': 'move'}
    instructions[1220] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1221] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1222] = {6'd11, 8'd150, 8'd149, 32'd48};//{'dest': 150, 'src': 149, 'srcb': 48, 'signed': False, 'op': '+'}
    instructions[1223] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1224] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1225] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18375456, 'op': 'memory_read_request'}
    instructions[1226] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1227] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18375456, 'op': 'memory_read_wait'}
    instructions[1228] = {6'd19, 8'd34, 8'd150, 32'd0};//{'dest': 34, 'src': 150, 'sequence': 18375456, 'element_size': 2, 'op': 'memory_read'}
    instructions[1229] = {6'd3, 8'd149, 8'd68, 32'd0};//{'dest': 149, 'src': 68, 'op': 'move'}
    instructions[1230] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1231] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1232] = {6'd11, 8'd150, 8'd149, 32'd49};//{'dest': 150, 'src': 149, 'srcb': 49, 'signed': False, 'op': '+'}
    instructions[1233] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1234] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1235] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18375600, 'op': 'memory_read_request'}
    instructions[1236] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1237] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18375600, 'op': 'memory_read_wait'}
    instructions[1238] = {6'd19, 8'd35, 8'd150, 32'd0};//{'dest': 35, 'src': 150, 'sequence': 18375600, 'element_size': 2, 'op': 'memory_read'}
    instructions[1239] = {6'd3, 8'd149, 8'd68, 32'd0};//{'dest': 149, 'src': 68, 'op': 'move'}
    instructions[1240] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1241] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1242] = {6'd11, 8'd150, 8'd149, 32'd50};//{'dest': 150, 'src': 149, 'srcb': 50, 'signed': False, 'op': '+'}
    instructions[1243] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1244] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1245] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18375744, 'op': 'memory_read_request'}
    instructions[1246] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1247] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18375744, 'op': 'memory_read_wait'}
    instructions[1248] = {6'd19, 8'd36, 8'd150, 32'd0};//{'dest': 36, 'src': 150, 'sequence': 18375744, 'element_size': 2, 'op': 'memory_read'}
    instructions[1249] = {6'd0, 8'd37, 8'd0, 32'd2048};//{'dest': 37, 'literal': 2048, 'op': 'literal'}
    instructions[1250] = {6'd1, 8'd31, 8'd0, 32'd209};//{'dest': 31, 'label': 209, 'op': 'jmp_and_link'}
    instructions[1251] = {6'd6, 8'd0, 8'd60, 32'd0};//{'src': 60, 'op': 'jmp_to_reg'}
    instructions[1252] = {6'd0, 8'd72, 8'd0, 32'd0};//{'dest': 72, 'literal': 0, 'op': 'literal'}
    instructions[1253] = {6'd0, 8'd73, 8'd0, 32'd0};//{'dest': 73, 'literal': 0, 'op': 'literal'}
    instructions[1254] = {6'd0, 8'd74, 8'd0, 32'd0};//{'dest': 74, 'literal': 0, 'op': 'literal'}
    instructions[1255] = {6'd0, 8'd75, 8'd0, 32'd0};//{'dest': 75, 'literal': 0, 'op': 'literal'}
    instructions[1256] = {6'd0, 8'd76, 8'd0, 32'd0};//{'dest': 76, 'literal': 0, 'op': 'literal'}
    instructions[1257] = {6'd0, 8'd77, 8'd0, 32'd0};//{'dest': 77, 'literal': 0, 'op': 'literal'}
    instructions[1258] = {6'd0, 8'd78, 8'd0, 32'd0};//{'dest': 78, 'literal': 0, 'op': 'literal'}
    instructions[1259] = {6'd0, 8'd79, 8'd0, 32'd0};//{'dest': 79, 'literal': 0, 'op': 'literal'}
    instructions[1260] = {6'd3, 8'd42, 8'd71, 32'd0};//{'dest': 42, 'src': 71, 'op': 'move'}
    instructions[1261] = {6'd1, 8'd40, 8'd0, 32'd313};//{'dest': 40, 'label': 313, 'op': 'jmp_and_link'}
    instructions[1262] = {6'd3, 8'd148, 8'd41, 32'd0};//{'dest': 148, 'src': 41, 'op': 'move'}
    instructions[1263] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1264] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1265] = {6'd3, 8'd66, 8'd148, 32'd0};//{'dest': 66, 'src': 148, 'op': 'move'}
    instructions[1266] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1267] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1268] = {6'd3, 8'd149, 8'd66, 32'd0};//{'dest': 149, 'src': 66, 'op': 'move'}
    instructions[1269] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1270] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1271] = {6'd25, 8'd148, 8'd149, 32'd0};//{'dest': 148, 'src': 149, 'right': 0, 'signed': False, 'op': '=='}
    instructions[1272] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1273] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1274] = {6'd13, 8'd0, 8'd148, 32'd1278};//{'src': 148, 'label': 1278, 'op': 'jmp_if_false'}
    instructions[1275] = {6'd0, 8'd70, 8'd0, 32'd0};//{'dest': 70, 'literal': 0, 'op': 'literal'}
    instructions[1276] = {6'd6, 8'd0, 8'd69, 32'd0};//{'src': 69, 'op': 'jmp_to_reg'}
    instructions[1277] = {6'd15, 8'd0, 8'd0, 32'd1278};//{'label': 1278, 'op': 'goto'}
    instructions[1278] = {6'd0, 8'd150, 8'd0, 32'd6};//{'dest': 150, 'literal': 6, 'op': 'literal'}
    instructions[1279] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1280] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1281] = {6'd11, 8'd151, 8'd150, 32'd71};//{'dest': 151, 'src': 150, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1282] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1283] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1284] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18375816, 'op': 'memory_read_request'}
    instructions[1285] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1286] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18375816, 'op': 'memory_read_wait'}
    instructions[1287] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18375816, 'element_size': 2, 'op': 'memory_read'}
    instructions[1288] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1289] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1290] = {6'd26, 8'd148, 8'd149, 32'd2048};//{'dest': 148, 'src': 149, 'right': 2048, 'signed': False, 'op': '!='}
    instructions[1291] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1292] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1293] = {6'd13, 8'd0, 8'd148, 32'd1297};//{'src': 148, 'label': 1297, 'op': 'jmp_if_false'}
    instructions[1294] = {6'd0, 8'd70, 8'd0, 32'd0};//{'dest': 70, 'literal': 0, 'op': 'literal'}
    instructions[1295] = {6'd6, 8'd0, 8'd69, 32'd0};//{'src': 69, 'op': 'jmp_to_reg'}
    instructions[1296] = {6'd15, 8'd0, 8'd0, 32'd1297};//{'label': 1297, 'op': 'goto'}
    instructions[1297] = {6'd0, 8'd150, 8'd0, 32'd15};//{'dest': 150, 'literal': 15, 'op': 'literal'}
    instructions[1298] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1299] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1300] = {6'd11, 8'd151, 8'd150, 32'd71};//{'dest': 151, 'src': 150, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1301] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1302] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1303] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18376320, 'op': 'memory_read_request'}
    instructions[1304] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1305] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18376320, 'op': 'memory_read_wait'}
    instructions[1306] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18376320, 'element_size': 2, 'op': 'memory_read'}
    instructions[1307] = {6'd3, 8'd150, 8'd13, 32'd0};//{'dest': 150, 'src': 13, 'op': 'move'}
    instructions[1308] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1309] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1310] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[1311] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1312] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1313] = {6'd13, 8'd0, 8'd148, 32'd1317};//{'src': 148, 'label': 1317, 'op': 'jmp_if_false'}
    instructions[1314] = {6'd0, 8'd70, 8'd0, 32'd0};//{'dest': 70, 'literal': 0, 'op': 'literal'}
    instructions[1315] = {6'd6, 8'd0, 8'd69, 32'd0};//{'src': 69, 'op': 'jmp_to_reg'}
    instructions[1316] = {6'd15, 8'd0, 8'd0, 32'd1317};//{'label': 1317, 'op': 'goto'}
    instructions[1317] = {6'd0, 8'd150, 8'd0, 32'd16};//{'dest': 150, 'literal': 16, 'op': 'literal'}
    instructions[1318] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1319] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1320] = {6'd11, 8'd151, 8'd150, 32'd71};//{'dest': 151, 'src': 150, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1321] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1322] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1323] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18376824, 'op': 'memory_read_request'}
    instructions[1324] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1325] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18376824, 'op': 'memory_read_wait'}
    instructions[1326] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18376824, 'element_size': 2, 'op': 'memory_read'}
    instructions[1327] = {6'd3, 8'd150, 8'd14, 32'd0};//{'dest': 150, 'src': 14, 'op': 'move'}
    instructions[1328] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1329] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1330] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[1331] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1332] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1333] = {6'd13, 8'd0, 8'd148, 32'd1337};//{'src': 148, 'label': 1337, 'op': 'jmp_if_false'}
    instructions[1334] = {6'd0, 8'd70, 8'd0, 32'd0};//{'dest': 70, 'literal': 0, 'op': 'literal'}
    instructions[1335] = {6'd6, 8'd0, 8'd69, 32'd0};//{'src': 69, 'op': 'jmp_to_reg'}
    instructions[1336] = {6'd15, 8'd0, 8'd0, 32'd1337};//{'label': 1337, 'op': 'goto'}
    instructions[1337] = {6'd0, 8'd151, 8'd0, 32'd11};//{'dest': 151, 'literal': 11, 'op': 'literal'}
    instructions[1338] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1339] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1340] = {6'd11, 8'd152, 8'd151, 32'd71};//{'dest': 152, 'src': 151, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1341] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1342] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1343] = {6'd17, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 18381568, 'op': 'memory_read_request'}
    instructions[1344] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1345] = {6'd18, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 18381568, 'op': 'memory_read_wait'}
    instructions[1346] = {6'd19, 8'd150, 8'd152, 32'd0};//{'dest': 150, 'src': 152, 'sequence': 18381568, 'element_size': 2, 'op': 'memory_read'}
    instructions[1347] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1348] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1349] = {6'd12, 8'd149, 8'd150, 32'd255};//{'dest': 149, 'src': 150, 'right': 255, 'signed': False, 'op': '&'}
    instructions[1350] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1351] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1352] = {6'd25, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '=='}
    instructions[1353] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1354] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1355] = {6'd13, 8'd0, 8'd148, 32'd1541};//{'src': 148, 'label': 1541, 'op': 'jmp_if_false'}
    instructions[1356] = {6'd0, 8'd152, 8'd0, 32'd7};//{'dest': 152, 'literal': 7, 'op': 'literal'}
    instructions[1357] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1358] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1359] = {6'd11, 8'd153, 8'd152, 32'd71};//{'dest': 153, 'src': 152, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1360] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1361] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1362] = {6'd17, 8'd0, 8'd153, 32'd0};//{'element_size': 2, 'src': 153, 'sequence': 18386456, 'op': 'memory_read_request'}
    instructions[1363] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1364] = {6'd18, 8'd0, 8'd153, 32'd0};//{'element_size': 2, 'src': 153, 'sequence': 18386456, 'op': 'memory_read_wait'}
    instructions[1365] = {6'd19, 8'd151, 8'd153, 32'd0};//{'dest': 151, 'src': 153, 'sequence': 18386456, 'element_size': 2, 'op': 'memory_read'}
    instructions[1366] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1367] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1368] = {6'd31, 8'd150, 8'd151, 32'd8};//{'dest': 150, 'src': 151, 'right': 8, 'signed': False, 'op': '>>'}
    instructions[1369] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1370] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1371] = {6'd12, 8'd149, 8'd150, 32'd15};//{'dest': 149, 'src': 150, 'right': 15, 'signed': False, 'op': '&'}
    instructions[1372] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1373] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1374] = {6'd32, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '<<'}
    instructions[1375] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1376] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1377] = {6'd3, 8'd73, 8'd148, 32'd0};//{'dest': 73, 'src': 148, 'op': 'move'}
    instructions[1378] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1379] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1380] = {6'd3, 8'd149, 8'd73, 32'd0};//{'dest': 149, 'src': 73, 'op': 'move'}
    instructions[1381] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1382] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1383] = {6'd14, 8'd148, 8'd149, 32'd7};//{'dest': 148, 'src': 149, 'right': 7, 'signed': False, 'op': '+'}
    instructions[1384] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1385] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1386] = {6'd3, 8'd74, 8'd148, 32'd0};//{'dest': 74, 'src': 148, 'op': 'move'}
    instructions[1387] = {6'd0, 8'd149, 8'd0, 32'd8};//{'dest': 149, 'literal': 8, 'op': 'literal'}
    instructions[1388] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1389] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1390] = {6'd11, 8'd150, 8'd149, 32'd71};//{'dest': 150, 'src': 149, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1391] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1392] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1393] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18376968, 'op': 'memory_read_request'}
    instructions[1394] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1395] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18376968, 'op': 'memory_read_wait'}
    instructions[1396] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18376968, 'element_size': 2, 'op': 'memory_read'}
    instructions[1397] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1398] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1399] = {6'd3, 8'd72, 8'd148, 32'd0};//{'dest': 72, 'src': 148, 'op': 'move'}
    instructions[1400] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1401] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1402] = {6'd3, 8'd151, 8'd72, 32'd0};//{'dest': 151, 'src': 72, 'op': 'move'}
    instructions[1403] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1404] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1405] = {6'd14, 8'd150, 8'd151, 32'd1};//{'dest': 150, 'src': 151, 'right': 1, 'signed': False, 'op': '+'}
    instructions[1406] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1407] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1408] = {6'd31, 8'd149, 8'd150, 32'd1};//{'dest': 149, 'src': 150, 'right': 1, 'signed': False, 'op': '>>'}
    instructions[1409] = {6'd3, 8'd150, 8'd73, 32'd0};//{'dest': 150, 'src': 73, 'op': 'move'}
    instructions[1410] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1411] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1412] = {6'd33, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '-'}
    instructions[1413] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1414] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1415] = {6'd3, 8'd75, 8'd148, 32'd0};//{'dest': 75, 'src': 148, 'op': 'move'}
    instructions[1416] = {6'd3, 8'd150, 8'd74, 32'd0};//{'dest': 150, 'src': 74, 'op': 'move'}
    instructions[1417] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1418] = {6'd3, 8'd151, 8'd75, 32'd0};//{'dest': 151, 'src': 75, 'op': 'move'}
    instructions[1419] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1420] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1421] = {6'd11, 8'd149, 8'd150, 32'd151};//{'dest': 149, 'src': 150, 'srcb': 151, 'signed': False, 'op': '+'}
    instructions[1422] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1423] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1424] = {6'd34, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '-'}
    instructions[1425] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1426] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1427] = {6'd3, 8'd79, 8'd148, 32'd0};//{'dest': 79, 'src': 148, 'op': 'move'}
    instructions[1428] = {6'd3, 8'd150, 8'd74, 32'd0};//{'dest': 150, 'src': 74, 'op': 'move'}
    instructions[1429] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1430] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1431] = {6'd11, 8'd151, 8'd150, 32'd71};//{'dest': 151, 'src': 150, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1432] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1433] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1434] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18374736, 'op': 'memory_read_request'}
    instructions[1435] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1436] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 18374736, 'op': 'memory_read_wait'}
    instructions[1437] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 18374736, 'element_size': 2, 'op': 'memory_read'}
    instructions[1438] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1439] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1440] = {6'd25, 8'd148, 8'd149, 32'd2048};//{'dest': 148, 'src': 149, 'right': 2048, 'signed': False, 'op': '=='}
    instructions[1441] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1442] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1443] = {6'd13, 8'd0, 8'd148, 32'd1538};//{'src': 148, 'label': 1538, 'op': 'jmp_if_false'}
    instructions[1444] = {6'd0, 8'd148, 8'd0, 32'd19};//{'dest': 148, 'literal': 19, 'op': 'literal'}
    instructions[1445] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1446] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1447] = {6'd3, 8'd78, 8'd148, 32'd0};//{'dest': 78, 'src': 148, 'op': 'move'}
    instructions[1448] = {6'd1, 8'd18, 8'd0, 32'd56};//{'dest': 18, 'label': 56, 'op': 'jmp_and_link'}
    instructions[1449] = {6'd3, 8'd149, 8'd74, 32'd0};//{'dest': 149, 'src': 74, 'op': 'move'}
    instructions[1450] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1451] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1452] = {6'd14, 8'd148, 8'd149, 32'd2};//{'dest': 148, 'src': 149, 'right': 2, 'signed': False, 'op': '+'}
    instructions[1453] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1454] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1455] = {6'd3, 8'd77, 8'd148, 32'd0};//{'dest': 77, 'src': 148, 'op': 'move'}
    instructions[1456] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1457] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1458] = {6'd3, 8'd149, 8'd77, 32'd0};//{'dest': 149, 'src': 77, 'op': 'move'}
    instructions[1459] = {6'd3, 8'd150, 8'd79, 32'd0};//{'dest': 150, 'src': 79, 'op': 'move'}
    instructions[1460] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1461] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1462] = {6'd35, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '<='}
    instructions[1463] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1464] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1465] = {6'd13, 8'd0, 8'd148, 32'd1496};//{'src': 148, 'label': 1496, 'op': 'jmp_if_false'}
    instructions[1466] = {6'd3, 8'd149, 8'd77, 32'd0};//{'dest': 149, 'src': 77, 'op': 'move'}
    instructions[1467] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1468] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1469] = {6'd11, 8'd150, 8'd149, 32'd71};//{'dest': 150, 'src': 149, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1470] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1471] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1472] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18370432, 'op': 'memory_read_request'}
    instructions[1473] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1474] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18370432, 'op': 'memory_read_wait'}
    instructions[1475] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 18370432, 'element_size': 2, 'op': 'memory_read'}
    instructions[1476] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1477] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1478] = {6'd3, 8'd76, 8'd148, 32'd0};//{'dest': 76, 'src': 148, 'op': 'move'}
    instructions[1479] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1480] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1481] = {6'd3, 8'd20, 8'd76, 32'd0};//{'dest': 20, 'src': 76, 'op': 'move'}
    instructions[1482] = {6'd1, 8'd19, 8'd0, 32'd61};//{'dest': 19, 'label': 61, 'op': 'jmp_and_link'}
    instructions[1483] = {6'd3, 8'd148, 8'd76, 32'd0};//{'dest': 148, 'src': 76, 'op': 'move'}
    instructions[1484] = {6'd3, 8'd149, 8'd78, 32'd0};//{'dest': 149, 'src': 78, 'op': 'move'}
    instructions[1485] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1486] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1487] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[1488] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1489] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1490] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1491] = {6'd3, 8'd148, 8'd78, 32'd0};//{'dest': 148, 'src': 78, 'op': 'move'}
    instructions[1492] = {6'd14, 8'd78, 8'd78, 32'd1};//{'dest': 78, 'src': 78, 'right': 1, 'signed': False, 'op': '+'}
    instructions[1493] = {6'd3, 8'd148, 8'd77, 32'd0};//{'dest': 148, 'src': 77, 'op': 'move'}
    instructions[1494] = {6'd14, 8'd77, 8'd77, 32'd1};//{'dest': 77, 'src': 77, 'right': 1, 'signed': False, 'op': '+'}
    instructions[1495] = {6'd15, 8'd0, 8'd0, 32'd1456};//{'label': 1456, 'op': 'goto'}
    instructions[1496] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[1497] = {6'd0, 8'd149, 8'd0, 32'd17};//{'dest': 149, 'literal': 17, 'op': 'literal'}
    instructions[1498] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1499] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1500] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[1501] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1502] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1503] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1504] = {6'd1, 8'd21, 8'd0, 32'd97};//{'dest': 21, 'label': 97, 'op': 'jmp_and_link'}
    instructions[1505] = {6'd3, 8'd148, 8'd22, 32'd0};//{'dest': 148, 'src': 22, 'op': 'move'}
    instructions[1506] = {6'd0, 8'd149, 8'd0, 32'd18};//{'dest': 149, 'literal': 18, 'op': 'literal'}
    instructions[1507] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1508] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1509] = {6'd11, 8'd150, 8'd149, 32'd16};//{'dest': 150, 'src': 149, 'srcb': 16, 'signed': False, 'op': '+'}
    instructions[1510] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1511] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1512] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1513] = {6'd3, 8'd61, 8'd16, 32'd0};//{'dest': 61, 'src': 16, 'op': 'move'}
    instructions[1514] = {6'd3, 8'd62, 8'd72, 32'd0};//{'dest': 62, 'src': 72, 'op': 'move'}
    instructions[1515] = {6'd0, 8'd63, 8'd0, 32'd1};//{'dest': 63, 'literal': 1, 'op': 'literal'}
    instructions[1516] = {6'd0, 8'd149, 8'd0, 32'd13};//{'dest': 149, 'literal': 13, 'op': 'literal'}
    instructions[1517] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1518] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1519] = {6'd11, 8'd150, 8'd149, 32'd71};//{'dest': 150, 'src': 149, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1520] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1521] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1522] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18389688, 'op': 'memory_read_request'}
    instructions[1523] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1524] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18389688, 'op': 'memory_read_wait'}
    instructions[1525] = {6'd19, 8'd64, 8'd150, 32'd0};//{'dest': 64, 'src': 150, 'sequence': 18389688, 'element_size': 2, 'op': 'memory_read'}
    instructions[1526] = {6'd0, 8'd149, 8'd0, 32'd14};//{'dest': 149, 'literal': 14, 'op': 'literal'}
    instructions[1527] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1528] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1529] = {6'd11, 8'd150, 8'd149, 32'd71};//{'dest': 150, 'src': 149, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1530] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1531] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1532] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18389832, 'op': 'memory_read_request'}
    instructions[1533] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1534] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 18389832, 'op': 'memory_read_wait'}
    instructions[1535] = {6'd19, 8'd65, 8'd150, 32'd0};//{'dest': 65, 'src': 150, 'sequence': 18389832, 'element_size': 2, 'op': 'memory_read'}
    instructions[1536] = {6'd1, 8'd60, 8'd0, 32'd1068};//{'dest': 60, 'label': 1068, 'op': 'jmp_and_link'}
    instructions[1537] = {6'd15, 8'd0, 8'd0, 32'd1538};//{'label': 1538, 'op': 'goto'}
    instructions[1538] = {6'd0, 8'd70, 8'd0, 32'd0};//{'dest': 70, 'literal': 0, 'op': 'literal'}
    instructions[1539] = {6'd6, 8'd0, 8'd69, 32'd0};//{'src': 69, 'op': 'jmp_to_reg'}
    instructions[1540] = {6'd15, 8'd0, 8'd0, 32'd1541};//{'label': 1541, 'op': 'goto'}
    instructions[1541] = {6'd0, 8'd151, 8'd0, 32'd11};//{'dest': 151, 'literal': 11, 'op': 'literal'}
    instructions[1542] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1543] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1544] = {6'd11, 8'd152, 8'd151, 32'd71};//{'dest': 152, 'src': 151, 'srcb': 71, 'signed': False, 'op': '+'}
    instructions[1545] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1546] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1547] = {6'd17, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 18390264, 'op': 'memory_read_request'}
    instructions[1548] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1549] = {6'd18, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 18390264, 'op': 'memory_read_wait'}
    instructions[1550] = {6'd19, 8'd150, 8'd152, 32'd0};//{'dest': 150, 'src': 152, 'sequence': 18390264, 'element_size': 2, 'op': 'memory_read'}
    instructions[1551] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1552] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1553] = {6'd12, 8'd149, 8'd150, 32'd255};//{'dest': 149, 'src': 150, 'right': 255, 'signed': False, 'op': '&'}
    instructions[1554] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1555] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1556] = {6'd26, 8'd148, 8'd149, 32'd6};//{'dest': 148, 'src': 149, 'right': 6, 'signed': False, 'op': '!='}
    instructions[1557] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1558] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1559] = {6'd13, 8'd0, 8'd148, 32'd1563};//{'src': 148, 'label': 1563, 'op': 'jmp_if_false'}
    instructions[1560] = {6'd0, 8'd70, 8'd0, 32'd0};//{'dest': 70, 'literal': 0, 'op': 'literal'}
    instructions[1561] = {6'd6, 8'd0, 8'd69, 32'd0};//{'src': 69, 'op': 'jmp_to_reg'}
    instructions[1562] = {6'd15, 8'd0, 8'd0, 32'd1563};//{'label': 1563, 'op': 'goto'}
    instructions[1563] = {6'd3, 8'd70, 8'd66, 32'd0};//{'dest': 70, 'src': 66, 'op': 'move'}
    instructions[1564] = {6'd6, 8'd0, 8'd69, 32'd0};//{'src': 69, 'op': 'jmp_to_reg'}
    instructions[1565] = {6'd0, 8'd105, 8'd0, 32'd17};//{'dest': 105, 'literal': 17, 'op': 'literal'}
    instructions[1566] = {6'd0, 8'd106, 8'd0, 32'd0};//{'dest': 106, 'literal': 0, 'op': 'literal'}
    instructions[1567] = {6'd0, 8'd107, 8'd0, 32'd0};//{'dest': 107, 'literal': 0, 'op': 'literal'}
    instructions[1568] = {6'd3, 8'd148, 8'd82, 32'd0};//{'dest': 148, 'src': 82, 'op': 'move'}
    instructions[1569] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1570] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1571] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1572] = {6'd14, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'right': 0, 'signed': False, 'op': '+'}
    instructions[1573] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1574] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1575] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1576] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1577] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1578] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1579] = {6'd3, 8'd148, 8'd83, 32'd0};//{'dest': 148, 'src': 83, 'op': 'move'}
    instructions[1580] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1581] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1582] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1583] = {6'd14, 8'd149, 8'd151, 32'd1};//{'dest': 149, 'src': 151, 'right': 1, 'signed': False, 'op': '+'}
    instructions[1584] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1585] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1586] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1587] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1588] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1589] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1590] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[1591] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1592] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1593] = {6'd11, 8'd150, 8'd149, 32'd84};//{'dest': 150, 'src': 149, 'srcb': 84, 'signed': False, 'op': '+'}
    instructions[1594] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1595] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1596] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17769680, 'op': 'memory_read_request'}
    instructions[1597] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1598] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17769680, 'op': 'memory_read_wait'}
    instructions[1599] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17769680, 'element_size': 2, 'op': 'memory_read'}
    instructions[1600] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1601] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1602] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1603] = {6'd14, 8'd149, 8'd151, 32'd2};//{'dest': 149, 'src': 151, 'right': 2, 'signed': False, 'op': '+'}
    instructions[1604] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1605] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1606] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1607] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1608] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1609] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1610] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[1611] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1612] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1613] = {6'd11, 8'd150, 8'd149, 32'd84};//{'dest': 150, 'src': 149, 'srcb': 84, 'signed': False, 'op': '+'}
    instructions[1614] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1615] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1616] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17770256, 'op': 'memory_read_request'}
    instructions[1617] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1618] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17770256, 'op': 'memory_read_wait'}
    instructions[1619] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17770256, 'element_size': 2, 'op': 'memory_read'}
    instructions[1620] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1621] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1622] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1623] = {6'd14, 8'd149, 8'd151, 32'd3};//{'dest': 149, 'src': 151, 'right': 3, 'signed': False, 'op': '+'}
    instructions[1624] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1625] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1626] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1627] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1628] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1629] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1630] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[1631] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1632] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1633] = {6'd11, 8'd150, 8'd149, 32'd86};//{'dest': 150, 'src': 149, 'srcb': 86, 'signed': False, 'op': '+'}
    instructions[1634] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1635] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1636] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17770832, 'op': 'memory_read_request'}
    instructions[1637] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1638] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17770832, 'op': 'memory_read_wait'}
    instructions[1639] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17770832, 'element_size': 2, 'op': 'memory_read'}
    instructions[1640] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1641] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1642] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1643] = {6'd14, 8'd149, 8'd151, 32'd4};//{'dest': 149, 'src': 151, 'right': 4, 'signed': False, 'op': '+'}
    instructions[1644] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1645] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1646] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1647] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1648] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1649] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1650] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[1651] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1652] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1653] = {6'd11, 8'd150, 8'd149, 32'd86};//{'dest': 150, 'src': 149, 'srcb': 86, 'signed': False, 'op': '+'}
    instructions[1654] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1655] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1656] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17771408, 'op': 'memory_read_request'}
    instructions[1657] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1658] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17771408, 'op': 'memory_read_wait'}
    instructions[1659] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17771408, 'element_size': 2, 'op': 'memory_read'}
    instructions[1660] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1661] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1662] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1663] = {6'd14, 8'd149, 8'd151, 32'd5};//{'dest': 149, 'src': 151, 'right': 5, 'signed': False, 'op': '+'}
    instructions[1664] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1665] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1666] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1667] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1668] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1669] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1670] = {6'd0, 8'd148, 8'd0, 32'd20480};//{'dest': 148, 'literal': 20480, 'op': 'literal'}
    instructions[1671] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1672] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1673] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1674] = {6'd14, 8'd149, 8'd151, 32'd6};//{'dest': 149, 'src': 151, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1675] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1676] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1677] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1678] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1679] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1680] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1681] = {6'd3, 8'd148, 8'd87, 32'd0};//{'dest': 148, 'src': 87, 'op': 'move'}
    instructions[1682] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1683] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1684] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1685] = {6'd14, 8'd149, 8'd151, 32'd7};//{'dest': 149, 'src': 151, 'right': 7, 'signed': False, 'op': '+'}
    instructions[1686] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1687] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1688] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1689] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1690] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1691] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1692] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[1693] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1694] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1695] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1696] = {6'd14, 8'd149, 8'd151, 32'd8};//{'dest': 149, 'src': 151, 'right': 8, 'signed': False, 'op': '+'}
    instructions[1697] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1698] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1699] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1700] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1701] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1702] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1703] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[1704] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1705] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1706] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1707] = {6'd14, 8'd149, 8'd151, 32'd9};//{'dest': 149, 'src': 151, 'right': 9, 'signed': False, 'op': '+'}
    instructions[1708] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1709] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1710] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1711] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1712] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1713] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1714] = {6'd3, 8'd148, 8'd88, 32'd0};//{'dest': 148, 'src': 88, 'op': 'move'}
    instructions[1715] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1716] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1717] = {6'd13, 8'd0, 8'd148, 32'd1745};//{'src': 148, 'label': 1745, 'op': 'jmp_if_false'}
    instructions[1718] = {6'd3, 8'd152, 8'd105, 32'd0};//{'dest': 152, 'src': 105, 'op': 'move'}
    instructions[1719] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1720] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1721] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1722] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1723] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1724] = {6'd11, 8'd151, 8'd150, 32'd103};//{'dest': 151, 'src': 150, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1725] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1726] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1727] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17778376, 'op': 'memory_read_request'}
    instructions[1728] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1729] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17778376, 'op': 'memory_read_wait'}
    instructions[1730] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17778376, 'element_size': 2, 'op': 'memory_read'}
    instructions[1731] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1732] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1733] = {6'd36, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '|'}
    instructions[1734] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1735] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1736] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1737] = {6'd14, 8'd149, 8'd151, 32'd6};//{'dest': 149, 'src': 151, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1738] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1739] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1740] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1741] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1742] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1743] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1744] = {6'd15, 8'd0, 8'd0, 32'd1745};//{'label': 1745, 'op': 'goto'}
    instructions[1745] = {6'd3, 8'd148, 8'd89, 32'd0};//{'dest': 148, 'src': 89, 'op': 'move'}
    instructions[1746] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1747] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1748] = {6'd13, 8'd0, 8'd148, 32'd1776};//{'src': 148, 'label': 1776, 'op': 'jmp_if_false'}
    instructions[1749] = {6'd3, 8'd152, 8'd105, 32'd0};//{'dest': 152, 'src': 105, 'op': 'move'}
    instructions[1750] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1751] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1752] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1753] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1754] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1755] = {6'd11, 8'd151, 8'd150, 32'd103};//{'dest': 151, 'src': 150, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1756] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1757] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1758] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17779096, 'op': 'memory_read_request'}
    instructions[1759] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1760] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17779096, 'op': 'memory_read_wait'}
    instructions[1761] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17779096, 'element_size': 2, 'op': 'memory_read'}
    instructions[1762] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1763] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1764] = {6'd36, 8'd148, 8'd149, 32'd2};//{'dest': 148, 'src': 149, 'right': 2, 'signed': False, 'op': '|'}
    instructions[1765] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1766] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1767] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1768] = {6'd14, 8'd149, 8'd151, 32'd6};//{'dest': 149, 'src': 151, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1769] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1770] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1771] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1772] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1773] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1774] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1775] = {6'd15, 8'd0, 8'd0, 32'd1776};//{'label': 1776, 'op': 'goto'}
    instructions[1776] = {6'd3, 8'd148, 8'd90, 32'd0};//{'dest': 148, 'src': 90, 'op': 'move'}
    instructions[1777] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1778] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1779] = {6'd13, 8'd0, 8'd148, 32'd1807};//{'src': 148, 'label': 1807, 'op': 'jmp_if_false'}
    instructions[1780] = {6'd3, 8'd152, 8'd105, 32'd0};//{'dest': 152, 'src': 105, 'op': 'move'}
    instructions[1781] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1782] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1783] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1784] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1785] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1786] = {6'd11, 8'd151, 8'd150, 32'd103};//{'dest': 151, 'src': 150, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1787] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1788] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1789] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17779816, 'op': 'memory_read_request'}
    instructions[1790] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1791] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17779816, 'op': 'memory_read_wait'}
    instructions[1792] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17779816, 'element_size': 2, 'op': 'memory_read'}
    instructions[1793] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1794] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1795] = {6'd36, 8'd148, 8'd149, 32'd4};//{'dest': 148, 'src': 149, 'right': 4, 'signed': False, 'op': '|'}
    instructions[1796] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1797] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1798] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1799] = {6'd14, 8'd149, 8'd151, 32'd6};//{'dest': 149, 'src': 151, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1800] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1801] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1802] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1803] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1804] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1805] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1806] = {6'd15, 8'd0, 8'd0, 32'd1807};//{'label': 1807, 'op': 'goto'}
    instructions[1807] = {6'd3, 8'd148, 8'd91, 32'd0};//{'dest': 148, 'src': 91, 'op': 'move'}
    instructions[1808] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1809] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1810] = {6'd13, 8'd0, 8'd148, 32'd1838};//{'src': 148, 'label': 1838, 'op': 'jmp_if_false'}
    instructions[1811] = {6'd3, 8'd152, 8'd105, 32'd0};//{'dest': 152, 'src': 105, 'op': 'move'}
    instructions[1812] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1813] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1814] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1815] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1816] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1817] = {6'd11, 8'd151, 8'd150, 32'd103};//{'dest': 151, 'src': 150, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1818] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1819] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1820] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17780536, 'op': 'memory_read_request'}
    instructions[1821] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1822] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17780536, 'op': 'memory_read_wait'}
    instructions[1823] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17780536, 'element_size': 2, 'op': 'memory_read'}
    instructions[1824] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1825] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1826] = {6'd36, 8'd148, 8'd149, 32'd8};//{'dest': 148, 'src': 149, 'right': 8, 'signed': False, 'op': '|'}
    instructions[1827] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1828] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1829] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1830] = {6'd14, 8'd149, 8'd151, 32'd6};//{'dest': 149, 'src': 151, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1831] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1832] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1833] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1834] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1835] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1836] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1837] = {6'd15, 8'd0, 8'd0, 32'd1838};//{'label': 1838, 'op': 'goto'}
    instructions[1838] = {6'd3, 8'd148, 8'd92, 32'd0};//{'dest': 148, 'src': 92, 'op': 'move'}
    instructions[1839] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1840] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1841] = {6'd13, 8'd0, 8'd148, 32'd1869};//{'src': 148, 'label': 1869, 'op': 'jmp_if_false'}
    instructions[1842] = {6'd3, 8'd152, 8'd105, 32'd0};//{'dest': 152, 'src': 105, 'op': 'move'}
    instructions[1843] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1844] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1845] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1846] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1847] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1848] = {6'd11, 8'd151, 8'd150, 32'd103};//{'dest': 151, 'src': 150, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1849] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1850] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1851] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17789512, 'op': 'memory_read_request'}
    instructions[1852] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1853] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17789512, 'op': 'memory_read_wait'}
    instructions[1854] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17789512, 'element_size': 2, 'op': 'memory_read'}
    instructions[1855] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1856] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1857] = {6'd36, 8'd148, 8'd149, 32'd16};//{'dest': 148, 'src': 149, 'right': 16, 'signed': False, 'op': '|'}
    instructions[1858] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1859] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1860] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1861] = {6'd14, 8'd149, 8'd151, 32'd6};//{'dest': 149, 'src': 151, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1862] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1863] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1864] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1865] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1866] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1867] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1868] = {6'd15, 8'd0, 8'd0, 32'd1869};//{'label': 1869, 'op': 'goto'}
    instructions[1869] = {6'd3, 8'd148, 8'd93, 32'd0};//{'dest': 148, 'src': 93, 'op': 'move'}
    instructions[1870] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1871] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1872] = {6'd13, 8'd0, 8'd148, 32'd1900};//{'src': 148, 'label': 1900, 'op': 'jmp_if_false'}
    instructions[1873] = {6'd3, 8'd152, 8'd105, 32'd0};//{'dest': 152, 'src': 105, 'op': 'move'}
    instructions[1874] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1875] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1876] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1877] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1878] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1879] = {6'd11, 8'd151, 8'd150, 32'd103};//{'dest': 151, 'src': 150, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1880] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1881] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1882] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17790232, 'op': 'memory_read_request'}
    instructions[1883] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1884] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17790232, 'op': 'memory_read_wait'}
    instructions[1885] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17790232, 'element_size': 2, 'op': 'memory_read'}
    instructions[1886] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1887] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1888] = {6'd36, 8'd148, 8'd149, 32'd32};//{'dest': 148, 'src': 149, 'right': 32, 'signed': False, 'op': '|'}
    instructions[1889] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1890] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1891] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1892] = {6'd14, 8'd149, 8'd151, 32'd6};//{'dest': 149, 'src': 151, 'right': 6, 'signed': False, 'op': '+'}
    instructions[1893] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1894] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1895] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1896] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1897] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1898] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1899] = {6'd15, 8'd0, 8'd0, 32'd1900};//{'label': 1900, 'op': 'goto'}
    instructions[1900] = {6'd1, 8'd18, 8'd0, 32'd56};//{'dest': 18, 'label': 56, 'op': 'jmp_and_link'}
    instructions[1901] = {6'd3, 8'd20, 8'd13, 32'd0};//{'dest': 20, 'src': 13, 'op': 'move'}
    instructions[1902] = {6'd1, 8'd19, 8'd0, 32'd61};//{'dest': 19, 'label': 61, 'op': 'jmp_and_link'}
    instructions[1903] = {6'd3, 8'd20, 8'd14, 32'd0};//{'dest': 20, 'src': 14, 'op': 'move'}
    instructions[1904] = {6'd1, 8'd19, 8'd0, 32'd61};//{'dest': 19, 'label': 61, 'op': 'jmp_and_link'}
    instructions[1905] = {6'd3, 8'd20, 8'd80, 32'd0};//{'dest': 20, 'src': 80, 'op': 'move'}
    instructions[1906] = {6'd1, 8'd19, 8'd0, 32'd61};//{'dest': 19, 'label': 61, 'op': 'jmp_and_link'}
    instructions[1907] = {6'd3, 8'd20, 8'd81, 32'd0};//{'dest': 20, 'src': 81, 'op': 'move'}
    instructions[1908] = {6'd1, 8'd19, 8'd0, 32'd61};//{'dest': 19, 'label': 61, 'op': 'jmp_and_link'}
    instructions[1909] = {6'd0, 8'd20, 8'd0, 32'd6};//{'dest': 20, 'literal': 6, 'op': 'literal'}
    instructions[1910] = {6'd1, 8'd19, 8'd0, 32'd61};//{'dest': 19, 'label': 61, 'op': 'jmp_and_link'}
    instructions[1911] = {6'd3, 8'd149, 8'd104, 32'd0};//{'dest': 149, 'src': 104, 'op': 'move'}
    instructions[1912] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1913] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1914] = {6'd14, 8'd20, 8'd149, 32'd20};//{'dest': 20, 'src': 149, 'right': 20, 'signed': False, 'op': '+'}
    instructions[1915] = {6'd1, 8'd19, 8'd0, 32'd61};//{'dest': 19, 'label': 61, 'op': 'jmp_and_link'}
    instructions[1916] = {6'd3, 8'd151, 8'd104, 32'd0};//{'dest': 151, 'src': 104, 'op': 'move'}
    instructions[1917] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1918] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1919] = {6'd14, 8'd150, 8'd151, 32'd20};//{'dest': 150, 'src': 151, 'right': 20, 'signed': False, 'op': '+'}
    instructions[1920] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1921] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1922] = {6'd14, 8'd149, 8'd150, 32'd1};//{'dest': 149, 'src': 150, 'right': 1, 'signed': False, 'op': '+'}
    instructions[1923] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1924] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1925] = {6'd31, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '>>'}
    instructions[1926] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1927] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1928] = {6'd3, 8'd106, 8'd148, 32'd0};//{'dest': 106, 'src': 148, 'op': 'move'}
    instructions[1929] = {6'd3, 8'd148, 8'd105, 32'd0};//{'dest': 148, 'src': 105, 'op': 'move'}
    instructions[1930] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1931] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1932] = {6'd3, 8'd107, 8'd148, 32'd0};//{'dest': 107, 'src': 148, 'op': 'move'}
    instructions[1933] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[1934] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1935] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1936] = {6'd3, 8'd76, 8'd148, 32'd0};//{'dest': 76, 'src': 148, 'op': 'move'}
    instructions[1937] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1938] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1939] = {6'd3, 8'd149, 8'd76, 32'd0};//{'dest': 149, 'src': 76, 'op': 'move'}
    instructions[1940] = {6'd3, 8'd150, 8'd106, 32'd0};//{'dest': 150, 'src': 106, 'op': 'move'}
    instructions[1941] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1942] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1943] = {6'd20, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '<'}
    instructions[1944] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1945] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1946] = {6'd13, 8'd0, 8'd148, 32'd1963};//{'src': 148, 'label': 1963, 'op': 'jmp_if_false'}
    instructions[1947] = {6'd3, 8'd149, 8'd107, 32'd0};//{'dest': 149, 'src': 107, 'op': 'move'}
    instructions[1948] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1949] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1950] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1951] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1952] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1953] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17802664, 'op': 'memory_read_request'}
    instructions[1954] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1955] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17802664, 'op': 'memory_read_wait'}
    instructions[1956] = {6'd19, 8'd20, 8'd150, 32'd0};//{'dest': 20, 'src': 150, 'sequence': 17802664, 'element_size': 2, 'op': 'memory_read'}
    instructions[1957] = {6'd1, 8'd19, 8'd0, 32'd61};//{'dest': 19, 'label': 61, 'op': 'jmp_and_link'}
    instructions[1958] = {6'd3, 8'd148, 8'd107, 32'd0};//{'dest': 148, 'src': 107, 'op': 'move'}
    instructions[1959] = {6'd14, 8'd107, 8'd107, 32'd1};//{'dest': 107, 'src': 107, 'right': 1, 'signed': False, 'op': '+'}
    instructions[1960] = {6'd3, 8'd148, 8'd76, 32'd0};//{'dest': 148, 'src': 76, 'op': 'move'}
    instructions[1961] = {6'd14, 8'd76, 8'd76, 32'd1};//{'dest': 76, 'src': 76, 'right': 1, 'signed': False, 'op': '+'}
    instructions[1962] = {6'd15, 8'd0, 8'd0, 32'd1937};//{'label': 1937, 'op': 'goto'}
    instructions[1963] = {6'd1, 8'd21, 8'd0, 32'd97};//{'dest': 21, 'label': 97, 'op': 'jmp_and_link'}
    instructions[1964] = {6'd3, 8'd148, 8'd22, 32'd0};//{'dest': 148, 'src': 22, 'op': 'move'}
    instructions[1965] = {6'd3, 8'd151, 8'd105, 32'd0};//{'dest': 151, 'src': 105, 'op': 'move'}
    instructions[1966] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1967] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1968] = {6'd14, 8'd149, 8'd151, 32'd8};//{'dest': 149, 'src': 151, 'right': 8, 'signed': False, 'op': '+'}
    instructions[1969] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1970] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1971] = {6'd11, 8'd150, 8'd149, 32'd103};//{'dest': 150, 'src': 149, 'srcb': 103, 'signed': False, 'op': '+'}
    instructions[1972] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1973] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1974] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[1975] = {6'd3, 8'd61, 8'd103, 32'd0};//{'dest': 61, 'src': 103, 'op': 'move'}
    instructions[1976] = {6'd3, 8'd149, 8'd104, 32'd0};//{'dest': 149, 'src': 104, 'op': 'move'}
    instructions[1977] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1978] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1979] = {6'd14, 8'd62, 8'd149, 32'd40};//{'dest': 62, 'src': 149, 'right': 40, 'signed': False, 'op': '+'}
    instructions[1980] = {6'd0, 8'd63, 8'd0, 32'd6};//{'dest': 63, 'literal': 6, 'op': 'literal'}
    instructions[1981] = {6'd3, 8'd64, 8'd80, 32'd0};//{'dest': 64, 'src': 80, 'op': 'move'}
    instructions[1982] = {6'd3, 8'd65, 8'd81, 32'd0};//{'dest': 65, 'src': 81, 'op': 'move'}
    instructions[1983] = {6'd1, 8'd60, 8'd0, 32'd1068};//{'dest': 60, 'label': 1068, 'op': 'jmp_and_link'}
    instructions[1984] = {6'd6, 8'd0, 8'd102, 32'd0};//{'src': 102, 'op': 'jmp_to_reg'}
    instructions[1985] = {6'd0, 8'd113, 8'd0, 32'd0};//{'dest': 113, 'literal': 0, 'op': 'literal'}
    instructions[1986] = {6'd0, 8'd114, 8'd0, 32'd0};//{'dest': 114, 'literal': 0, 'op': 'literal'}
    instructions[1987] = {6'd0, 8'd115, 8'd0, 32'd0};//{'dest': 115, 'literal': 0, 'op': 'literal'}
    instructions[1988] = {6'd0, 8'd116, 8'd0, 32'd0};//{'dest': 116, 'literal': 0, 'op': 'literal'}
    instructions[1989] = {6'd0, 8'd117, 8'd0, 32'd0};//{'dest': 117, 'literal': 0, 'op': 'literal'}
    instructions[1990] = {6'd0, 8'd118, 8'd0, 32'd0};//{'dest': 118, 'literal': 0, 'op': 'literal'}
    instructions[1991] = {6'd3, 8'd71, 8'd112, 32'd0};//{'dest': 71, 'src': 112, 'op': 'move'}
    instructions[1992] = {6'd1, 8'd69, 8'd0, 32'd1252};//{'dest': 69, 'label': 1252, 'op': 'jmp_and_link'}
    instructions[1993] = {6'd3, 8'd148, 8'd70, 32'd0};//{'dest': 148, 'src': 70, 'op': 'move'}
    instructions[1994] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1995] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1996] = {6'd3, 8'd113, 8'd148, 32'd0};//{'dest': 113, 'src': 148, 'op': 'move'}
    instructions[1997] = {6'd0, 8'd152, 8'd0, 32'd7};//{'dest': 152, 'literal': 7, 'op': 'literal'}
    instructions[1998] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[1999] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2000] = {6'd11, 8'd153, 8'd152, 32'd112};//{'dest': 153, 'src': 152, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2001] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2002] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2003] = {6'd17, 8'd0, 8'd153, 32'd0};//{'element_size': 2, 'src': 153, 'sequence': 17782832, 'op': 'memory_read_request'}
    instructions[2004] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2005] = {6'd18, 8'd0, 8'd153, 32'd0};//{'element_size': 2, 'src': 153, 'sequence': 17782832, 'op': 'memory_read_wait'}
    instructions[2006] = {6'd19, 8'd151, 8'd153, 32'd0};//{'dest': 151, 'src': 153, 'sequence': 17782832, 'element_size': 2, 'op': 'memory_read'}
    instructions[2007] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2008] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2009] = {6'd31, 8'd150, 8'd151, 32'd8};//{'dest': 150, 'src': 151, 'right': 8, 'signed': False, 'op': '>>'}
    instructions[2010] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2011] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2012] = {6'd12, 8'd149, 8'd150, 32'd15};//{'dest': 149, 'src': 150, 'right': 15, 'signed': False, 'op': '&'}
    instructions[2013] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2014] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2015] = {6'd32, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '<<'}
    instructions[2016] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2017] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2018] = {6'd3, 8'd114, 8'd148, 32'd0};//{'dest': 114, 'src': 148, 'op': 'move'}
    instructions[2019] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2020] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2021] = {6'd3, 8'd149, 8'd114, 32'd0};//{'dest': 149, 'src': 114, 'op': 'move'}
    instructions[2022] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2023] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2024] = {6'd14, 8'd148, 8'd149, 32'd7};//{'dest': 148, 'src': 149, 'right': 7, 'signed': False, 'op': '+'}
    instructions[2025] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2026] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2027] = {6'd3, 8'd115, 8'd148, 32'd0};//{'dest': 115, 'src': 148, 'op': 'move'}
    instructions[2028] = {6'd0, 8'd149, 8'd0, 32'd8};//{'dest': 149, 'literal': 8, 'op': 'literal'}
    instructions[2029] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2030] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2031] = {6'd11, 8'd150, 8'd149, 32'd112};//{'dest': 150, 'src': 149, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2032] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2033] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2034] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17774856, 'op': 'memory_read_request'}
    instructions[2035] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2036] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17774856, 'op': 'memory_read_wait'}
    instructions[2037] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17774856, 'element_size': 2, 'op': 'memory_read'}
    instructions[2038] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2039] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2040] = {6'd3, 8'd116, 8'd148, 32'd0};//{'dest': 116, 'src': 148, 'op': 'move'}
    instructions[2041] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2042] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2043] = {6'd3, 8'd149, 8'd116, 32'd0};//{'dest': 149, 'src': 116, 'op': 'move'}
    instructions[2044] = {6'd3, 8'd151, 8'd114, 32'd0};//{'dest': 151, 'src': 114, 'op': 'move'}
    instructions[2045] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2046] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2047] = {6'd32, 8'd150, 8'd151, 32'd1};//{'dest': 150, 'src': 151, 'right': 1, 'signed': False, 'op': '<<'}
    instructions[2048] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2049] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2050] = {6'd33, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '-'}
    instructions[2051] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2052] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2053] = {6'd3, 8'd117, 8'd148, 32'd0};//{'dest': 117, 'src': 148, 'op': 'move'}
    instructions[2054] = {6'd3, 8'd153, 8'd115, 32'd0};//{'dest': 153, 'src': 115, 'op': 'move'}
    instructions[2055] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2056] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2057] = {6'd14, 8'd151, 8'd153, 32'd6};//{'dest': 151, 'src': 153, 'right': 6, 'signed': False, 'op': '+'}
    instructions[2058] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2059] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2060] = {6'd11, 8'd152, 8'd151, 32'd112};//{'dest': 152, 'src': 151, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2061] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2062] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2063] = {6'd17, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 17810064, 'op': 'memory_read_request'}
    instructions[2064] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2065] = {6'd18, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 17810064, 'op': 'memory_read_wait'}
    instructions[2066] = {6'd19, 8'd150, 8'd152, 32'd0};//{'dest': 150, 'src': 152, 'sequence': 17810064, 'element_size': 2, 'op': 'memory_read'}
    instructions[2067] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2068] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2069] = {6'd12, 8'd149, 8'd150, 32'd61440};//{'dest': 149, 'src': 150, 'right': 61440, 'signed': False, 'op': '&'}
    instructions[2070] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2071] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2072] = {6'd31, 8'd148, 8'd149, 32'd10};//{'dest': 148, 'src': 149, 'right': 10, 'signed': False, 'op': '>>'}
    instructions[2073] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2074] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2075] = {6'd3, 8'd118, 8'd148, 32'd0};//{'dest': 118, 'src': 148, 'op': 'move'}
    instructions[2076] = {6'd3, 8'd149, 8'd117, 32'd0};//{'dest': 149, 'src': 117, 'op': 'move'}
    instructions[2077] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2078] = {6'd3, 8'd150, 8'd118, 32'd0};//{'dest': 150, 'src': 118, 'op': 'move'}
    instructions[2079] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2080] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2081] = {6'd33, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '-'}
    instructions[2082] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2083] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2084] = {6'd3, 8'd108, 8'd148, 32'd0};//{'dest': 108, 'src': 148, 'op': 'move'}
    instructions[2085] = {6'd3, 8'd149, 8'd115, 32'd0};//{'dest': 149, 'src': 115, 'op': 'move'}
    instructions[2086] = {6'd3, 8'd151, 8'd118, 32'd0};//{'dest': 151, 'src': 118, 'op': 'move'}
    instructions[2087] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2088] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2089] = {6'd31, 8'd150, 8'd151, 32'd1};//{'dest': 150, 'src': 151, 'right': 1, 'signed': False, 'op': '>>'}
    instructions[2090] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2091] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2092] = {6'd11, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '+'}
    instructions[2093] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2094] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2095] = {6'd3, 8'd109, 8'd148, 32'd0};//{'dest': 109, 'src': 148, 'op': 'move'}
    instructions[2096] = {6'd3, 8'd151, 8'd115, 32'd0};//{'dest': 151, 'src': 115, 'op': 'move'}
    instructions[2097] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2098] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2099] = {6'd14, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'right': 0, 'signed': False, 'op': '+'}
    instructions[2100] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2101] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2102] = {6'd11, 8'd150, 8'd149, 32'd112};//{'dest': 150, 'src': 149, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2103] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2104] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2105] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17803168, 'op': 'memory_read_request'}
    instructions[2106] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2107] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17803168, 'op': 'memory_read_wait'}
    instructions[2108] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17803168, 'element_size': 2, 'op': 'memory_read'}
    instructions[2109] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2110] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2111] = {6'd3, 8'd94, 8'd148, 32'd0};//{'dest': 94, 'src': 148, 'op': 'move'}
    instructions[2112] = {6'd3, 8'd151, 8'd115, 32'd0};//{'dest': 151, 'src': 115, 'op': 'move'}
    instructions[2113] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2114] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2115] = {6'd14, 8'd149, 8'd151, 32'd1};//{'dest': 149, 'src': 151, 'right': 1, 'signed': False, 'op': '+'}
    instructions[2116] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2117] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2118] = {6'd11, 8'd150, 8'd149, 32'd112};//{'dest': 150, 'src': 149, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2119] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2120] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2121] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17802592, 'op': 'memory_read_request'}
    instructions[2122] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2123] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17802592, 'op': 'memory_read_wait'}
    instructions[2124] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17802592, 'element_size': 2, 'op': 'memory_read'}
    instructions[2125] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2126] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2127] = {6'd3, 8'd95, 8'd148, 32'd0};//{'dest': 95, 'src': 148, 'op': 'move'}
    instructions[2128] = {6'd3, 8'd151, 8'd115, 32'd0};//{'dest': 151, 'src': 115, 'op': 'move'}
    instructions[2129] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2130] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2131] = {6'd14, 8'd149, 8'd151, 32'd2};//{'dest': 149, 'src': 151, 'right': 2, 'signed': False, 'op': '+'}
    instructions[2132] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2133] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2134] = {6'd11, 8'd150, 8'd149, 32'd112};//{'dest': 150, 'src': 149, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2135] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2136] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2137] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17803600, 'op': 'memory_read_request'}
    instructions[2138] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2139] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17803600, 'op': 'memory_read_wait'}
    instructions[2140] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17803600, 'element_size': 2, 'op': 'memory_read'}
    instructions[2141] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[2142] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2143] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2144] = {6'd11, 8'd150, 8'd149, 32'd96};//{'dest': 150, 'src': 149, 'srcb': 96, 'signed': False, 'op': '+'}
    instructions[2145] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2146] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2147] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2148] = {6'd3, 8'd151, 8'd115, 32'd0};//{'dest': 151, 'src': 115, 'op': 'move'}
    instructions[2149] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2150] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2151] = {6'd14, 8'd149, 8'd151, 32'd3};//{'dest': 149, 'src': 151, 'right': 3, 'signed': False, 'op': '+'}
    instructions[2152] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2153] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2154] = {6'd11, 8'd150, 8'd149, 32'd112};//{'dest': 150, 'src': 149, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2155] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2156] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2157] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17804248, 'op': 'memory_read_request'}
    instructions[2158] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2159] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17804248, 'op': 'memory_read_wait'}
    instructions[2160] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17804248, 'element_size': 2, 'op': 'memory_read'}
    instructions[2161] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[2162] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2163] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2164] = {6'd11, 8'd150, 8'd149, 32'd96};//{'dest': 150, 'src': 149, 'srcb': 96, 'signed': False, 'op': '+'}
    instructions[2165] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2166] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2167] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2168] = {6'd3, 8'd151, 8'd115, 32'd0};//{'dest': 151, 'src': 115, 'op': 'move'}
    instructions[2169] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2170] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2171] = {6'd14, 8'd149, 8'd151, 32'd4};//{'dest': 149, 'src': 151, 'right': 4, 'signed': False, 'op': '+'}
    instructions[2172] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2173] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2174] = {6'd11, 8'd150, 8'd149, 32'd112};//{'dest': 150, 'src': 149, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2175] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2176] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2177] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17804392, 'op': 'memory_read_request'}
    instructions[2178] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2179] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17804392, 'op': 'memory_read_wait'}
    instructions[2180] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17804392, 'element_size': 2, 'op': 'memory_read'}
    instructions[2181] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[2182] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2183] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2184] = {6'd11, 8'd150, 8'd149, 32'd97};//{'dest': 150, 'src': 149, 'srcb': 97, 'signed': False, 'op': '+'}
    instructions[2185] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2186] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2187] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2188] = {6'd3, 8'd151, 8'd115, 32'd0};//{'dest': 151, 'src': 115, 'op': 'move'}
    instructions[2189] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2190] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2191] = {6'd14, 8'd149, 8'd151, 32'd5};//{'dest': 149, 'src': 151, 'right': 5, 'signed': False, 'op': '+'}
    instructions[2192] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2193] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2194] = {6'd11, 8'd150, 8'd149, 32'd112};//{'dest': 150, 'src': 149, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2195] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2196] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2197] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17805256, 'op': 'memory_read_request'}
    instructions[2198] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2199] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17805256, 'op': 'memory_read_wait'}
    instructions[2200] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17805256, 'element_size': 2, 'op': 'memory_read'}
    instructions[2201] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[2202] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2203] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2204] = {6'd11, 8'd150, 8'd149, 32'd97};//{'dest': 150, 'src': 149, 'srcb': 97, 'signed': False, 'op': '+'}
    instructions[2205] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2206] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2207] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2208] = {6'd3, 8'd151, 8'd115, 32'd0};//{'dest': 151, 'src': 115, 'op': 'move'}
    instructions[2209] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2210] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2211] = {6'd14, 8'd149, 8'd151, 32'd7};//{'dest': 149, 'src': 151, 'right': 7, 'signed': False, 'op': '+'}
    instructions[2212] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2213] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2214] = {6'd11, 8'd150, 8'd149, 32'd112};//{'dest': 150, 'src': 149, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2215] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2216] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2217] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17784200, 'op': 'memory_read_request'}
    instructions[2218] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2219] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17784200, 'op': 'memory_read_wait'}
    instructions[2220] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17784200, 'element_size': 2, 'op': 'memory_read'}
    instructions[2221] = {6'd3, 8'd152, 8'd115, 32'd0};//{'dest': 152, 'src': 115, 'op': 'move'}
    instructions[2222] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2223] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2224] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[2225] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2226] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2227] = {6'd11, 8'd151, 8'd150, 32'd112};//{'dest': 151, 'src': 150, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2228] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2229] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2230] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17784560, 'op': 'memory_read_request'}
    instructions[2231] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2232] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17784560, 'op': 'memory_read_wait'}
    instructions[2233] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17784560, 'element_size': 2, 'op': 'memory_read'}
    instructions[2234] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2235] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2236] = {6'd12, 8'd148, 8'd149, 32'd1};//{'dest': 148, 'src': 149, 'right': 1, 'signed': False, 'op': '&'}
    instructions[2237] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2238] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2239] = {6'd3, 8'd98, 8'd148, 32'd0};//{'dest': 98, 'src': 148, 'op': 'move'}
    instructions[2240] = {6'd3, 8'd152, 8'd115, 32'd0};//{'dest': 152, 'src': 115, 'op': 'move'}
    instructions[2241] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2242] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2243] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[2244] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2245] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2246] = {6'd11, 8'd151, 8'd150, 32'd112};//{'dest': 151, 'src': 150, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2247] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2248] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2249] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17781248, 'op': 'memory_read_request'}
    instructions[2250] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2251] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17781248, 'op': 'memory_read_wait'}
    instructions[2252] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17781248, 'element_size': 2, 'op': 'memory_read'}
    instructions[2253] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2254] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2255] = {6'd12, 8'd148, 8'd149, 32'd2};//{'dest': 148, 'src': 149, 'right': 2, 'signed': False, 'op': '&'}
    instructions[2256] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2257] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2258] = {6'd3, 8'd99, 8'd148, 32'd0};//{'dest': 99, 'src': 148, 'op': 'move'}
    instructions[2259] = {6'd3, 8'd152, 8'd115, 32'd0};//{'dest': 152, 'src': 115, 'op': 'move'}
    instructions[2260] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2261] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2262] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[2263] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2264] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2265] = {6'd11, 8'd151, 8'd150, 32'd112};//{'dest': 151, 'src': 150, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2266] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2267] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2268] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17781464, 'op': 'memory_read_request'}
    instructions[2269] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2270] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17781464, 'op': 'memory_read_wait'}
    instructions[2271] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17781464, 'element_size': 2, 'op': 'memory_read'}
    instructions[2272] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2273] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2274] = {6'd12, 8'd148, 8'd149, 32'd4};//{'dest': 148, 'src': 149, 'right': 4, 'signed': False, 'op': '&'}
    instructions[2275] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2276] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2277] = {6'd3, 8'd100, 8'd148, 32'd0};//{'dest': 100, 'src': 148, 'op': 'move'}
    instructions[2278] = {6'd3, 8'd152, 8'd115, 32'd0};//{'dest': 152, 'src': 115, 'op': 'move'}
    instructions[2279] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2280] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2281] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[2282] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2283] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2284] = {6'd11, 8'd151, 8'd150, 32'd112};//{'dest': 151, 'src': 150, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2285] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2286] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2287] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17781680, 'op': 'memory_read_request'}
    instructions[2288] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2289] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17781680, 'op': 'memory_read_wait'}
    instructions[2290] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17781680, 'element_size': 2, 'op': 'memory_read'}
    instructions[2291] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2292] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2293] = {6'd12, 8'd148, 8'd149, 32'd8};//{'dest': 148, 'src': 149, 'right': 8, 'signed': False, 'op': '&'}
    instructions[2294] = {6'd3, 8'd152, 8'd115, 32'd0};//{'dest': 152, 'src': 115, 'op': 'move'}
    instructions[2295] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2296] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2297] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[2298] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2299] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2300] = {6'd11, 8'd151, 8'd150, 32'd112};//{'dest': 151, 'src': 150, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2301] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2302] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2303] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17783336, 'op': 'memory_read_request'}
    instructions[2304] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2305] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17783336, 'op': 'memory_read_wait'}
    instructions[2306] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17783336, 'element_size': 2, 'op': 'memory_read'}
    instructions[2307] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2308] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2309] = {6'd12, 8'd148, 8'd149, 32'd16};//{'dest': 148, 'src': 149, 'right': 16, 'signed': False, 'op': '&'}
    instructions[2310] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2311] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2312] = {6'd3, 8'd101, 8'd148, 32'd0};//{'dest': 101, 'src': 148, 'op': 'move'}
    instructions[2313] = {6'd3, 8'd152, 8'd115, 32'd0};//{'dest': 152, 'src': 115, 'op': 'move'}
    instructions[2314] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2315] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2316] = {6'd14, 8'd150, 8'd152, 32'd6};//{'dest': 150, 'src': 152, 'right': 6, 'signed': False, 'op': '+'}
    instructions[2317] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2318] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2319] = {6'd11, 8'd151, 8'd150, 32'd112};//{'dest': 151, 'src': 150, 'srcb': 112, 'signed': False, 'op': '+'}
    instructions[2320] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2321] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2322] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17810568, 'op': 'memory_read_request'}
    instructions[2323] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2324] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17810568, 'op': 'memory_read_wait'}
    instructions[2325] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17810568, 'element_size': 2, 'op': 'memory_read'}
    instructions[2326] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2327] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2328] = {6'd12, 8'd148, 8'd149, 32'd32};//{'dest': 148, 'src': 149, 'right': 32, 'signed': False, 'op': '&'}
    instructions[2329] = {6'd3, 8'd111, 8'd113, 32'd0};//{'dest': 111, 'src': 113, 'op': 'move'}
    instructions[2330] = {6'd6, 8'd0, 8'd110, 32'd0};//{'src': 110, 'op': 'jmp_to_reg'}
    instructions[2331] = {6'd0, 8'd123, 8'd0, 32'd0};//{'dest': 123, 'literal': 0, 'op': 'literal'}
    instructions[2332] = {6'd0, 8'd124, 8'd0, 32'd0};//{'dest': 124, 'literal': 0, 'op': 'literal'}
    instructions[2333] = {6'd3, 8'd148, 8'd121, 32'd0};//{'dest': 148, 'src': 121, 'op': 'move'}
    instructions[2334] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2335] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2336] = {6'd3, 8'd124, 8'd148, 32'd0};//{'dest': 124, 'src': 148, 'op': 'move'}
    instructions[2337] = {6'd3, 8'd3, 8'd122, 32'd0};//{'dest': 3, 'src': 122, 'op': 'move'}
    instructions[2338] = {6'd1, 8'd2, 8'd0, 32'd45};//{'dest': 2, 'label': 45, 'op': 'jmp_and_link'}
    instructions[2339] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2340] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2341] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2342] = {6'd3, 8'd123, 8'd148, 32'd0};//{'dest': 123, 'src': 148, 'op': 'move'}
    instructions[2343] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2344] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2345] = {6'd3, 8'd149, 8'd123, 32'd0};//{'dest': 149, 'src': 123, 'op': 'move'}
    instructions[2346] = {6'd3, 8'd150, 8'd122, 32'd0};//{'dest': 150, 'src': 122, 'op': 'move'}
    instructions[2347] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2348] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2349] = {6'd20, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '<'}
    instructions[2350] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2351] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2352] = {6'd13, 8'd0, 8'd148, 32'd2374};//{'src': 148, 'label': 2374, 'op': 'jmp_if_false'}
    instructions[2353] = {6'd3, 8'd149, 8'd124, 32'd0};//{'dest': 149, 'src': 124, 'op': 'move'}
    instructions[2354] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2355] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2356] = {6'd11, 8'd150, 8'd149, 32'd120};//{'dest': 150, 'src': 149, 'srcb': 120, 'signed': False, 'op': '+'}
    instructions[2357] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2358] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2359] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17842120, 'op': 'memory_read_request'}
    instructions[2360] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2361] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17842120, 'op': 'memory_read_wait'}
    instructions[2362] = {6'd19, 8'd3, 8'd150, 32'd0};//{'dest': 3, 'src': 150, 'sequence': 17842120, 'element_size': 2, 'op': 'memory_read'}
    instructions[2363] = {6'd1, 8'd2, 8'd0, 32'd45};//{'dest': 2, 'label': 45, 'op': 'jmp_and_link'}
    instructions[2364] = {6'd3, 8'd148, 8'd124, 32'd0};//{'dest': 148, 'src': 124, 'op': 'move'}
    instructions[2365] = {6'd14, 8'd124, 8'd124, 32'd1};//{'dest': 124, 'src': 124, 'right': 1, 'signed': False, 'op': '+'}
    instructions[2366] = {6'd3, 8'd149, 8'd123, 32'd0};//{'dest': 149, 'src': 123, 'op': 'move'}
    instructions[2367] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2368] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2369] = {6'd14, 8'd148, 8'd149, 32'd2};//{'dest': 148, 'src': 149, 'right': 2, 'signed': False, 'op': '+'}
    instructions[2370] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2371] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2372] = {6'd3, 8'd123, 8'd148, 32'd0};//{'dest': 123, 'src': 148, 'op': 'move'}
    instructions[2373] = {6'd15, 8'd0, 8'd0, 32'd2343};//{'label': 2343, 'op': 'goto'}
    instructions[2374] = {6'd6, 8'd0, 8'd119, 32'd0};//{'src': 119, 'op': 'jmp_to_reg'}
    instructions[2375] = {6'd0, 8'd129, 8'd0, 32'd0};//{'dest': 129, 'literal': 0, 'op': 'literal'}
    instructions[2376] = {6'd0, 8'd130, 8'd0, 32'd0};//{'dest': 130, 'literal': 0, 'op': 'literal'}
    instructions[2377] = {6'd0, 8'd131, 8'd0, 32'd0};//{'dest': 131, 'literal': 0, 'op': 'literal'}
    instructions[2378] = {6'd37, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'input': 'socket', 'op': 'ready'}
    instructions[2379] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2380] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2381] = {6'd38, 8'd148, 8'd149, 32'd0};//{'dest': 148, 'src': 149, 'right': 0, 'signed': True, 'op': '=='}
    instructions[2382] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2383] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2384] = {6'd13, 8'd0, 8'd148, 32'd2388};//{'src': 148, 'label': 2388, 'op': 'jmp_if_false'}
    instructions[2385] = {6'd0, 8'd126, 8'd0, 32'd0};//{'dest': 126, 'literal': 0, 'op': 'literal'}
    instructions[2386] = {6'd6, 8'd0, 8'd125, 32'd0};//{'src': 125, 'op': 'jmp_to_reg'}
    instructions[2387] = {6'd15, 8'd0, 8'd0, 32'd2388};//{'label': 2388, 'op': 'goto'}
    instructions[2388] = {6'd3, 8'd148, 8'd128, 32'd0};//{'dest': 148, 'src': 128, 'op': 'move'}
    instructions[2389] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2390] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2391] = {6'd3, 8'd130, 8'd148, 32'd0};//{'dest': 130, 'src': 148, 'op': 'move'}
    instructions[2392] = {6'd1, 8'd8, 8'd0, 32'd54};//{'dest': 8, 'label': 54, 'op': 'jmp_and_link'}
    instructions[2393] = {6'd3, 8'd148, 8'd9, 32'd0};//{'dest': 148, 'src': 9, 'op': 'move'}
    instructions[2394] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2395] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2396] = {6'd3, 8'd131, 8'd148, 32'd0};//{'dest': 131, 'src': 148, 'op': 'move'}
    instructions[2397] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2398] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2399] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2400] = {6'd3, 8'd129, 8'd148, 32'd0};//{'dest': 129, 'src': 148, 'op': 'move'}
    instructions[2401] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2402] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2403] = {6'd3, 8'd149, 8'd129, 32'd0};//{'dest': 149, 'src': 129, 'op': 'move'}
    instructions[2404] = {6'd3, 8'd150, 8'd131, 32'd0};//{'dest': 150, 'src': 131, 'op': 'move'}
    instructions[2405] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2406] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2407] = {6'd20, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '<'}
    instructions[2408] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2409] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2410] = {6'd13, 8'd0, 8'd148, 32'd2430};//{'src': 148, 'label': 2430, 'op': 'jmp_if_false'}
    instructions[2411] = {6'd1, 8'd8, 8'd0, 32'd54};//{'dest': 8, 'label': 54, 'op': 'jmp_and_link'}
    instructions[2412] = {6'd3, 8'd148, 8'd9, 32'd0};//{'dest': 148, 'src': 9, 'op': 'move'}
    instructions[2413] = {6'd3, 8'd149, 8'd130, 32'd0};//{'dest': 149, 'src': 130, 'op': 'move'}
    instructions[2414] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2415] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2416] = {6'd11, 8'd150, 8'd149, 32'd127};//{'dest': 150, 'src': 149, 'srcb': 127, 'signed': False, 'op': '+'}
    instructions[2417] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2418] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2419] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2420] = {6'd3, 8'd148, 8'd130, 32'd0};//{'dest': 148, 'src': 130, 'op': 'move'}
    instructions[2421] = {6'd14, 8'd130, 8'd130, 32'd1};//{'dest': 130, 'src': 130, 'right': 1, 'signed': False, 'op': '+'}
    instructions[2422] = {6'd3, 8'd149, 8'd129, 32'd0};//{'dest': 149, 'src': 129, 'op': 'move'}
    instructions[2423] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2424] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2425] = {6'd14, 8'd148, 8'd149, 32'd2};//{'dest': 148, 'src': 149, 'right': 2, 'signed': False, 'op': '+'}
    instructions[2426] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2427] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2428] = {6'd3, 8'd129, 8'd148, 32'd0};//{'dest': 129, 'src': 148, 'op': 'move'}
    instructions[2429] = {6'd15, 8'd0, 8'd0, 32'd2401};//{'label': 2401, 'op': 'goto'}
    instructions[2430] = {6'd3, 8'd126, 8'd131, 32'd0};//{'dest': 126, 'src': 131, 'op': 'move'}
    instructions[2431] = {6'd6, 8'd0, 8'd125, 32'd0};//{'src': 125, 'op': 'jmp_to_reg'}
    instructions[2432] = {6'd0, 8'd133, 8'd0, 32'd618};//{'dest': 133, 'literal': 618, 'op': 'literal'}
    instructions[2433] = {6'd0, 8'd134, 8'd0, 32'd1642};//{'dest': 134, 'literal': 1642, 'op': 'literal'}
    instructions[2434] = {6'd0, 8'd135, 8'd0, 32'd27};//{'dest': 135, 'literal': 27, 'op': 'literal'}
    instructions[2435] = {6'd0, 8'd136, 8'd0, 32'd0};//{'dest': 136, 'literal': 0, 'op': 'literal'}
    instructions[2436] = {6'd0, 8'd137, 8'd0, 32'd0};//{'dest': 137, 'literal': 0, 'op': 'literal'}
    instructions[2437] = {6'd0, 8'd138, 8'd0, 32'd0};//{'dest': 138, 'literal': 0, 'op': 'literal'}
    instructions[2438] = {6'd0, 8'd139, 8'd0, 32'd0};//{'dest': 139, 'literal': 0, 'op': 'literal'}
    instructions[2439] = {6'd0, 8'd140, 8'd0, 32'd0};//{'dest': 140, 'literal': 0, 'op': 'literal'}
    instructions[2440] = {6'd0, 8'd141, 8'd0, 32'd0};//{'dest': 141, 'literal': 0, 'op': 'literal'}
    instructions[2441] = {6'd0, 8'd142, 8'd0, 32'd0};//{'dest': 142, 'literal': 0, 'op': 'literal'}
    instructions[2442] = {6'd0, 8'd143, 8'd0, 32'd1};//{'dest': 143, 'literal': 1, 'op': 'literal'}
    instructions[2443] = {6'd0, 8'd144, 8'd0, 32'd2};//{'dest': 144, 'literal': 2, 'op': 'literal'}
    instructions[2444] = {6'd0, 8'd145, 8'd0, 32'd3};//{'dest': 145, 'literal': 3, 'op': 'literal'}
    instructions[2445] = {6'd0, 8'd146, 8'd0, 32'd4};//{'dest': 146, 'literal': 4, 'op': 'literal'}
    instructions[2446] = {6'd3, 8'd147, 8'd142, 32'd0};//{'dest': 147, 'src': 142, 'op': 'move'}
    instructions[2447] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2448] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[2449] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2450] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2451] = {6'd11, 8'd150, 8'd149, 32'd84};//{'dest': 150, 'src': 149, 'srcb': 84, 'signed': False, 'op': '+'}
    instructions[2452] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2453] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2454] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2455] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2456] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[2457] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2458] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2459] = {6'd11, 8'd150, 8'd149, 32'd84};//{'dest': 150, 'src': 149, 'srcb': 84, 'signed': False, 'op': '+'}
    instructions[2460] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2461] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2462] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2463] = {6'd3, 8'd148, 8'd137, 32'd0};//{'dest': 148, 'src': 137, 'op': 'move'}
    instructions[2464] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2465] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2466] = {6'd13, 8'd0, 8'd148, 32'd2470};//{'src': 148, 'label': 2470, 'op': 'jmp_if_false'}
    instructions[2467] = {6'd3, 8'd148, 8'd137, 32'd0};//{'dest': 148, 'src': 137, 'op': 'move'}
    instructions[2468] = {6'd34, 8'd137, 8'd137, 32'd1};//{'dest': 137, 'src': 137, 'right': 1, 'signed': False, 'op': '-'}
    instructions[2469] = {6'd15, 8'd0, 8'd0, 32'd2497};//{'label': 2497, 'op': 'goto'}
    instructions[2470] = {6'd0, 8'd148, 8'd0, 32'd120};//{'dest': 148, 'literal': 120, 'op': 'literal'}
    instructions[2471] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2472] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2473] = {6'd3, 8'd137, 8'd148, 32'd0};//{'dest': 137, 'src': 148, 'op': 'move'}
    instructions[2474] = {6'd3, 8'd148, 8'd142, 32'd0};//{'dest': 148, 'src': 142, 'op': 'move'}
    instructions[2475] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2476] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2477] = {6'd3, 8'd147, 8'd148, 32'd0};//{'dest': 147, 'src': 148, 'op': 'move'}
    instructions[2478] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2479] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2480] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2481] = {6'd3, 8'd89, 8'd148, 32'd0};//{'dest': 89, 'src': 148, 'op': 'move'}
    instructions[2482] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2483] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2484] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2485] = {6'd3, 8'd88, 8'd148, 32'd0};//{'dest': 88, 'src': 148, 'op': 'move'}
    instructions[2486] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2487] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2488] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2489] = {6'd3, 8'd92, 8'd148, 32'd0};//{'dest': 92, 'src': 148, 'op': 'move'}
    instructions[2490] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[2491] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2492] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2493] = {6'd3, 8'd90, 8'd148, 32'd0};//{'dest': 90, 'src': 148, 'op': 'move'}
    instructions[2494] = {6'd3, 8'd103, 8'd134, 32'd0};//{'dest': 103, 'src': 134, 'op': 'move'}
    instructions[2495] = {6'd0, 8'd104, 8'd0, 32'd0};//{'dest': 104, 'literal': 0, 'op': 'literal'}
    instructions[2496] = {6'd1, 8'd102, 8'd0, 32'd1565};//{'dest': 102, 'label': 1565, 'op': 'jmp_and_link'}
    instructions[2497] = {6'd3, 8'd148, 8'd147, 32'd0};//{'dest': 148, 'src': 147, 'op': 'move'}
    instructions[2498] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2499] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2500] = {6'd38, 8'd149, 8'd148, 32'd0};//{'dest': 149, 'src': 148, 'right': 0, 'signed': True, 'op': '=='}
    instructions[2501] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2502] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2503] = {6'd22, 8'd0, 8'd149, 32'd2520};//{'src': 149, 'label': 2520, 'op': 'jmp_if_true'}
    instructions[2504] = {6'd38, 8'd149, 8'd148, 32'd1};//{'dest': 149, 'src': 148, 'right': 1, 'signed': True, 'op': '=='}
    instructions[2505] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2506] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2507] = {6'd22, 8'd0, 8'd149, 32'd2537};//{'src': 149, 'label': 2537, 'op': 'jmp_if_true'}
    instructions[2508] = {6'd38, 8'd149, 8'd148, 32'd2};//{'dest': 149, 'src': 148, 'right': 2, 'signed': True, 'op': '=='}
    instructions[2509] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2510] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2511] = {6'd22, 8'd0, 8'd149, 32'd2588};//{'src': 149, 'label': 2588, 'op': 'jmp_if_true'}
    instructions[2512] = {6'd38, 8'd149, 8'd148, 32'd3};//{'dest': 149, 'src': 148, 'right': 3, 'signed': True, 'op': '=='}
    instructions[2513] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2514] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2515] = {6'd22, 8'd0, 8'd149, 32'd2646};//{'src': 149, 'label': 2646, 'op': 'jmp_if_true'}
    instructions[2516] = {6'd38, 8'd149, 8'd148, 32'd4};//{'dest': 149, 'src': 148, 'right': 4, 'signed': True, 'op': '=='}
    instructions[2517] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2518] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2519] = {6'd22, 8'd0, 8'd149, 32'd2650};//{'src': 149, 'label': 2650, 'op': 'jmp_if_true'}
    instructions[2520] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2521] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2522] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2523] = {6'd3, 8'd90, 8'd148, 32'd0};//{'dest': 90, 'src': 148, 'op': 'move'}
    instructions[2524] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2525] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2526] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2527] = {6'd3, 8'd89, 8'd148, 32'd0};//{'dest': 89, 'src': 148, 'op': 'move'}
    instructions[2528] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2529] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2530] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2531] = {6'd3, 8'd88, 8'd148, 32'd0};//{'dest': 88, 'src': 148, 'op': 'move'}
    instructions[2532] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2533] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2534] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2535] = {6'd3, 8'd92, 8'd148, 32'd0};//{'dest': 92, 'src': 148, 'op': 'move'}
    instructions[2536] = {6'd15, 8'd0, 8'd0, 32'd2667};//{'label': 2667, 'op': 'goto'}
    instructions[2537] = {6'd0, 8'd149, 8'd0, 32'd13};//{'dest': 149, 'literal': 13, 'op': 'literal'}
    instructions[2538] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2539] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2540] = {6'd11, 8'd150, 8'd149, 32'd133};//{'dest': 150, 'src': 149, 'srcb': 133, 'signed': False, 'op': '+'}
    instructions[2541] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2542] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2543] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17857784, 'op': 'memory_read_request'}
    instructions[2544] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2545] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17857784, 'op': 'memory_read_wait'}
    instructions[2546] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17857784, 'element_size': 2, 'op': 'memory_read'}
    instructions[2547] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2548] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2549] = {6'd3, 8'd80, 8'd148, 32'd0};//{'dest': 80, 'src': 148, 'op': 'move'}
    instructions[2550] = {6'd0, 8'd149, 8'd0, 32'd14};//{'dest': 149, 'literal': 14, 'op': 'literal'}
    instructions[2551] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2552] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2553] = {6'd11, 8'd150, 8'd149, 32'd133};//{'dest': 150, 'src': 149, 'srcb': 133, 'signed': False, 'op': '+'}
    instructions[2554] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2555] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2556] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17858144, 'op': 'memory_read_request'}
    instructions[2557] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2558] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17858144, 'op': 'memory_read_wait'}
    instructions[2559] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17858144, 'element_size': 2, 'op': 'memory_read'}
    instructions[2560] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2561] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2562] = {6'd3, 8'd81, 8'd148, 32'd0};//{'dest': 81, 'src': 148, 'op': 'move'}
    instructions[2563] = {6'd3, 8'd148, 8'd94, 32'd0};//{'dest': 148, 'src': 94, 'op': 'move'}
    instructions[2564] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2565] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2566] = {6'd3, 8'd83, 8'd148, 32'd0};//{'dest': 83, 'src': 148, 'op': 'move'}
    instructions[2567] = {6'd3, 8'd148, 8'd15, 32'd0};//{'dest': 148, 'src': 15, 'op': 'move'}
    instructions[2568] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2569] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2570] = {6'd3, 8'd82, 8'd148, 32'd0};//{'dest': 82, 'src': 148, 'op': 'move'}
    instructions[2571] = {6'd3, 8'd25, 8'd86, 32'd0};//{'dest': 25, 'src': 86, 'op': 'move'}
    instructions[2572] = {6'd3, 8'd26, 8'd96, 32'd0};//{'dest': 26, 'src': 96, 'op': 'move'}
    instructions[2573] = {6'd0, 8'd27, 8'd0, 32'd1};//{'dest': 27, 'literal': 1, 'op': 'literal'}
    instructions[2574] = {6'd1, 8'd23, 8'd0, 32'd102};//{'dest': 23, 'label': 102, 'op': 'jmp_and_link'}
    instructions[2575] = {6'd3, 8'd148, 8'd24, 32'd0};//{'dest': 148, 'src': 24, 'op': 'move'}
    instructions[2576] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[2577] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2578] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2579] = {6'd3, 8'd89, 8'd148, 32'd0};//{'dest': 89, 'src': 148, 'op': 'move'}
    instructions[2580] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[2581] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2582] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2583] = {6'd3, 8'd92, 8'd148, 32'd0};//{'dest': 92, 'src': 148, 'op': 'move'}
    instructions[2584] = {6'd3, 8'd103, 8'd134, 32'd0};//{'dest': 103, 'src': 134, 'op': 'move'}
    instructions[2585] = {6'd0, 8'd104, 8'd0, 32'd0};//{'dest': 104, 'literal': 0, 'op': 'literal'}
    instructions[2586] = {6'd1, 8'd102, 8'd0, 32'd1565};//{'dest': 102, 'label': 1565, 'op': 'jmp_and_link'}
    instructions[2587] = {6'd15, 8'd0, 8'd0, 32'd2667};//{'label': 2667, 'op': 'goto'}
    instructions[2588] = {6'd3, 8'd127, 8'd134, 32'd0};//{'dest': 127, 'src': 134, 'op': 'move'}
    instructions[2589] = {6'd3, 8'd128, 8'd135, 32'd0};//{'dest': 128, 'src': 135, 'op': 'move'}
    instructions[2590] = {6'd1, 8'd125, 8'd0, 32'd2375};//{'dest': 125, 'label': 2375, 'op': 'jmp_and_link'}
    instructions[2591] = {6'd3, 8'd148, 8'd126, 32'd0};//{'dest': 148, 'src': 126, 'op': 'move'}
    instructions[2592] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2593] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2594] = {6'd3, 8'd136, 8'd148, 32'd0};//{'dest': 136, 'src': 148, 'op': 'move'}
    instructions[2595] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[2596] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2597] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2598] = {6'd11, 8'd150, 8'd149, 32'd85};//{'dest': 150, 'src': 149, 'srcb': 85, 'signed': False, 'op': '+'}
    instructions[2599] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2600] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2601] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17865328, 'op': 'memory_read_request'}
    instructions[2602] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2603] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17865328, 'op': 'memory_read_wait'}
    instructions[2604] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17865328, 'element_size': 2, 'op': 'memory_read'}
    instructions[2605] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[2606] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2607] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2608] = {6'd11, 8'd150, 8'd149, 32'd84};//{'dest': 150, 'src': 149, 'srcb': 84, 'signed': False, 'op': '+'}
    instructions[2609] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2610] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2611] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2612] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[2613] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2614] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2615] = {6'd11, 8'd150, 8'd149, 32'd85};//{'dest': 150, 'src': 149, 'srcb': 85, 'signed': False, 'op': '+'}
    instructions[2616] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2617] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2618] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17865760, 'op': 'memory_read_request'}
    instructions[2619] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2620] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17865760, 'op': 'memory_read_wait'}
    instructions[2621] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17865760, 'element_size': 2, 'op': 'memory_read'}
    instructions[2622] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[2623] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2624] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2625] = {6'd11, 8'd150, 8'd149, 32'd84};//{'dest': 150, 'src': 149, 'srcb': 84, 'signed': False, 'op': '+'}
    instructions[2626] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2627] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2628] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2629] = {6'd3, 8'd25, 8'd85, 32'd0};//{'dest': 25, 'src': 85, 'op': 'move'}
    instructions[2630] = {6'd3, 8'd26, 8'd84, 32'd0};//{'dest': 26, 'src': 84, 'op': 'move'}
    instructions[2631] = {6'd3, 8'd27, 8'd136, 32'd0};//{'dest': 27, 'src': 136, 'op': 'move'}
    instructions[2632] = {6'd1, 8'd23, 8'd0, 32'd102};//{'dest': 23, 'label': 102, 'op': 'jmp_and_link'}
    instructions[2633] = {6'd3, 8'd148, 8'd24, 32'd0};//{'dest': 148, 'src': 24, 'op': 'move'}
    instructions[2634] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2635] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2636] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2637] = {6'd3, 8'd89, 8'd148, 32'd0};//{'dest': 89, 'src': 148, 'op': 'move'}
    instructions[2638] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[2639] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2640] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2641] = {6'd3, 8'd92, 8'd148, 32'd0};//{'dest': 92, 'src': 148, 'op': 'move'}
    instructions[2642] = {6'd3, 8'd103, 8'd134, 32'd0};//{'dest': 103, 'src': 134, 'op': 'move'}
    instructions[2643] = {6'd3, 8'd104, 8'd136, 32'd0};//{'dest': 104, 'src': 136, 'op': 'move'}
    instructions[2644] = {6'd1, 8'd102, 8'd0, 32'd1565};//{'dest': 102, 'label': 1565, 'op': 'jmp_and_link'}
    instructions[2645] = {6'd15, 8'd0, 8'd0, 32'd2667};//{'label': 2667, 'op': 'goto'}
    instructions[2646] = {6'd3, 8'd103, 8'd134, 32'd0};//{'dest': 103, 'src': 134, 'op': 'move'}
    instructions[2647] = {6'd3, 8'd104, 8'd136, 32'd0};//{'dest': 104, 'src': 136, 'op': 'move'}
    instructions[2648] = {6'd1, 8'd102, 8'd0, 32'd1565};//{'dest': 102, 'label': 1565, 'op': 'jmp_and_link'}
    instructions[2649] = {6'd15, 8'd0, 8'd0, 32'd2667};//{'label': 2667, 'op': 'goto'}
    instructions[2650] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[2651] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2652] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2653] = {6'd3, 8'd88, 8'd148, 32'd0};//{'dest': 88, 'src': 148, 'op': 'move'}
    instructions[2654] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[2655] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2656] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2657] = {6'd3, 8'd92, 8'd148, 32'd0};//{'dest': 92, 'src': 148, 'op': 'move'}
    instructions[2658] = {6'd3, 8'd25, 8'd86, 32'd0};//{'dest': 25, 'src': 86, 'op': 'move'}
    instructions[2659] = {6'd3, 8'd26, 8'd96, 32'd0};//{'dest': 26, 'src': 96, 'op': 'move'}
    instructions[2660] = {6'd0, 8'd27, 8'd0, 32'd1};//{'dest': 27, 'literal': 1, 'op': 'literal'}
    instructions[2661] = {6'd1, 8'd23, 8'd0, 32'd102};//{'dest': 23, 'label': 102, 'op': 'jmp_and_link'}
    instructions[2662] = {6'd3, 8'd148, 8'd24, 32'd0};//{'dest': 148, 'src': 24, 'op': 'move'}
    instructions[2663] = {6'd3, 8'd103, 8'd134, 32'd0};//{'dest': 103, 'src': 134, 'op': 'move'}
    instructions[2664] = {6'd0, 8'd104, 8'd0, 32'd0};//{'dest': 104, 'literal': 0, 'op': 'literal'}
    instructions[2665] = {6'd1, 8'd102, 8'd0, 32'd1565};//{'dest': 102, 'label': 1565, 'op': 'jmp_and_link'}
    instructions[2666] = {6'd15, 8'd0, 8'd0, 32'd2667};//{'label': 2667, 'op': 'goto'}
    instructions[2667] = {6'd0, 8'd148, 8'd0, 32'd10000};//{'dest': 148, 'literal': 10000, 'op': 'literal'}
    instructions[2668] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2669] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2670] = {6'd3, 8'd138, 8'd148, 32'd0};//{'dest': 138, 'src': 148, 'op': 'move'}
    instructions[2671] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2672] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2673] = {6'd3, 8'd148, 8'd138, 32'd0};//{'dest': 148, 'src': 138, 'op': 'move'}
    instructions[2674] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2675] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2676] = {6'd13, 8'd0, 8'd148, 32'd3023};//{'src': 148, 'label': 3023, 'op': 'jmp_if_false'}
    instructions[2677] = {6'd3, 8'd112, 8'd133, 32'd0};//{'dest': 112, 'src': 133, 'op': 'move'}
    instructions[2678] = {6'd1, 8'd110, 8'd0, 32'd1985};//{'dest': 110, 'label': 1985, 'op': 'jmp_and_link'}
    instructions[2679] = {6'd3, 8'd148, 8'd111, 32'd0};//{'dest': 148, 'src': 111, 'op': 'move'}
    instructions[2680] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2681] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2682] = {6'd3, 8'd139, 8'd148, 32'd0};//{'dest': 139, 'src': 148, 'op': 'move'}
    instructions[2683] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2684] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2685] = {6'd3, 8'd148, 8'd139, 32'd0};//{'dest': 148, 'src': 139, 'op': 'move'}
    instructions[2686] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2687] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2688] = {6'd13, 8'd0, 8'd148, 32'd2694};//{'src': 148, 'label': 2694, 'op': 'jmp_if_false'}
    instructions[2689] = {6'd3, 8'd149, 8'd95, 32'd0};//{'dest': 149, 'src': 95, 'op': 'move'}
    instructions[2690] = {6'd3, 8'd150, 8'd15, 32'd0};//{'dest': 150, 'src': 15, 'op': 'move'}
    instructions[2691] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2692] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2693] = {6'd28, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '=='}
    instructions[2694] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2695] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2696] = {6'd13, 8'd0, 8'd148, 32'd3016};//{'src': 148, 'label': 3016, 'op': 'jmp_if_false'}
    instructions[2697] = {6'd3, 8'd149, 8'd147, 32'd0};//{'dest': 149, 'src': 147, 'op': 'move'}
    instructions[2698] = {6'd3, 8'd150, 8'd142, 32'd0};//{'dest': 150, 'src': 142, 'op': 'move'}
    instructions[2699] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2700] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2701] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[2702] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2703] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2704] = {6'd13, 8'd0, 8'd148, 32'd2710};//{'src': 148, 'label': 2710, 'op': 'jmp_if_false'}
    instructions[2705] = {6'd3, 8'd149, 8'd94, 32'd0};//{'dest': 149, 'src': 94, 'op': 'move'}
    instructions[2706] = {6'd3, 8'd150, 8'd83, 32'd0};//{'dest': 150, 'src': 83, 'op': 'move'}
    instructions[2707] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2708] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2709] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[2710] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2711] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2712] = {6'd13, 8'd0, 8'd148, 32'd2715};//{'src': 148, 'label': 2715, 'op': 'jmp_if_false'}
    instructions[2713] = {6'd15, 8'd0, 8'd0, 32'd3020};//{'label': 3020, 'op': 'goto'}
    instructions[2714] = {6'd15, 8'd0, 8'd0, 32'd2715};//{'label': 2715, 'op': 'goto'}
    instructions[2715] = {6'd0, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'literal': 0, 'op': 'literal'}
    instructions[2716] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2717] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2718] = {6'd3, 8'd141, 8'd148, 32'd0};//{'dest': 141, 'src': 148, 'op': 'move'}
    instructions[2719] = {6'd3, 8'd148, 8'd147, 32'd0};//{'dest': 148, 'src': 147, 'op': 'move'}
    instructions[2720] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2721] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2722] = {6'd3, 8'd140, 8'd148, 32'd0};//{'dest': 140, 'src': 148, 'op': 'move'}
    instructions[2723] = {6'd3, 8'd148, 8'd147, 32'd0};//{'dest': 148, 'src': 147, 'op': 'move'}
    instructions[2724] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2725] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2726] = {6'd38, 8'd149, 8'd148, 32'd0};//{'dest': 149, 'src': 148, 'right': 0, 'signed': True, 'op': '=='}
    instructions[2727] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2728] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2729] = {6'd22, 8'd0, 8'd149, 32'd2746};//{'src': 149, 'label': 2746, 'op': 'jmp_if_true'}
    instructions[2730] = {6'd38, 8'd149, 8'd148, 32'd1};//{'dest': 149, 'src': 148, 'right': 1, 'signed': True, 'op': '=='}
    instructions[2731] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2732] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2733] = {6'd22, 8'd0, 8'd149, 32'd2763};//{'src': 149, 'label': 2763, 'op': 'jmp_if_true'}
    instructions[2734] = {6'd38, 8'd149, 8'd148, 32'd2};//{'dest': 149, 'src': 148, 'right': 2, 'signed': True, 'op': '=='}
    instructions[2735] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2736] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2737] = {6'd22, 8'd0, 8'd149, 32'd2841};//{'src': 149, 'label': 2841, 'op': 'jmp_if_true'}
    instructions[2738] = {6'd38, 8'd149, 8'd148, 32'd3};//{'dest': 149, 'src': 148, 'right': 3, 'signed': True, 'op': '=='}
    instructions[2739] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2740] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2741] = {6'd22, 8'd0, 8'd149, 32'd2868};//{'src': 149, 'label': 2868, 'op': 'jmp_if_true'}
    instructions[2742] = {6'd38, 8'd149, 8'd148, 32'd4};//{'dest': 149, 'src': 148, 'right': 4, 'signed': True, 'op': '=='}
    instructions[2743] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2744] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2745] = {6'd22, 8'd0, 8'd149, 32'd2947};//{'src': 149, 'label': 2947, 'op': 'jmp_if_true'}
    instructions[2746] = {6'd3, 8'd148, 8'd99, 32'd0};//{'dest': 148, 'src': 99, 'op': 'move'}
    instructions[2747] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2748] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2749] = {6'd13, 8'd0, 8'd148, 32'd2755};//{'src': 148, 'label': 2755, 'op': 'jmp_if_false'}
    instructions[2750] = {6'd3, 8'd148, 8'd143, 32'd0};//{'dest': 148, 'src': 143, 'op': 'move'}
    instructions[2751] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2752] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2753] = {6'd3, 8'd147, 8'd148, 32'd0};//{'dest': 147, 'src': 148, 'op': 'move'}
    instructions[2754] = {6'd15, 8'd0, 8'd0, 32'd2762};//{'label': 2762, 'op': 'goto'}
    instructions[2755] = {6'd0, 8'd148, 8'd0, 32'd1};//{'dest': 148, 'literal': 1, 'op': 'literal'}
    instructions[2756] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2757] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2758] = {6'd3, 8'd90, 8'd148, 32'd0};//{'dest': 90, 'src': 148, 'op': 'move'}
    instructions[2759] = {6'd3, 8'd103, 8'd134, 32'd0};//{'dest': 103, 'src': 134, 'op': 'move'}
    instructions[2760] = {6'd0, 8'd104, 8'd0, 32'd0};//{'dest': 104, 'literal': 0, 'op': 'literal'}
    instructions[2761] = {6'd1, 8'd102, 8'd0, 32'd1565};//{'dest': 102, 'label': 1565, 'op': 'jmp_and_link'}
    instructions[2762] = {6'd15, 8'd0, 8'd0, 32'd2957};//{'label': 2957, 'op': 'goto'}
    instructions[2763] = {6'd3, 8'd148, 8'd101, 32'd0};//{'dest': 148, 'src': 101, 'op': 'move'}
    instructions[2764] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2765] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2766] = {6'd13, 8'd0, 8'd148, 32'd2840};//{'src': 148, 'label': 2840, 'op': 'jmp_if_false'}
    instructions[2767] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[2768] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2769] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2770] = {6'd11, 8'd150, 8'd149, 32'd97};//{'dest': 150, 'src': 149, 'srcb': 97, 'signed': False, 'op': '+'}
    instructions[2771] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2772] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2773] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17858640, 'op': 'memory_read_request'}
    instructions[2774] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2775] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17858640, 'op': 'memory_read_wait'}
    instructions[2776] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17858640, 'element_size': 2, 'op': 'memory_read'}
    instructions[2777] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[2778] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2779] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2780] = {6'd11, 8'd150, 8'd149, 32'd84};//{'dest': 150, 'src': 149, 'srcb': 84, 'signed': False, 'op': '+'}
    instructions[2781] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2782] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2783] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2784] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[2785] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2786] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2787] = {6'd11, 8'd150, 8'd149, 32'd97};//{'dest': 150, 'src': 149, 'srcb': 97, 'signed': False, 'op': '+'}
    instructions[2788] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2789] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2790] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17859072, 'op': 'memory_read_request'}
    instructions[2791] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2792] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17859072, 'op': 'memory_read_wait'}
    instructions[2793] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17859072, 'element_size': 2, 'op': 'memory_read'}
    instructions[2794] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[2795] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2796] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2797] = {6'd11, 8'd150, 8'd149, 32'd84};//{'dest': 150, 'src': 149, 'srcb': 84, 'signed': False, 'op': '+'}
    instructions[2798] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2799] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2800] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2801] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[2802] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2803] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2804] = {6'd11, 8'd150, 8'd149, 32'd97};//{'dest': 150, 'src': 149, 'srcb': 97, 'signed': False, 'op': '+'}
    instructions[2805] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2806] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2807] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17859504, 'op': 'memory_read_request'}
    instructions[2808] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2809] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17859504, 'op': 'memory_read_wait'}
    instructions[2810] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17859504, 'element_size': 2, 'op': 'memory_read'}
    instructions[2811] = {6'd0, 8'd149, 8'd0, 32'd1};//{'dest': 149, 'literal': 1, 'op': 'literal'}
    instructions[2812] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2813] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2814] = {6'd11, 8'd150, 8'd149, 32'd85};//{'dest': 150, 'src': 149, 'srcb': 85, 'signed': False, 'op': '+'}
    instructions[2815] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2816] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2817] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2818] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[2819] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2820] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2821] = {6'd11, 8'd150, 8'd149, 32'd97};//{'dest': 150, 'src': 149, 'srcb': 97, 'signed': False, 'op': '+'}
    instructions[2822] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2823] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2824] = {6'd17, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17859936, 'op': 'memory_read_request'}
    instructions[2825] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2826] = {6'd18, 8'd0, 8'd150, 32'd0};//{'element_size': 2, 'src': 150, 'sequence': 17859936, 'op': 'memory_read_wait'}
    instructions[2827] = {6'd19, 8'd148, 8'd150, 32'd0};//{'dest': 148, 'src': 150, 'sequence': 17859936, 'element_size': 2, 'op': 'memory_read'}
    instructions[2828] = {6'd0, 8'd149, 8'd0, 32'd0};//{'dest': 149, 'literal': 0, 'op': 'literal'}
    instructions[2829] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2830] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2831] = {6'd11, 8'd150, 8'd149, 32'd85};//{'dest': 150, 'src': 149, 'srcb': 85, 'signed': False, 'op': '+'}
    instructions[2832] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2833] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2834] = {6'd23, 8'd0, 8'd150, 32'd148};//{'srcb': 148, 'src': 150, 'element_size': 2, 'op': 'memory_write'}
    instructions[2835] = {6'd3, 8'd148, 8'd144, 32'd0};//{'dest': 148, 'src': 144, 'op': 'move'}
    instructions[2836] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2837] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2838] = {6'd3, 8'd147, 8'd148, 32'd0};//{'dest': 147, 'src': 148, 'op': 'move'}
    instructions[2839] = {6'd15, 8'd0, 8'd0, 32'd2840};//{'label': 2840, 'op': 'goto'}
    instructions[2840] = {6'd15, 8'd0, 8'd0, 32'd2957};//{'label': 2957, 'op': 'goto'}
    instructions[2841] = {6'd3, 8'd25, 8'd86, 32'd0};//{'dest': 25, 'src': 86, 'op': 'move'}
    instructions[2842] = {6'd3, 8'd26, 8'd96, 32'd0};//{'dest': 26, 'src': 96, 'op': 'move'}
    instructions[2843] = {6'd3, 8'd27, 8'd108, 32'd0};//{'dest': 27, 'src': 108, 'op': 'move'}
    instructions[2844] = {6'd1, 8'd23, 8'd0, 32'd102};//{'dest': 23, 'label': 102, 'op': 'jmp_and_link'}
    instructions[2845] = {6'd3, 8'd148, 8'd24, 32'd0};//{'dest': 148, 'src': 24, 'op': 'move'}
    instructions[2846] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2847] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2848] = {6'd3, 8'd141, 8'd148, 32'd0};//{'dest': 141, 'src': 148, 'op': 'move'}
    instructions[2849] = {6'd3, 8'd148, 8'd98, 32'd0};//{'dest': 148, 'src': 98, 'op': 'move'}
    instructions[2850] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2851] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2852] = {6'd13, 8'd0, 8'd148, 32'd2858};//{'src': 148, 'label': 2858, 'op': 'jmp_if_false'}
    instructions[2853] = {6'd3, 8'd148, 8'd146, 32'd0};//{'dest': 148, 'src': 146, 'op': 'move'}
    instructions[2854] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2855] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2856] = {6'd3, 8'd147, 8'd148, 32'd0};//{'dest': 147, 'src': 148, 'op': 'move'}
    instructions[2857] = {6'd15, 8'd0, 8'd0, 32'd2867};//{'label': 2867, 'op': 'goto'}
    instructions[2858] = {6'd3, 8'd148, 8'd136, 32'd0};//{'dest': 148, 'src': 136, 'op': 'move'}
    instructions[2859] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2860] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2861] = {6'd13, 8'd0, 8'd148, 32'd2867};//{'src': 148, 'label': 2867, 'op': 'jmp_if_false'}
    instructions[2862] = {6'd3, 8'd148, 8'd145, 32'd0};//{'dest': 148, 'src': 145, 'op': 'move'}
    instructions[2863] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2864] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2865] = {6'd3, 8'd147, 8'd148, 32'd0};//{'dest': 147, 'src': 148, 'op': 'move'}
    instructions[2866] = {6'd15, 8'd0, 8'd0, 32'd2867};//{'label': 2867, 'op': 'goto'}
    instructions[2867] = {6'd15, 8'd0, 8'd0, 32'd2957};//{'label': 2957, 'op': 'goto'}
    instructions[2868] = {6'd3, 8'd25, 8'd86, 32'd0};//{'dest': 25, 'src': 86, 'op': 'move'}
    instructions[2869] = {6'd3, 8'd26, 8'd96, 32'd0};//{'dest': 26, 'src': 96, 'op': 'move'}
    instructions[2870] = {6'd3, 8'd27, 8'd108, 32'd0};//{'dest': 27, 'src': 108, 'op': 'move'}
    instructions[2871] = {6'd1, 8'd23, 8'd0, 32'd102};//{'dest': 23, 'label': 102, 'op': 'jmp_and_link'}
    instructions[2872] = {6'd3, 8'd148, 8'd24, 32'd0};//{'dest': 148, 'src': 24, 'op': 'move'}
    instructions[2873] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2874] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2875] = {6'd3, 8'd141, 8'd148, 32'd0};//{'dest': 141, 'src': 148, 'op': 'move'}
    instructions[2876] = {6'd3, 8'd148, 8'd98, 32'd0};//{'dest': 148, 'src': 98, 'op': 'move'}
    instructions[2877] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2878] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2879] = {6'd13, 8'd0, 8'd148, 32'd2885};//{'src': 148, 'label': 2885, 'op': 'jmp_if_false'}
    instructions[2880] = {6'd3, 8'd148, 8'd146, 32'd0};//{'dest': 148, 'src': 146, 'op': 'move'}
    instructions[2881] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2882] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2883] = {6'd3, 8'd147, 8'd148, 32'd0};//{'dest': 147, 'src': 148, 'op': 'move'}
    instructions[2884] = {6'd15, 8'd0, 8'd0, 32'd2946};//{'label': 2946, 'op': 'goto'}
    instructions[2885] = {6'd3, 8'd148, 8'd101, 32'd0};//{'dest': 148, 'src': 101, 'op': 'move'}
    instructions[2886] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2887] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2888] = {6'd13, 8'd0, 8'd148, 32'd2912};//{'src': 148, 'label': 2912, 'op': 'jmp_if_false'}
    instructions[2889] = {6'd0, 8'd150, 8'd0, 32'd1};//{'dest': 150, 'literal': 1, 'op': 'literal'}
    instructions[2890] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2891] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2892] = {6'd11, 8'd151, 8'd150, 32'd85};//{'dest': 151, 'src': 150, 'srcb': 85, 'signed': False, 'op': '+'}
    instructions[2893] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2894] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2895] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17892704, 'op': 'memory_read_request'}
    instructions[2896] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2897] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17892704, 'op': 'memory_read_wait'}
    instructions[2898] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17892704, 'element_size': 2, 'op': 'memory_read'}
    instructions[2899] = {6'd0, 8'd151, 8'd0, 32'd1};//{'dest': 151, 'literal': 1, 'op': 'literal'}
    instructions[2900] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2901] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2902] = {6'd11, 8'd152, 8'd151, 32'd97};//{'dest': 152, 'src': 151, 'srcb': 97, 'signed': False, 'op': '+'}
    instructions[2903] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2904] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2905] = {6'd17, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 17892848, 'op': 'memory_read_request'}
    instructions[2906] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2907] = {6'd18, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 17892848, 'op': 'memory_read_wait'}
    instructions[2908] = {6'd19, 8'd150, 8'd152, 32'd0};//{'dest': 150, 'src': 152, 'sequence': 17892848, 'element_size': 2, 'op': 'memory_read'}
    instructions[2909] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2910] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2911] = {6'd28, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '=='}
    instructions[2912] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2913] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2914] = {6'd13, 8'd0, 8'd148, 32'd2938};//{'src': 148, 'label': 2938, 'op': 'jmp_if_false'}
    instructions[2915] = {6'd0, 8'd150, 8'd0, 32'd0};//{'dest': 150, 'literal': 0, 'op': 'literal'}
    instructions[2916] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2917] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2918] = {6'd11, 8'd151, 8'd150, 32'd85};//{'dest': 151, 'src': 150, 'srcb': 85, 'signed': False, 'op': '+'}
    instructions[2919] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2920] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2921] = {6'd17, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17893136, 'op': 'memory_read_request'}
    instructions[2922] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2923] = {6'd18, 8'd0, 8'd151, 32'd0};//{'element_size': 2, 'src': 151, 'sequence': 17893136, 'op': 'memory_read_wait'}
    instructions[2924] = {6'd19, 8'd149, 8'd151, 32'd0};//{'dest': 149, 'src': 151, 'sequence': 17893136, 'element_size': 2, 'op': 'memory_read'}
    instructions[2925] = {6'd0, 8'd151, 8'd0, 32'd0};//{'dest': 151, 'literal': 0, 'op': 'literal'}
    instructions[2926] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2927] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2928] = {6'd11, 8'd152, 8'd151, 32'd97};//{'dest': 152, 'src': 151, 'srcb': 97, 'signed': False, 'op': '+'}
    instructions[2929] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2930] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2931] = {6'd17, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 17893280, 'op': 'memory_read_request'}
    instructions[2932] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2933] = {6'd18, 8'd0, 8'd152, 32'd0};//{'element_size': 2, 'src': 152, 'sequence': 17893280, 'op': 'memory_read_wait'}
    instructions[2934] = {6'd19, 8'd150, 8'd152, 32'd0};//{'dest': 150, 'src': 152, 'sequence': 17893280, 'element_size': 2, 'op': 'memory_read'}
    instructions[2935] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2936] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2937] = {6'd28, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '=='}
    instructions[2938] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2939] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2940] = {6'd13, 8'd0, 8'd148, 32'd2946};//{'src': 148, 'label': 2946, 'op': 'jmp_if_false'}
    instructions[2941] = {6'd3, 8'd148, 8'd144, 32'd0};//{'dest': 148, 'src': 144, 'op': 'move'}
    instructions[2942] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2943] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2944] = {6'd3, 8'd147, 8'd148, 32'd0};//{'dest': 147, 'src': 148, 'op': 'move'}
    instructions[2945] = {6'd15, 8'd0, 8'd0, 32'd2946};//{'label': 2946, 'op': 'goto'}
    instructions[2946] = {6'd15, 8'd0, 8'd0, 32'd2957};//{'label': 2957, 'op': 'goto'}
    instructions[2947] = {6'd3, 8'd148, 8'd101, 32'd0};//{'dest': 148, 'src': 101, 'op': 'move'}
    instructions[2948] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2949] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2950] = {6'd13, 8'd0, 8'd148, 32'd2956};//{'src': 148, 'label': 2956, 'op': 'jmp_if_false'}
    instructions[2951] = {6'd3, 8'd148, 8'd142, 32'd0};//{'dest': 148, 'src': 142, 'op': 'move'}
    instructions[2952] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2953] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2954] = {6'd3, 8'd147, 8'd148, 32'd0};//{'dest': 147, 'src': 148, 'op': 'move'}
    instructions[2955] = {6'd15, 8'd0, 8'd0, 32'd2956};//{'label': 2956, 'op': 'goto'}
    instructions[2956] = {6'd15, 8'd0, 8'd0, 32'd2957};//{'label': 2957, 'op': 'goto'}
    instructions[2957] = {6'd3, 8'd148, 8'd100, 32'd0};//{'dest': 148, 'src': 100, 'op': 'move'}
    instructions[2958] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2959] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2960] = {6'd13, 8'd0, 8'd148, 32'd2966};//{'src': 148, 'label': 2966, 'op': 'jmp_if_false'}
    instructions[2961] = {6'd3, 8'd148, 8'd142, 32'd0};//{'dest': 148, 'src': 142, 'op': 'move'}
    instructions[2962] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2963] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2964] = {6'd3, 8'd147, 8'd148, 32'd0};//{'dest': 147, 'src': 148, 'op': 'move'}
    instructions[2965] = {6'd15, 8'd0, 8'd0, 32'd2966};//{'label': 2966, 'op': 'goto'}
    instructions[2966] = {6'd3, 8'd148, 8'd141, 32'd0};//{'dest': 148, 'src': 141, 'op': 'move'}
    instructions[2967] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2968] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2969] = {6'd13, 8'd0, 8'd148, 32'd2987};//{'src': 148, 'label': 2987, 'op': 'jmp_if_false'}
    instructions[2970] = {6'd3, 8'd120, 8'd133, 32'd0};//{'dest': 120, 'src': 133, 'op': 'move'}
    instructions[2971] = {6'd3, 8'd121, 8'd109, 32'd0};//{'dest': 121, 'src': 109, 'op': 'move'}
    instructions[2972] = {6'd3, 8'd122, 8'd108, 32'd0};//{'dest': 122, 'src': 108, 'op': 'move'}
    instructions[2973] = {6'd1, 8'd119, 8'd0, 32'd2331};//{'dest': 119, 'label': 2331, 'op': 'jmp_and_link'}
    instructions[2974] = {6'd3, 8'd149, 8'd147, 32'd0};//{'dest': 149, 'src': 147, 'op': 'move'}
    instructions[2975] = {6'd3, 8'd150, 8'd140, 32'd0};//{'dest': 150, 'src': 140, 'op': 'move'}
    instructions[2976] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2977] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2978] = {6'd28, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '=='}
    instructions[2979] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2980] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2981] = {6'd13, 8'd0, 8'd148, 32'd2986};//{'src': 148, 'label': 2986, 'op': 'jmp_if_false'}
    instructions[2982] = {6'd3, 8'd103, 8'd134, 32'd0};//{'dest': 103, 'src': 134, 'op': 'move'}
    instructions[2983] = {6'd3, 8'd104, 8'd136, 32'd0};//{'dest': 104, 'src': 136, 'op': 'move'}
    instructions[2984] = {6'd1, 8'd102, 8'd0, 32'd1565};//{'dest': 102, 'label': 1565, 'op': 'jmp_and_link'}
    instructions[2985] = {6'd15, 8'd0, 8'd0, 32'd2986};//{'label': 2986, 'op': 'goto'}
    instructions[2986] = {6'd15, 8'd0, 8'd0, 32'd2987};//{'label': 2987, 'op': 'goto'}
    instructions[2987] = {6'd3, 8'd149, 8'd147, 32'd0};//{'dest': 149, 'src': 147, 'op': 'move'}
    instructions[2988] = {6'd3, 8'd150, 8'd144, 32'd0};//{'dest': 150, 'src': 144, 'op': 'move'}
    instructions[2989] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2990] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2991] = {6'd28, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '=='}
    instructions[2992] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2993] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2994] = {6'd13, 8'd0, 8'd148, 32'd2996};//{'src': 148, 'label': 2996, 'op': 'jmp_if_false'}
    instructions[2995] = {6'd37, 8'd148, 8'd0, 32'd0};//{'dest': 148, 'input': 'socket', 'op': 'ready'}
    instructions[2996] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2997] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[2998] = {6'd13, 8'd0, 8'd148, 32'd3001};//{'src': 148, 'label': 3001, 'op': 'jmp_if_false'}
    instructions[2999] = {6'd15, 8'd0, 8'd0, 32'd3023};//{'label': 3023, 'op': 'goto'}
    instructions[3000] = {6'd15, 8'd0, 8'd0, 32'd3001};//{'label': 3001, 'op': 'goto'}
    instructions[3001] = {6'd3, 8'd149, 8'd147, 32'd0};//{'dest': 149, 'src': 147, 'op': 'move'}
    instructions[3002] = {6'd3, 8'd150, 8'd140, 32'd0};//{'dest': 150, 'src': 140, 'op': 'move'}
    instructions[3003] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[3004] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[3005] = {6'd21, 8'd148, 8'd149, 32'd150};//{'dest': 148, 'src': 149, 'srcb': 150, 'signed': False, 'op': '!='}
    instructions[3006] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[3007] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[3008] = {6'd13, 8'd0, 8'd148, 32'd3015};//{'src': 148, 'label': 3015, 'op': 'jmp_if_false'}
    instructions[3009] = {6'd0, 8'd148, 8'd0, 32'd120};//{'dest': 148, 'literal': 120, 'op': 'literal'}
    instructions[3010] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[3011] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[3012] = {6'd3, 8'd137, 8'd148, 32'd0};//{'dest': 137, 'src': 148, 'op': 'move'}
    instructions[3013] = {6'd15, 8'd0, 8'd0, 32'd3023};//{'label': 3023, 'op': 'goto'}
    instructions[3014] = {6'd15, 8'd0, 8'd0, 32'd3015};//{'label': 3015, 'op': 'goto'}
    instructions[3015] = {6'd15, 8'd0, 8'd0, 32'd3020};//{'label': 3020, 'op': 'goto'}
    instructions[3016] = {6'd0, 8'd148, 8'd0, 32'd10000};//{'dest': 148, 'literal': 10000, 'op': 'literal'}
    instructions[3017] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[3018] = {6'd4, 8'd0, 8'd0, 32'd0};//{'op': 'nop'}
    instructions[3019] = {6'd39, 8'd0, 8'd148, 32'd0};//{'src': 148, 'op': 'wait_clocks'}
    instructions[3020] = {6'd3, 8'd148, 8'd138, 32'd0};//{'dest': 148, 'src': 138, 'op': 'move'}
    instructions[3021] = {6'd34, 8'd138, 8'd138, 32'd1};//{'dest': 138, 'src': 138, 'right': 1, 'signed': False, 'op': '-'}
    instructions[3022] = {6'd15, 8'd0, 8'd0, 32'd2671};//{'label': 2671, 'op': 'goto'}
    instructions[3023] = {6'd15, 8'd0, 8'd0, 32'd2463};//{'label': 2463, 'op': 'goto'}
    instructions[3024] = {6'd6, 8'd0, 8'd132, 32'd0};//{'src': 132, 'op': 'jmp_to_reg'}
  end


  //////////////////////////////////////////////////////////////////////////////
  // CPU IMPLEMENTAION OF C PROCESS                                             
  //                                                                            
  // This section of the file contains a CPU implementing the C process.        
  
  always @(posedge clk)
  begin

    //implement memory for 2 byte x n arrays
    if (memory_enable_2 == 1'b1) begin
      memory_2[address_2] <= data_in_2;
    end
    data_out_2 <= memory_2[address_2];
    memory_enable_2 <= 1'b0;

    write_enable_2 <= 0;
    //stage 0 instruction fetch
    if (stage_0_enable) begin
      stage_1_enable <= 1;
      instruction_0 <= instructions[program_counter];
      opcode_0 = instruction_0[53:48];
      dest_0 = instruction_0[47:40];
      src_0 = instruction_0[39:32];
      srcb_0 = instruction_0[7:0];
      literal_0 = instruction_0[31:0];
      if(write_enable_2) begin
        registers[dest_2] <= result_2;
      end
      program_counter_0 <= program_counter;
      program_counter <= program_counter + 1;
    end

    //stage 1 opcode fetch
    if (stage_1_enable) begin
      stage_2_enable <= 1;
      register_1 <= registers[src_0];
      registerb_1 <= registers[srcb_0];
      dest_1 <= dest_0;
      literal_1 <= literal_0;
      opcode_1 <= opcode_0;
      program_counter_1 <= program_counter_0;
    end

    //stage 2 opcode fetch
    if (stage_2_enable) begin
      dest_2 <= dest_1;
      case(opcode_1)

        16'd0:
        begin
          result_2 <= literal_1;
          write_enable_2 <= 1;
        end

        16'd1:
        begin
          program_counter <= literal_1;
          result_2 <= program_counter_1 + 1;
          write_enable_2 <= 1;
          stage_0_enable <= 1;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
        end

        16'd2:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
        end

        16'd3:
        begin
          result_2 <= register_1;
          write_enable_2 <= 1;
        end

        16'd5:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
          s_output_eth_tx_stb <= 1'b1;
          s_output_eth_tx <= register_1;
        end

        16'd6:
        begin
          program_counter <= register_1;
          stage_0_enable <= 1;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
        end

        16'd7:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
          s_output_socket_stb <= 1'b1;
          s_output_socket <= register_1;
        end

        16'd8:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
          s_input_eth_rx_ack <= 1'b1;
        end

        16'd9:
        begin
          result_2 <= 0;
          result_2[0] <= input_eth_rx_stb;
          write_enable_2 <= 1;
        end

        16'd10:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
          s_input_socket_ack <= 1'b1;
        end

        16'd11:
        begin
          result_2 <= $unsigned(register_1) + $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd12:
        begin
          result_2 <= $unsigned(register_1) & $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd13:
        begin
          if (register_1 == 0) begin
            program_counter <= literal_1;
            stage_0_enable <= 1;
            stage_1_enable <= 0;
            stage_2_enable <= 0;
          end
        end

        16'd14:
        begin
          result_2 <= $unsigned(register_1) + $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd15:
        begin
          program_counter <= literal_1;
          stage_0_enable <= 1;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
        end

        16'd16:
        begin
          result_2 <= ~register_1;
          write_enable_2 <= 1;
        end

        16'd17:
        begin
          address_2 <= register_1;
        end

        16'd19:
        begin
          result_2 <= data_out_2;
          write_enable_2 <= 1;
        end

        16'd20:
        begin
          result_2 <= $unsigned(register_1) < $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd21:
        begin
          result_2 <= $unsigned(register_1) != $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd22:
        begin
          if (register_1 != 0) begin
            program_counter <= literal_1;
            stage_0_enable <= 1;
            stage_1_enable <= 0;
            stage_2_enable <= 0;
          end
        end

        16'd23:
        begin
          address_2 <= register_1;
          data_in_2 <= registerb_1;
          memory_enable_2 <= 1'b1;
        end

        16'd24:
        begin
          $display ("%d (report at line: 107 in file: /media/sdb1/Projects/Chips-Demo/source/server.h)", $unsigned(register_1));
        end

        16'd25:
        begin
          result_2 <= $unsigned(register_1) == $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd26:
        begin
          result_2 <= $unsigned(register_1) != $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd27:
        begin
          result_2 <= $unsigned(register_1) < $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd28:
        begin
          result_2 <= $unsigned(register_1) == $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd29:
        begin
          result_2 <= $unsigned(literal_1) | $unsigned(register_1);
          write_enable_2 <= 1;
        end

        16'd30:
        begin
          result_2 <= $unsigned(register_1) <= $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd31:
        begin
          result_2 <= $unsigned(register_1) >> $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd32:
        begin
          result_2 <= $unsigned(register_1) << $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd33:
        begin
          result_2 <= $unsigned(register_1) - $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd34:
        begin
          result_2 <= $unsigned(register_1) - $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd35:
        begin
          result_2 <= $unsigned(register_1) <= $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd36:
        begin
          result_2 <= $unsigned(register_1) | $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd37:
        begin
          result_2 <= 0;
          result_2[0] <= input_socket_stb;
          write_enable_2 <= 1;
        end

        16'd38:
        begin
          result_2 <= $signed(register_1) == $signed(literal_1);
          write_enable_2 <= 1;
        end

        16'd39:
        begin
          timer <= register_1;
          timer_enable <= 1;
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
        end

       endcase
    end
     if (s_output_eth_tx_stb == 1'b1 && output_eth_tx_ack == 1'b1) begin
       s_output_eth_tx_stb <= 1'b0;
       stage_0_enable <= 1;
       stage_1_enable <= 1;
       stage_2_enable <= 1;
     end

     if (s_output_socket_stb == 1'b1 && output_socket_ack == 1'b1) begin
       s_output_socket_stb <= 1'b0;
       stage_0_enable <= 1;
       stage_1_enable <= 1;
       stage_2_enable <= 1;
     end

    if (s_input_eth_rx_ack == 1'b1 && input_eth_rx_stb == 1'b1) begin
       result_2 <= input_eth_rx;
       write_enable_2 <= 1;
       s_input_eth_rx_ack <= 1'b0;
       stage_0_enable <= 1;
       stage_1_enable <= 1;
       stage_2_enable <= 1;
     end

    if (s_input_socket_ack == 1'b1 && input_socket_stb == 1'b1) begin
       result_2 <= input_socket;
       write_enable_2 <= 1;
       s_input_socket_ack <= 1'b0;
       stage_0_enable <= 1;
       stage_1_enable <= 1;
       stage_2_enable <= 1;
     end

    if (timer == 0) begin
      if (timer_enable) begin
         stage_0_enable <= 1;
         stage_1_enable <= 1;
         stage_2_enable <= 1;
         timer_enable <= 0;
      end
    end else begin
      timer <= timer - 1;
    end

    if (rst == 1'b1) begin
      stage_0_enable <= 1;
      stage_1_enable <= 0;
      stage_2_enable <= 0;
      timer <= 0;
      timer_enable <= 0;
      program_counter <= 0;
      s_input_eth_rx_ack <= 0;
      s_input_socket_ack <= 0;
      s_output_socket_stb <= 0;
      s_output_eth_tx_stb <= 0;
    end
  end
  assign input_eth_rx_ack = s_input_eth_rx_ack;
  assign input_socket_ack = s_input_socket_ack;
  assign output_socket_stb = s_output_socket_stb;
  assign output_socket = s_output_socket;
  assign output_eth_tx_stb = s_output_eth_tx_stb;
  assign output_eth_tx = s_output_eth_tx;

endmodule
