//////////////////////////////////////////////////////////////////////////////
//name : user_design
//input : input_switches:16
//input : input_buttons:16
//input : input_socket:16
//input : input_rs232_rx:16
//output : output_rs232_tx:16
//output : output_leds:16
//output : output_socket:16
//source_file : ../source/user_design.c
///===========
///
///Created by C2CHIP

//////////////////////////////////////////////////////////////////////////////
// Register Allocation
// ===================
//         Register                 Name                   Size          
//            0             HTTP_OK return address            2            
//            1                    array                    2            
//            2             variable header_length            2            
//            3             variable body_length            2            
//            4               variable length               2            
//            5                variable index               2            
//            6             variable packet_count            2            
//            7                    array                    2            
//            8                    array                    2            
//            9             find return address             2            
//            10            variable find return value            2            
//            11                   array                    2            
//            12              variable search               2            
//            13               variable start               2            
//            14                variable end                2            
//            15               variable value               2            
//            16                   array                    2            
//            17                   array                    2            
//            18            user_design return address            2            
//            19              variable length               2            
//            20                 variable i                 2            
//            21               variable index               2            
//            22                   array                    2            
//            23               variable word                2            
//            24             variable switches              2            
//            25              variable buttons              2            
//            26               variable leds                2            
//            27               variable start               2            
//            28                variable end                2            
//            29                   array                    2            
//            30                   array                    2            
//            31                   array                    2            
//            32             temporary_register             2            
//            33             temporary_register             2            
//            34             temporary_register             2            
//            35             temporary_register             4            
//            36             temporary_register             2            
//            37             temporary_register            252           
//            38             temporary_register            228           
//            39             temporary_register             10           
//            40             temporary_register             76           
//            41             temporary_register             82           
//            42             temporary_register             2            
//            43             temporary_register            2920          
//            44             temporary_register            1760          
//            45            put_socket return address            2            
//            46                 variable i                 2            
//            47            stdout_put_char return address            2            
//            48                 variable i                 2            
//            49            print_string return address            2            
//            50                   array                    2            
//            51                 variable i                 2            
//            52            print_udecimal return address            2            
//            53             variable udecimal              2            
//            54               variable digit               2            
//            55            variable significant            2            
//            56            print_decimal return address            2            
//            57              variable decimal              2            
//            58            variable socket_high            2            
//            59            variable socket_data            2            
//            60            socket_put_char return address            2            
//            61                 variable x                 2            
//            62            socket_flush return address            2            
//            63            socket_put_string return address            2            
//            64                   array                    2            
//            65                 variable i                 2            
//            66            socket_put_decimal return address            2            
//            67               variable value               2            
//            68              variable digit_0              2            
//            69              variable digit_1              2            
//            70              variable digit_2              2            
//            71              variable digit_3              2            
//            72              variable digit_4              2            
//            73            variable significant            2            
//            74            HTTP_Not_Found return address            2            
//            75            variable header_length            2            
//            76                   array                    2            
module user_design(input_switches,input_buttons,input_socket,input_rs232_rx,input_switches_stb,input_buttons_stb,input_socket_stb,input_rs232_rx_stb,output_rs232_tx_ack,output_leds_ack,output_socket_ack,clk,rst,output_rs232_tx,output_leds,output_socket,output_rs232_tx_stb,output_leds_stb,output_socket_stb,input_switches_ack,input_buttons_ack,input_socket_ack,input_rs232_rx_ack);
  integer file_count;
  real fp_value;
  input [15:0] input_switches;
  input [15:0] input_buttons;
  input [15:0] input_socket;
  input [15:0] input_rs232_rx;
  input input_switches_stb;
  input input_buttons_stb;
  input input_socket_stb;
  input input_rs232_rx_stb;
  input output_rs232_tx_ack;
  input output_leds_ack;
  input output_socket_ack;
  input clk;
  input rst;
  output [15:0] output_rs232_tx;
  output [15:0] output_leds;
  output [15:0] output_socket;
  output output_rs232_tx_stb;
  output output_leds_stb;
  output output_socket_stb;
  output input_switches_ack;
  output input_buttons_ack;
  output input_socket_ack;
  output input_rs232_rx_ack;
  reg [15:0] timer;
  reg timer_enable;
  reg stage_0_enable;
  reg stage_1_enable;
  reg stage_2_enable;
  reg [10:0] program_counter;
  reg [10:0] program_counter_0;
  reg [51:0] instruction_0;
  reg [5:0] opcode_0;
  reg [6:0] dest_0;
  reg [6:0] src_0;
  reg [6:0] srcb_0;
  reg [31:0] literal_0;
  reg [10:0] program_counter_1;
  reg [5:0] opcode_1;
  reg [6:0] dest_1;
  reg [31:0] register_1;
  reg [31:0] registerb_1;
  reg [31:0] literal_1;
  reg [6:0] dest_2;
  reg [31:0] result_2;
  reg write_enable_2;
  reg [15:0] address_2;
  reg [15:0] data_out_2;
  reg [15:0] data_in_2;
  reg memory_enable_2;
  reg [15:0] address_4;
  reg [31:0] data_out_4;
  reg [31:0] data_in_4;
  reg memory_enable_4;
  reg [15:0] s_output_rs232_tx_stb;
  reg [15:0] s_output_leds_stb;
  reg [15:0] s_output_socket_stb;
  reg [15:0] s_output_rs232_tx;
  reg [15:0] s_output_leds;
  reg [15:0] s_output_socket;
  reg [15:0] s_input_switches_ack;
  reg [15:0] s_input_buttons_ack;
  reg [15:0] s_input_socket_ack;
  reg [15:0] s_input_rs232_rx_ack;
  reg [15:0] memory_2 [2675:0];
  reg [51:0] instructions [1821:0];
  reg [31:0] registers [76:0];

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
    memory_2[2048] = 98;
    memory_2[2049] = 111;
    memory_2[2050] = 120;
    memory_2[2051] = 34;
    memory_2[4] = 72;
    memory_2[5] = 84;
    memory_2[6] = 84;
    memory_2[7] = 80;
    memory_2[8] = 47;
    memory_2[9] = 49;
    memory_2[10] = 46;
    memory_2[11] = 49;
    memory_2[12] = 32;
    memory_2[13] = 52;
    memory_2[14] = 48;
    memory_2[15] = 52;
    memory_2[16] = 32;
    memory_2[17] = 78;
    memory_2[18] = 111;
    memory_2[19] = 116;
    memory_2[20] = 32;
    memory_2[21] = 70;
    memory_2[22] = 111;
    memory_2[23] = 117;
    memory_2[24] = 110;
    memory_2[25] = 100;
    memory_2[26] = 13;
    memory_2[27] = 10;
    memory_2[28] = 68;
    memory_2[29] = 97;
    memory_2[30] = 116;
    memory_2[31] = 101;
    memory_2[32] = 58;
    memory_2[33] = 32;
    memory_2[34] = 84;
    memory_2[35] = 104;
    memory_2[36] = 117;
    memory_2[37] = 32;
    memory_2[38] = 79;
    memory_2[39] = 99;
    memory_2[40] = 116;
    memory_2[41] = 32;
    memory_2[42] = 51;
    memory_2[43] = 49;
    memory_2[44] = 32;
    memory_2[45] = 49;
    memory_2[46] = 57;
    memory_2[47] = 58;
    memory_2[48] = 49;
    memory_2[49] = 54;
    memory_2[50] = 58;
    memory_2[51] = 48;
    memory_2[52] = 48;
    memory_2[53] = 32;
    memory_2[54] = 50;
    memory_2[55] = 48;
    memory_2[56] = 49;
    memory_2[57] = 51;
    memory_2[58] = 13;
    memory_2[59] = 10;
    memory_2[60] = 83;
    memory_2[61] = 101;
    memory_2[62] = 114;
    memory_2[63] = 118;
    memory_2[64] = 101;
    memory_2[65] = 114;
    memory_2[66] = 58;
    memory_2[67] = 32;
    memory_2[68] = 99;
    memory_2[69] = 104;
    memory_2[70] = 105;
    memory_2[71] = 112;
    memory_2[72] = 115;
    memory_2[73] = 45;
    memory_2[74] = 119;
    memory_2[75] = 101;
    memory_2[76] = 98;
    memory_2[77] = 47;
    memory_2[78] = 48;
    memory_2[79] = 46;
    memory_2[80] = 48;
    memory_2[81] = 13;
    memory_2[82] = 10;
    memory_2[83] = 67;
    memory_2[84] = 111;
    memory_2[85] = 110;
    memory_2[86] = 116;
    memory_2[87] = 101;
    memory_2[88] = 110;
    memory_2[89] = 116;
    memory_2[90] = 45;
    memory_2[91] = 84;
    memory_2[92] = 121;
    memory_2[93] = 112;
    memory_2[94] = 101;
    memory_2[95] = 58;
    memory_2[96] = 32;
    memory_2[97] = 116;
    memory_2[98] = 101;
    memory_2[99] = 120;
    memory_2[100] = 116;
    memory_2[101] = 47;
    memory_2[102] = 104;
    memory_2[103] = 116;
    memory_2[104] = 109;
    memory_2[105] = 108;
    memory_2[106] = 13;
    memory_2[107] = 10;
    memory_2[108] = 67;
    memory_2[109] = 111;
    memory_2[110] = 110;
    memory_2[111] = 116;
    memory_2[112] = 101;
    memory_2[113] = 110;
    memory_2[114] = 116;
    memory_2[115] = 45;
    memory_2[116] = 76;
    memory_2[117] = 101;
    memory_2[118] = 110;
    memory_2[119] = 103;
    memory_2[120] = 116;
    memory_2[121] = 104;
    memory_2[122] = 58;
    memory_2[123] = 32;
    memory_2[124] = 48;
    memory_2[125] = 13;
    memory_2[126] = 10;
    memory_2[127] = 13;
    memory_2[128] = 10;
    memory_2[129] = 0;
    memory_2[2178] = 101;
    memory_2[2179] = 100;
    memory_2[132] = 72;
    memory_2[133] = 84;
    memory_2[134] = 84;
    memory_2[135] = 80;
    memory_2[136] = 47;
    memory_2[137] = 49;
    memory_2[138] = 46;
    memory_2[139] = 49;
    memory_2[140] = 32;
    memory_2[141] = 50;
    memory_2[142] = 48;
    memory_2[143] = 48;
    memory_2[144] = 32;
    memory_2[145] = 79;
    memory_2[146] = 75;
    memory_2[147] = 13;
    memory_2[148] = 10;
    memory_2[149] = 68;
    memory_2[150] = 97;
    memory_2[151] = 116;
    memory_2[152] = 101;
    memory_2[153] = 58;
    memory_2[154] = 32;
    memory_2[155] = 84;
    memory_2[156] = 104;
    memory_2[157] = 117;
    memory_2[158] = 32;
    memory_2[159] = 79;
    memory_2[160] = 99;
    memory_2[161] = 116;
    memory_2[162] = 32;
    memory_2[163] = 51;
    memory_2[164] = 49;
    memory_2[165] = 32;
    memory_2[166] = 49;
    memory_2[167] = 57;
    memory_2[168] = 58;
    memory_2[169] = 49;
    memory_2[170] = 54;
    memory_2[171] = 58;
    memory_2[172] = 48;
    memory_2[173] = 48;
    memory_2[174] = 32;
    memory_2[175] = 50;
    memory_2[176] = 48;
    memory_2[177] = 49;
    memory_2[178] = 51;
    memory_2[179] = 13;
    memory_2[180] = 10;
    memory_2[181] = 83;
    memory_2[182] = 101;
    memory_2[183] = 114;
    memory_2[184] = 118;
    memory_2[185] = 101;
    memory_2[186] = 114;
    memory_2[187] = 58;
    memory_2[188] = 32;
    memory_2[189] = 99;
    memory_2[190] = 104;
    memory_2[191] = 105;
    memory_2[192] = 112;
    memory_2[193] = 115;
    memory_2[194] = 45;
    memory_2[195] = 119;
    memory_2[196] = 101;
    memory_2[197] = 98;
    memory_2[198] = 47;
    memory_2[199] = 48;
    memory_2[200] = 46;
    memory_2[201] = 48;
    memory_2[202] = 13;
    memory_2[203] = 10;
    memory_2[204] = 67;
    memory_2[205] = 111;
    memory_2[206] = 110;
    memory_2[207] = 116;
    memory_2[208] = 101;
    memory_2[209] = 110;
    memory_2[210] = 116;
    memory_2[211] = 45;
    memory_2[212] = 84;
    memory_2[213] = 121;
    memory_2[214] = 112;
    memory_2[215] = 101;
    memory_2[216] = 58;
    memory_2[217] = 32;
    memory_2[218] = 116;
    memory_2[219] = 101;
    memory_2[220] = 120;
    memory_2[221] = 116;
    memory_2[222] = 47;
    memory_2[223] = 104;
    memory_2[224] = 116;
    memory_2[225] = 109;
    memory_2[226] = 108;
    memory_2[227] = 13;
    memory_2[228] = 10;
    memory_2[229] = 67;
    memory_2[230] = 111;
    memory_2[231] = 110;
    memory_2[232] = 116;
    memory_2[233] = 101;
    memory_2[234] = 110;
    memory_2[235] = 116;
    memory_2[236] = 45;
    memory_2[237] = 76;
    memory_2[238] = 101;
    memory_2[239] = 110;
    memory_2[240] = 103;
    memory_2[241] = 116;
    memory_2[242] = 104;
    memory_2[243] = 58;
    memory_2[244] = 32;
    memory_2[245] = 0;
    memory_2[246] = 13;
    memory_2[247] = 10;
    memory_2[248] = 13;
    memory_2[249] = 10;
    memory_2[250] = 0;
    memory_2[2299] = 34;
    memory_2[2300] = 32;
    memory_2[253] = 10;
    memory_2[254] = 0;
    memory_2[255] = 10;
    memory_2[256] = 0;
    memory_2[2305] = 101;
    memory_2[2306] = 61;
    memory_2[2091] = 110;
    memory_2[2308] = 71;
    memory_2[2309] = 34;
    memory_2[2310] = 62;
    memory_2[2311] = 108;
    memory_2[2312] = 101;
    memory_2[2092] = 112;
    memory_2[2314] = 32;
    memory_2[2315] = 54;
    memory_2[2316] = 60;
    memory_2[2317] = 47;
    memory_2[2318] = 105;
    memory_2[2093] = 117;
    memory_2[2320] = 112;
    memory_2[2321] = 117;
    memory_2[2322] = 116;
    memory_2[2323] = 62;
    memory_2[2324] = 9;
    memory_2[2094] = 116;
    memory_2[2326] = 105;
    memory_2[2327] = 110;
    memory_2[2055] = 109;
    memory_2[2329] = 117;
    memory_2[2330] = 116;
    memory_2[2095] = 32;
    memory_2[2332] = 116;
    memory_2[2333] = 121;
    memory_2[2334] = 112;
    memory_2[2335] = 101;
    memory_2[2336] = 61;
    memory_2[2096] = 116;
    memory_2[2338] = 99;
    memory_2[2339] = 104;
    memory_2[2340] = 101;
    memory_2[2341] = 99;
    memory_2[2342] = 107;
    memory_2[2097] = 121;
    memory_2[2344] = 111;
    memory_2[2345] = 120;
    memory_2[2346] = 34;
    memory_2[2347] = 32;
    memory_2[2348] = 110;
    memory_2[2098] = 112;
    memory_2[2350] = 109;
    memory_2[2351] = 101;
    memory_2[2352] = 61;
    memory_2[2353] = 34;
    memory_2[2354] = 108;
    memory_2[2099] = 101;
    memory_2[2356] = 100;
    memory_2[2357] = 52;
    memory_2[2056] = 101;
    memory_2[2359] = 32;
    memory_2[2360] = 118;
    memory_2[2100] = 61;
    memory_2[2362] = 108;
    memory_2[2363] = 117;
    memory_2[2364] = 101;
    memory_2[2365] = 61;
    memory_2[2366] = 34;
    memory_2[2101] = 34;
    memory_2[2368] = 34;
    memory_2[2369] = 62;
    memory_2[2370] = 108;
    memory_2[2371] = 101;
    memory_2[2372] = 100;
    memory_2[2102] = 99;
    memory_2[2374] = 55;
    memory_2[2375] = 60;
    memory_2[2376] = 47;
    memory_2[2377] = 105;
    memory_2[2378] = 110;
    memory_2[2103] = 104;
    memory_2[2380] = 117;
    memory_2[2381] = 116;
    memory_2[2382] = 62;
    memory_2[2383] = 9;
    memory_2[2384] = 60;
    memory_2[2104] = 101;
    memory_2[2386] = 117;
    memory_2[2387] = 116;
    memory_2[2057] = 61;
    memory_2[2389] = 111;
    memory_2[2390] = 110;
    memory_2[2105] = 99;
    memory_2[2392] = 116;
    memory_2[2393] = 121;
    memory_2[2394] = 112;
    memory_2[2395] = 101;
    memory_2[2396] = 61;
    memory_2[2106] = 107;
    memory_2[2398] = 115;
    memory_2[2399] = 117;
    memory_2[2400] = 109;
    memory_2[2401] = 98;
    memory_2[2402] = 105;
    memory_2[2107] = 98;
    memory_2[2404] = 34;
    memory_2[2405] = 32;
    memory_2[2406] = 118;
    memory_2[2407] = 97;
    memory_2[2408] = 108;
    memory_2[2108] = 111;
    memory_2[2410] = 101;
    memory_2[2411] = 61;
    memory_2[2412] = 34;
    memory_2[2413] = 83;
    memory_2[2414] = 117;
    memory_2[2109] = 120;
    memory_2[2416] = 109;
    memory_2[2417] = 105;
    memory_2[2058] = 34;
    memory_2[2419] = 34;
    memory_2[2420] = 62;
    memory_2[2110] = 34;
    memory_2[2422] = 112;
    memory_2[2423] = 100;
    memory_2[2424] = 97;
    memory_2[2425] = 116;
    memory_2[2426] = 101;
    memory_2[2111] = 32;
    memory_2[2428] = 76;
    memory_2[2429] = 69;
    memory_2[2430] = 68;
    memory_2[2431] = 115;
    memory_2[2432] = 60;
    memory_2[2112] = 110;
    memory_2[2434] = 98;
    memory_2[2435] = 117;
    memory_2[2436] = 116;
    memory_2[2437] = 116;
    memory_2[2438] = 111;
    memory_2[2113] = 97;
    memory_2[2440] = 62;
    memory_2[2441] = 60;
    memory_2[2442] = 47;
    memory_2[2443] = 102;
    memory_2[2444] = 111;
    memory_2[2114] = 109;
    memory_2[2446] = 109;
    memory_2[2447] = 62;
    memory_2[2059] = 108;
    memory_2[2449] = 112;
    memory_2[2450] = 62;
    memory_2[2115] = 101;
    memory_2[2452] = 104;
    memory_2[2453] = 105;
    memory_2[2454] = 115;
    memory_2[2455] = 32;
    memory_2[2456] = 60;
    memory_2[2116] = 61;
    memory_2[2379] = 112;
    memory_2[2459] = 104;
    memory_2[2460] = 114;
    memory_2[2458] = 32;
    memory_2[2462] = 102;
    memory_2[2117] = 34;
    memory_2[2464] = 34;
    memory_2[2465] = 104;
    memory_2[2466] = 116;
    memory_2[2467] = 116;
    memory_2[2468] = 112;
    memory_2[2118] = 108;
    memory_2[2470] = 58;
    memory_2[2471] = 47;
    memory_2[2472] = 47;
    memory_2[2473] = 103;
    memory_2[2474] = 105;
    memory_2[2119] = 101;
    memory_2[2476] = 104;
    memory_2[2477] = 117;
    memory_2[2060] = 101;
    memory_2[2461] = 101;
    memory_2[2480] = 99;
    memory_2[2120] = 100;
    memory_2[2482] = 109;
    memory_2[2483] = 47;
    memory_2[2484] = 100;
    memory_2[2485] = 97;
    memory_2[2486] = 119;
    memory_2[2121] = 52;
    memory_2[2488] = 111;
    memory_2[2489] = 110;
    memory_2[2490] = 106;
    memory_2[2463] = 61;
    memory_2[2492] = 110;
    memory_2[2122] = 34;
    memory_2[2494] = 67;
    memory_2[2495] = 104;
    memory_2[2496] = 105;
    memory_2[2497] = 112;
    memory_2[2498] = 115;
    memory_2[2123] = 32;
    memory_2[2500] = 68;
    memory_2[2501] = 101;
    memory_2[2502] = 109;
    memory_2[2503] = 111;
    memory_2[2504] = 34;
    memory_2[2124] = 118;
    memory_2[2506] = 112;
    memory_2[2507] = 114;
    memory_2[2061] = 100;
    memory_2[2509] = 106;
    memory_2[2510] = 101;
    memory_2[2125] = 97;
    memory_2[2512] = 116;
    memory_2[2513] = 60;
    memory_2[2514] = 47;
    memory_2[2515] = 97;
    memory_2[2516] = 62;
    memory_2[2126] = 108;
    memory_2[2518] = 105;
    memory_2[2519] = 115;
    memory_2[2520] = 32;
    memory_2[2521] = 112;
    memory_2[2522] = 111;
    memory_2[2127] = 117;
    memory_2[2524] = 101;
    memory_2[2525] = 114;
    memory_2[2526] = 101;
    memory_2[2469] = 115;
    memory_2[2528] = 32;
    memory_2[2128] = 101;
    memory_2[2530] = 121;
    memory_2[2531] = 32;
    memory_2[2532] = 60;
    memory_2[2533] = 97;
    memory_2[2534] = 32;
    memory_2[2129] = 61;
    memory_2[2536] = 114;
    memory_2[2537] = 101;
    memory_2[2062] = 51;
    memory_2[2403] = 116;
    memory_2[2540] = 34;
    memory_2[2130] = 34;
    memory_2[2542] = 116;
    memory_2[2543] = 116;
    memory_2[2544] = 112;
    memory_2[2545] = 58;
    memory_2[2546] = 47;
    memory_2[2131] = 68;
    memory_2[2548] = 112;
    memory_2[2549] = 121;
    memory_2[2550] = 97;
    memory_2[2551] = 110;
    memory_2[2552] = 100;
    memory_2[2132] = 34;
    memory_2[2554] = 104;
    memory_2[2555] = 105;
    memory_2[2556] = 112;
    memory_2[2557] = 115;
    memory_2[2558] = 46;
    memory_2[2133] = 62;
    memory_2[2560] = 114;
    memory_2[2561] = 103;
    memory_2[2562] = 34;
    memory_2[2475] = 116;
    memory_2[2564] = 67;
    memory_2[2134] = 108;
    memory_2[2566] = 105;
    memory_2[2567] = 112;
    memory_2[2063] = 34;
    memory_2[2569] = 45;
    memory_2[2570] = 50;
    memory_2[2135] = 101;
    memory_2[2572] = 48;
    memory_2[2573] = 60;
    memory_2[2574] = 47;
    memory_2[2575] = 97;
    memory_2[2576] = 62;
    memory_2[2136] = 100;
    memory_2[2578] = 60;
    memory_2[2579] = 47;
    memory_2[2580] = 112;
    memory_2[2478] = 98;
    memory_2[2582] = 60;
    memory_2[2137] = 32;
    memory_2[2584] = 98;
    memory_2[2585] = 111;
    memory_2[2586] = 100;
    memory_2[2479] = 46;
    memory_2[2588] = 62;
    memory_2[2138] = 51;
    memory_2[2590] = 47;
    memory_2[2591] = 104;
    memory_2[2592] = 116;
    memory_2[2593] = 109;
    memory_2[2594] = 108;
    memory_2[2139] = 60;
    memory_2[2596] = 0;
    memory_2[2597] = 87;
    memory_2[2064] = 32;
    memory_2[2481] = 111;
    memory_2[2600] = 99;
    memory_2[2140] = 47;
    memory_2[2602] = 109;
    memory_2[2603] = 101;
    memory_2[2604] = 32;
    memory_2[2337] = 34;
    memory_2[2606] = 111;
    memory_2[2141] = 105;
    memory_2[2608] = 116;
    memory_2[2609] = 104;
    memory_2[2610] = 101;
    memory_2[2611] = 32;
    memory_2[2612] = 65;
    memory_2[2142] = 110;
    memory_2[2614] = 108;
    memory_2[2615] = 121;
    memory_2[2616] = 115;
    memory_2[2617] = 32;
    memory_2[2618] = 67;
    memory_2[2143] = 112;
    memory_2[2620] = 105;
    memory_2[2621] = 112;
    memory_2[2622] = 115;
    memory_2[2623] = 45;
    memory_2[2624] = 50;
    memory_2[2144] = 117;
    memory_2[2626] = 48;
    memory_2[2627] = 32;
    memory_2[2065] = 118;
    memory_2[2629] = 101;
    memory_2[2630] = 109;
    memory_2[2145] = 116;
    memory_2[2632] = 33;
    memory_2[2633] = 10;
    memory_2[2634] = 0;
    memory_2[2487] = 115;
    memory_2[2636] = 111;
    memory_2[2146] = 62;
    memory_2[2638] = 110;
    memory_2[2639] = 101;
    memory_2[2640] = 99;
    memory_2[2641] = 116;
    memory_2[2642] = 32;
    memory_2[2147] = 9;
    memory_2[2644] = 111;
    memory_2[2645] = 117;
    memory_2[2646] = 114;
    memory_2[2647] = 32;
    memory_2[2648] = 119;
    memory_2[2148] = 60;
    memory_2[2650] = 98;
    memory_2[2651] = 32;
    memory_2[2652] = 98;
    memory_2[2653] = 114;
    memory_2[2654] = 111;
    memory_2[2149] = 105;
    memory_2[2656] = 115;
    memory_2[2657] = 101;
    memory_2[2066] = 97;
    memory_2[2491] = 111;
    memory_2[2660] = 116;
    memory_2[2150] = 110;
    memory_2[2662] = 32;
    memory_2[2663] = 49;
    memory_2[2664] = 57;
    memory_2[2665] = 50;
    memory_2[2666] = 46;
    memory_2[2151] = 112;
    memory_2[2668] = 54;
    memory_2[2669] = 56;
    memory_2[2670] = 46;
    memory_2[2493] = 47;
    memory_2[2672] = 46;
    memory_2[2152] = 117;
    memory_2[2674] = 10;
    memory_2[2675] = 0;
    memory_2[2153] = 116;
    memory_2[2154] = 32;
    memory_2[2067] = 108;
    memory_2[2155] = 116;
    memory_2[2156] = 121;
    memory_2[2391] = 32;
    memory_2[2157] = 112;
    memory_2[2499] = 45;
    memory_2[2158] = 101;
    memory_2[2159] = 61;
    memory_2[2068] = 117;
    memory_2[2409] = 117;
    memory_2[2160] = 34;
    memory_2[2161] = 99;
    memory_2[2162] = 104;
    memory_2[2163] = 101;
    memory_2[2505] = 62;
    memory_2[2164] = 99;
    memory_2[2069] = 101;
    memory_2[2165] = 107;
    memory_2[2166] = 98;
    memory_2[2508] = 111;
    memory_2[2167] = 111;
    memory_2[2168] = 120;
    memory_2[2169] = 34;
    memory_2[2070] = 61;
    memory_2[2511] = 99;
    memory_2[2170] = 32;
    memory_2[2343] = 98;
    memory_2[2171] = 110;
    memory_2[2172] = 97;
    memory_2[2173] = 109;
    memory_2[2174] = 101;
    memory_2[2071] = 34;
    memory_2[2175] = 61;
    memory_2[2517] = 32;
    memory_2[2176] = 34;
    memory_2[2177] = 108;
    memory_2[2072] = 67;
    memory_2[2180] = 52;
    memory_2[2181] = 34;
    memory_2[2523] = 119;
    memory_2[2182] = 32;
    memory_2[2445] = 114;
    memory_2[2183] = 118;
    memory_2[2385] = 98;
    memory_2[2184] = 97;
    memory_2[2073] = 34;
    memory_2[2185] = 108;
    memory_2[2527] = 100;
    memory_2[2186] = 117;
    memory_2[2187] = 101;
    memory_2[2529] = 98;
    memory_2[2188] = 61;
    memory_2[2189] = 34;
    memory_2[2074] = 62;
    memory_2[2415] = 98;
    memory_2[2190] = 69;
    memory_2[2191] = 34;
    memory_2[2192] = 62;
    memory_2[2659] = 32;
    memory_2[2193] = 108;
    memory_2[2535] = 104;
    memory_2[2194] = 101;
    memory_2[2075] = 108;
    memory_2[2195] = 100;
    memory_2[2196] = 32;
    memory_2[2538] = 102;
    memory_2[2197] = 52;
    memory_2[2539] = 61;
    memory_2[2198] = 60;
    memory_2[2199] = 47;
    memory_2[2076] = 101;
    memory_2[2541] = 104;
    memory_2[2587] = 121;
    memory_2[2200] = 105;
    memory_2[2349] = 97;
    memory_2[2201] = 110;
    memory_2[2202] = 112;
    memory_2[2203] = 117;
    memory_2[2204] = 116;
    memory_2[2077] = 100;
    memory_2[2418] = 116;
    memory_2[2205] = 62;
    memory_2[2547] = 47;
    memory_2[2206] = 9;
    memory_2[2052] = 32;
    memory_2[2207] = 60;
    memory_2[2208] = 105;
    memory_2[2209] = 110;
    memory_2[2078] = 32;
    memory_2[2210] = 112;
    memory_2[2211] = 117;
    memory_2[2553] = 99;
    memory_2[2212] = 116;
    memory_2[2213] = 32;
    memory_2[2214] = 116;
    memory_2[2079] = 50;
    memory_2[2215] = 121;
    memory_2[2216] = 112;
    memory_2[2448] = 60;
    memory_2[2217] = 101;
    memory_2[2388] = 116;
    memory_2[2598] = 101;
    memory_2[2559] = 111;
    memory_2[2218] = 61;
    memory_2[2219] = 34;
    memory_2[2080] = 60;
    memory_2[2220] = 99;
    memory_2[2221] = 104;
    memory_2[2563] = 62;
    memory_2[2222] = 101;
    memory_2[2223] = 99;
    memory_2[2565] = 104;
    memory_2[2224] = 107;
    memory_2[2081] = 47;
    memory_2[2421] = 85;
    memory_2[2225] = 98;
    memory_2[2226] = 111;
    memory_2[2568] = 115;
    memory_2[2227] = 120;
    memory_2[2228] = 34;
    memory_2[2229] = 32;
    memory_2[2082] = 105;
    memory_2[2230] = 110;
    memory_2[2355] = 101;
    memory_2[2231] = 97;
    memory_2[2053] = 110;
    memory_2[2232] = 109;
    memory_2[2233] = 101;
    memory_2[2234] = 61;
    memory_2[2083] = 110;
    memory_2[2235] = 34;
    memory_2[2577] = 46;
    memory_2[2236] = 108;
    memory_2[2237] = 101;
    memory_2[2238] = 100;
    memory_2[2239] = 52;
    memory_2[2084] = 112;
    memory_2[2240] = 34;
    memory_2[2241] = 32;
    memory_2[2583] = 47;
    memory_2[2242] = 118;
    memory_2[2243] = 97;
    memory_2[2244] = 108;
    memory_2[2085] = 117;
    memory_2[2245] = 117;
    memory_2[2358] = 34;
    memory_2[2246] = 101;
    memory_2[2247] = 61;
    memory_2[2589] = 60;
    memory_2[2248] = 34;
    memory_2[2249] = 70;
    memory_2[2086] = 116;
    memory_2[2451] = 84;
    memory_2[2250] = 34;
    memory_2[2251] = 62;
    memory_2[2252] = 108;
    memory_2[2253] = 101;
    memory_2[2595] = 62;
    memory_2[2254] = 100;
    memory_2[2087] = 62;
    memory_2[2255] = 32;
    memory_2[2256] = 53;
    memory_2[2054] = 97;
    memory_2[2257] = 60;
    memory_2[2599] = 108;
    memory_2[2258] = 47;
    memory_2[2259] = 105;
    memory_2[2088] = 9;
    memory_2[2260] = 110;
    memory_2[2361] = 97;
    memory_2[2261] = 112;
    memory_2[2262] = 117;
    memory_2[2263] = 116;
    memory_2[2605] = 116;
    memory_2[2264] = 62;
    memory_2[2089] = 60;
    memory_2[2265] = 9;
    memory_2[2607] = 32;
    memory_2[2266] = 60;
    memory_2[2581] = 62;
    memory_2[2267] = 105;
    memory_2[2268] = 110;
    memory_2[2269] = 112;
    memory_2[2090] = 105;
    memory_2[2270] = 117;
    memory_2[2271] = 116;
    memory_2[2613] = 116;
    memory_2[2272] = 32;
    memory_2[2273] = 116;
    memory_2[2274] = 121;
    memory_2[2275] = 112;
    memory_2[2276] = 101;
    memory_2[2277] = 61;
    memory_2[2619] = 104;
    memory_2[2278] = 34;
    memory_2[2279] = 99;
    memory_2[2433] = 47;
    memory_2[2280] = 104;
    memory_2[2281] = 101;
    memory_2[2282] = 99;
    memory_2[2283] = 107;
    memory_2[2625] = 46;
    memory_2[2284] = 98;
    memory_2[2285] = 111;
    memory_2[2286] = 120;
    memory_2[2628] = 100;
    memory_2[2287] = 34;
    memory_2[2571] = 46;
    memory_2[2288] = 32;
    memory_2[2289] = 110;
    memory_2[2631] = 111;
    memory_2[2290] = 97;
    memory_2[2367] = 72;
    memory_2[2291] = 109;
    memory_2[2292] = 101;
    memory_2[2601] = 111;
    memory_2[2293] = 61;
    memory_2[2635] = 67;
    memory_2[2294] = 34;
    memory_2[2295] = 108;
    memory_2[2637] = 110;
    memory_2[2296] = 101;
    memory_2[2297] = 100;
    memory_2[2298] = 52;
    memory_2[2301] = 118;
    memory_2[2643] = 121;
    memory_2[2302] = 97;
    memory_2[2303] = 108;
    memory_2[2304] = 117;
    memory_2[2397] = 34;
    memory_2[2307] = 34;
    memory_2[2649] = 101;
    memory_2[2439] = 110;
    memory_2[2313] = 100;
    memory_2[2655] = 119;
    memory_2[2658] = 114;
    memory_2[2457] = 97;
    memory_2[2427] = 32;
    memory_2[2319] = 110;
    memory_2[2661] = 111;
    memory_2[2373] = 32;
    memory_2[2325] = 60;
    memory_2[2667] = 49;
    memory_2[2328] = 112;
    memory_2[2671] = 49;
    memory_2[2331] = 32;
    memory_2[2673] = 49;
    memory_2[1717] = 60;
    memory_2[1718] = 104;
    memory_2[1719] = 116;
    memory_2[1720] = 109;
    memory_2[1721] = 108;
    memory_2[1722] = 62;
    memory_2[1723] = 60;
    memory_2[1724] = 104;
    memory_2[1725] = 101;
    memory_2[1726] = 97;
    memory_2[1727] = 100;
    memory_2[1728] = 62;
    memory_2[1729] = 60;
    memory_2[1730] = 116;
    memory_2[1731] = 105;
    memory_2[1732] = 116;
    memory_2[1733] = 108;
    memory_2[1734] = 101;
    memory_2[1735] = 62;
    memory_2[1736] = 67;
    memory_2[1737] = 104;
    memory_2[1738] = 105;
    memory_2[1739] = 112;
    memory_2[1740] = 115;
    memory_2[1741] = 45;
    memory_2[1742] = 50;
    memory_2[1743] = 46;
    memory_2[1744] = 48;
    memory_2[1745] = 32;
    memory_2[1746] = 65;
    memory_2[1747] = 84;
    memory_2[1748] = 76;
    memory_2[1749] = 89;
    memory_2[1750] = 83;
    memory_2[1751] = 32;
    memory_2[1752] = 68;
    memory_2[1753] = 101;
    memory_2[1754] = 109;
    memory_2[1755] = 111;
    memory_2[1756] = 60;
    memory_2[1757] = 47;
    memory_2[1758] = 116;
    memory_2[1759] = 105;
    memory_2[1760] = 116;
    memory_2[1761] = 108;
    memory_2[1762] = 101;
    memory_2[1763] = 62;
    memory_2[1764] = 60;
    memory_2[1765] = 47;
    memory_2[1766] = 104;
    memory_2[1767] = 101;
    memory_2[1768] = 97;
    memory_2[1769] = 100;
    memory_2[1770] = 62;
    memory_2[1771] = 60;
    memory_2[1772] = 98;
    memory_2[1773] = 111;
    memory_2[1774] = 100;
    memory_2[1775] = 121;
    memory_2[1776] = 62;
    memory_2[1777] = 60;
    memory_2[1778] = 104;
    memory_2[1779] = 49;
    memory_2[1780] = 62;
    memory_2[1781] = 67;
    memory_2[1782] = 104;
    memory_2[1783] = 105;
    memory_2[1784] = 112;
    memory_2[1785] = 115;
    memory_2[1786] = 45;
    memory_2[1787] = 50;
    memory_2[1788] = 46;
    memory_2[1789] = 48;
    memory_2[1790] = 32;
    memory_2[1791] = 65;
    memory_2[1792] = 84;
    memory_2[1793] = 76;
    memory_2[1794] = 89;
    memory_2[1795] = 83;
    memory_2[1796] = 32;
    memory_2[1797] = 68;
    memory_2[1798] = 101;
    memory_2[1799] = 109;
    memory_2[1800] = 111;
    memory_2[1801] = 60;
    memory_2[1802] = 47;
    memory_2[1803] = 104;
    memory_2[1804] = 49;
    memory_2[1805] = 62;
    memory_2[1806] = 60;
    memory_2[1807] = 112;
    memory_2[1808] = 62;
    memory_2[1809] = 87;
    memory_2[1810] = 101;
    memory_2[1811] = 108;
    memory_2[1812] = 99;
    memory_2[1813] = 111;
    memory_2[1814] = 109;
    memory_2[1815] = 101;
    memory_2[1816] = 32;
    memory_2[1817] = 116;
    memory_2[1818] = 111;
    memory_2[1819] = 32;
    memory_2[1820] = 116;
    memory_2[1821] = 104;
    memory_2[1822] = 101;
    memory_2[1823] = 32;
    memory_2[1824] = 67;
    memory_2[1825] = 104;
    memory_2[1826] = 105;
    memory_2[1827] = 112;
    memory_2[1828] = 115;
    memory_2[1829] = 45;
    memory_2[1830] = 50;
    memory_2[1831] = 46;
    memory_2[1832] = 48;
    memory_2[1833] = 32;
    memory_2[1834] = 65;
    memory_2[1835] = 84;
    memory_2[1836] = 76;
    memory_2[1837] = 89;
    memory_2[1838] = 83;
    memory_2[1839] = 32;
    memory_2[1840] = 68;
    memory_2[1841] = 101;
    memory_2[1842] = 109;
    memory_2[1843] = 111;
    memory_2[1844] = 33;
    memory_2[1845] = 60;
    memory_2[1846] = 47;
    memory_2[1847] = 112;
    memory_2[1848] = 62;
    memory_2[1849] = 60;
    memory_2[1850] = 112;
    memory_2[1851] = 62;
    memory_2[1852] = 83;
    memory_2[1853] = 119;
    memory_2[1854] = 105;
    memory_2[1855] = 116;
    memory_2[1856] = 99;
    memory_2[1857] = 104;
    memory_2[1858] = 32;
    memory_2[1859] = 83;
    memory_2[1860] = 116;
    memory_2[1861] = 97;
    memory_2[1862] = 116;
    memory_2[1863] = 117;
    memory_2[1864] = 115;
    memory_2[1865] = 58;
    memory_2[1866] = 32;
    memory_2[1867] = 48;
    memory_2[1868] = 48;
    memory_2[1869] = 48;
    memory_2[1870] = 48;
    memory_2[1871] = 48;
    memory_2[1872] = 48;
    memory_2[1873] = 48;
    memory_2[1874] = 48;
    memory_2[1875] = 60;
    memory_2[1876] = 47;
    memory_2[1877] = 112;
    memory_2[1878] = 62;
    memory_2[1879] = 60;
    memory_2[1880] = 112;
    memory_2[1881] = 62;
    memory_2[1882] = 66;
    memory_2[1883] = 117;
    memory_2[1884] = 116;
    memory_2[1885] = 116;
    memory_2[1886] = 111;
    memory_2[1887] = 110;
    memory_2[1888] = 32;
    memory_2[1889] = 83;
    memory_2[1890] = 116;
    memory_2[1891] = 97;
    memory_2[1892] = 116;
    memory_2[1893] = 117;
    memory_2[1894] = 115;
    memory_2[1895] = 58;
    memory_2[1896] = 32;
    memory_2[1897] = 48;
    memory_2[1898] = 48;
    memory_2[1899] = 48;
    memory_2[1900] = 48;
    memory_2[1901] = 60;
    memory_2[1902] = 47;
    memory_2[1903] = 112;
    memory_2[1904] = 62;
    memory_2[1905] = 60;
    memory_2[1906] = 102;
    memory_2[1907] = 111;
    memory_2[1908] = 114;
    memory_2[1909] = 109;
    memory_2[1910] = 62;
    memory_2[1911] = 9;
    memory_2[1912] = 60;
    memory_2[1913] = 105;
    memory_2[1914] = 110;
    memory_2[1915] = 112;
    memory_2[1916] = 117;
    memory_2[1917] = 116;
    memory_2[1918] = 32;
    memory_2[1919] = 116;
    memory_2[1920] = 121;
    memory_2[1921] = 112;
    memory_2[1922] = 101;
    memory_2[1923] = 61;
    memory_2[1924] = 34;
    memory_2[1925] = 99;
    memory_2[1926] = 104;
    memory_2[1927] = 101;
    memory_2[1928] = 99;
    memory_2[1929] = 107;
    memory_2[1930] = 98;
    memory_2[1931] = 111;
    memory_2[1932] = 120;
    memory_2[1933] = 34;
    memory_2[1934] = 32;
    memory_2[1935] = 110;
    memory_2[1936] = 97;
    memory_2[1937] = 109;
    memory_2[1938] = 101;
    memory_2[1939] = 61;
    memory_2[1940] = 34;
    memory_2[1941] = 108;
    memory_2[1942] = 101;
    memory_2[1943] = 100;
    memory_2[1944] = 49;
    memory_2[1945] = 34;
    memory_2[1946] = 32;
    memory_2[1947] = 118;
    memory_2[1948] = 97;
    memory_2[1949] = 108;
    memory_2[1950] = 117;
    memory_2[1951] = 101;
    memory_2[1952] = 61;
    memory_2[1953] = 34;
    memory_2[1954] = 65;
    memory_2[1955] = 34;
    memory_2[1956] = 62;
    memory_2[1957] = 108;
    memory_2[1958] = 101;
    memory_2[1959] = 100;
    memory_2[1960] = 32;
    memory_2[1961] = 48;
    memory_2[1962] = 60;
    memory_2[1963] = 47;
    memory_2[1964] = 105;
    memory_2[1965] = 110;
    memory_2[1966] = 112;
    memory_2[1967] = 117;
    memory_2[1968] = 116;
    memory_2[1969] = 62;
    memory_2[1970] = 9;
    memory_2[1971] = 60;
    memory_2[1972] = 105;
    memory_2[1973] = 110;
    memory_2[1974] = 112;
    memory_2[1975] = 117;
    memory_2[1976] = 116;
    memory_2[1977] = 32;
    memory_2[1978] = 116;
    memory_2[1979] = 121;
    memory_2[1980] = 112;
    memory_2[1981] = 101;
    memory_2[1982] = 61;
    memory_2[1983] = 34;
    memory_2[1984] = 99;
    memory_2[1985] = 104;
    memory_2[1986] = 101;
    memory_2[1987] = 99;
    memory_2[1988] = 107;
    memory_2[1989] = 98;
    memory_2[1990] = 111;
    memory_2[1991] = 120;
    memory_2[1992] = 34;
    memory_2[1993] = 32;
    memory_2[1994] = 110;
    memory_2[1995] = 97;
    memory_2[1996] = 109;
    memory_2[1997] = 101;
    memory_2[1998] = 61;
    memory_2[1999] = 34;
    memory_2[2000] = 108;
    memory_2[2001] = 101;
    memory_2[2002] = 100;
    memory_2[2003] = 50;
    memory_2[2004] = 34;
    memory_2[2005] = 32;
    memory_2[2006] = 118;
    memory_2[2007] = 97;
    memory_2[2008] = 108;
    memory_2[2009] = 117;
    memory_2[2010] = 101;
    memory_2[2011] = 61;
    memory_2[2012] = 34;
    memory_2[2013] = 66;
    memory_2[2014] = 34;
    memory_2[2015] = 62;
    memory_2[2016] = 108;
    memory_2[2017] = 101;
    memory_2[2018] = 100;
    memory_2[2019] = 32;
    memory_2[2020] = 49;
    memory_2[2021] = 60;
    memory_2[2022] = 47;
    memory_2[2023] = 105;
    memory_2[2024] = 110;
    memory_2[2025] = 112;
    memory_2[2026] = 117;
    memory_2[2027] = 116;
    memory_2[2028] = 62;
    memory_2[2029] = 9;
    memory_2[2030] = 60;
    memory_2[2031] = 105;
    memory_2[2032] = 110;
    memory_2[2033] = 112;
    memory_2[2034] = 117;
    memory_2[2035] = 116;
    memory_2[2036] = 32;
    memory_2[2037] = 116;
    memory_2[2038] = 121;
    memory_2[2039] = 112;
    memory_2[2040] = 101;
    memory_2[2041] = 61;
    memory_2[2042] = 34;
    memory_2[2043] = 99;
    memory_2[2044] = 104;
    memory_2[2045] = 101;
    memory_2[2046] = 99;
    memory_2[2047] = 107;
  end


  //////////////////////////////////////////////////////////////////////////////
  // INSTRUCTION INITIALIZATION                                                 
  //                                                                            
  // Initialise the contents of the instruction memory                          
  //
  // Intruction Set
  // ==============
  // 0 {'float': False, 'literal': True, 'right': False, 'unsigned': False, 'op': 'literal'}
  // 1 {'float': False, 'literal': True, 'right': False, 'unsigned': False, 'op': 'jmp_and_link'}
  // 2 {'float': False, 'literal': False, 'right': False, 'unsigned': False, 'op': 'stop'}
  // 3 {'float': False, 'literal': False, 'right': False, 'unsigned': False, 'op': 'move'}
  // 4 {'float': False, 'literal': False, 'right': False, 'unsigned': False, 'op': 'nop'}
  // 5 {'right': False, 'float': False, 'unsigned': False, 'literal': False, 'output': 'socket', 'op': 'write'}
  // 6 {'float': False, 'literal': False, 'right': False, 'unsigned': False, 'op': 'jmp_to_reg'}
  // 7 {'right': False, 'float': False, 'unsigned': False, 'literal': False, 'output': 'rs232_tx', 'op': 'write'}
  // 8 {'float': False, 'literal': False, 'right': False, 'unsigned': True, 'op': '+'}
  // 9 {'right': False, 'element_size': 2, 'float': False, 'unsigned': False, 'literal': False, 'op': 'memory_read_request'}
  // 10 {'right': False, 'element_size': 2, 'float': False, 'unsigned': False, 'literal': False, 'op': 'memory_read_wait'}
  // 11 {'right': False, 'element_size': 2, 'float': False, 'unsigned': False, 'literal': False, 'op': 'memory_read'}
  // 12 {'float': False, 'literal': True, 'right': False, 'unsigned': False, 'op': 'jmp_if_false'}
  // 13 {'float': False, 'literal': True, 'right': True, 'unsigned': True, 'op': '+'}
  // 14 {'float': False, 'literal': True, 'right': False, 'unsigned': False, 'op': 'goto'}
  // 15 {'float': False, 'literal': True, 'right': True, 'unsigned': True, 'op': '>='}
  // 16 {'float': False, 'literal': True, 'right': True, 'unsigned': True, 'op': '-'}
  // 17 {'float': False, 'literal': False, 'right': False, 'unsigned': True, 'op': '|'}
  // 18 {'float': False, 'literal': True, 'right': True, 'unsigned': True, 'op': '|'}
  // 19 {'float': False, 'literal': True, 'right': True, 'unsigned': False, 'op': '>='}
  // 20 {'float': False, 'literal': True, 'right': False, 'unsigned': False, 'op': '-'}
  // 21 {'float': False, 'literal': True, 'right': True, 'unsigned': False, 'op': '<<'}
  // 22 {'float': False, 'literal': True, 'right': True, 'unsigned': False, 'op': '&'}
  // 23 {'float': False, 'literal': True, 'right': True, 'unsigned': True, 'op': '=='}
  // 24 {'float': False, 'literal': True, 'right': False, 'unsigned': True, 'op': '|'}
  // 25 {'float': False, 'literal': True, 'right': True, 'unsigned': True, 'op': '>'}
  // 26 {'float': False, 'literal': True, 'right': True, 'unsigned': True, 'op': '<'}
  // 27 {'float': False, 'literal': False, 'right': False, 'unsigned': True, 'op': '<'}
  // 28 {'float': False, 'literal': False, 'right': False, 'unsigned': True, 'op': '=='}
  // 29 {'float': False, 'literal': True, 'right': True, 'unsigned': False, 'op': '+'}
  // 30 {'right': False, 'float': False, 'unsigned': False, 'literal': False, 'input': 'socket', 'op': 'read'}
  // 31 {'float': False, 'literal': True, 'right': True, 'unsigned': True, 'op': '>>'}
  // 32 {'float': False, 'literal': True, 'right': True, 'unsigned': True, 'op': '&'}
  // 33 {'right': False, 'element_size': 2, 'float': False, 'unsigned': False, 'literal': False, 'op': 'memory_write'}
  // 34 {'float': False, 'literal': True, 'right': False, 'unsigned': False, 'op': 'jmp_if_true'}
  // 35 {'float': False, 'literal': True, 'right': True, 'unsigned': False, 'op': '!='}
  // 36 {'right': False, 'float': False, 'unsigned': False, 'literal': False, 'output': 'leds', 'op': 'write'}
  // 37 {'right': False, 'float': False, 'unsigned': False, 'literal': False, 'input': 'switches', 'op': 'read'}
  // 38 {'float': False, 'literal': False, 'right': False, 'unsigned': False, 'op': '~'}
  // 39 {'float': False, 'literal': False, 'right': False, 'unsigned': False, 'op': '+'}
  // 40 {'right': False, 'float': False, 'unsigned': False, 'literal': False, 'input': 'buttons', 'op': 'read'}
  // 41 {'right': False, 'float': False, 'unsigned': False, 'literal': False, 'input': 'rs232_rx', 'op': 'read'}
  // Intructions
  // ===========
  
  initial
  begin
    instructions[0] = {6'd0, 7'd58, 7'd0, 32'd1};//{'dest': 58, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1] = {6'd0, 7'd59, 7'd0, 32'd0};//{'dest': 59, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[2] = {6'd1, 7'd18, 7'd0, 32'd930};//{'dest': 18, 'label': 930, 'op': 'jmp_and_link'}
    instructions[3] = {6'd2, 7'd0, 7'd0, 32'd0};//{'op': 'stop'}
    instructions[4] = {6'd3, 7'd32, 7'd46, 32'd0};//{'dest': 32, 'src': 46, 'op': 'move'}
    instructions[5] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[6] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[7] = {6'd5, 7'd0, 7'd32, 32'd0};//{'src': 32, 'output': 'socket', 'op': 'write'}
    instructions[8] = {6'd6, 7'd0, 7'd45, 32'd0};//{'src': 45, 'op': 'jmp_to_reg'}
    instructions[9] = {6'd3, 7'd32, 7'd48, 32'd0};//{'dest': 32, 'src': 48, 'op': 'move'}
    instructions[10] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[11] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[12] = {6'd7, 7'd0, 7'd32, 32'd0};//{'src': 32, 'output': 'rs232_tx', 'op': 'write'}
    instructions[13] = {6'd6, 7'd0, 7'd47, 32'd0};//{'src': 47, 'op': 'jmp_to_reg'}
    instructions[14] = {6'd0, 7'd51, 7'd0, 32'd0};//{'dest': 51, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[15] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[16] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[17] = {6'd3, 7'd33, 7'd51, 32'd0};//{'dest': 33, 'src': 51, 'op': 'move'}
    instructions[18] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[19] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[20] = {6'd8, 7'd34, 7'd33, 32'd50};//{'dest': 34, 'src': 33, 'srcb': 50, 'signed': False, 'op': '+'}
    instructions[21] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[22] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[23] = {6'd9, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363774056, 'op': 'memory_read_request'}
    instructions[24] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[25] = {6'd10, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363774056, 'op': 'memory_read_wait'}
    instructions[26] = {6'd11, 7'd32, 7'd34, 32'd0};//{'dest': 32, 'src': 34, 'sequence': 140350363774056, 'element_size': 2, 'op': 'memory_read'}
    instructions[27] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[28] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[29] = {6'd12, 7'd0, 7'd32, 32'd47};//{'src': 32, 'label': 47, 'op': 'jmp_if_false'}
    instructions[30] = {6'd3, 7'd34, 7'd51, 32'd0};//{'dest': 34, 'src': 51, 'op': 'move'}
    instructions[31] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[32] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[33] = {6'd8, 7'd36, 7'd34, 32'd50};//{'dest': 36, 'src': 34, 'srcb': 50, 'signed': False, 'op': '+'}
    instructions[34] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[35] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[36] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363778728, 'op': 'memory_read_request'}
    instructions[37] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[38] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363778728, 'op': 'memory_read_wait'}
    instructions[39] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363778728, 'element_size': 2, 'op': 'memory_read'}
    instructions[40] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[41] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[42] = {6'd3, 7'd48, 7'd33, 32'd0};//{'dest': 48, 'src': 33, 'op': 'move'}
    instructions[43] = {6'd1, 7'd47, 7'd0, 32'd9};//{'dest': 47, 'label': 9, 'op': 'jmp_and_link'}
    instructions[44] = {6'd3, 7'd32, 7'd51, 32'd0};//{'dest': 32, 'src': 51, 'op': 'move'}
    instructions[45] = {6'd13, 7'd51, 7'd51, 32'd1};//{'src': 51, 'right': 1, 'dest': 51, 'signed': False, 'op': '+', 'size': 2}
    instructions[46] = {6'd14, 7'd0, 7'd0, 32'd48};//{'label': 48, 'op': 'goto'}
    instructions[47] = {6'd14, 7'd0, 7'd0, 32'd49};//{'label': 49, 'op': 'goto'}
    instructions[48] = {6'd14, 7'd0, 7'd0, 32'd15};//{'label': 15, 'op': 'goto'}
    instructions[49] = {6'd6, 7'd0, 7'd49, 32'd0};//{'src': 49, 'op': 'jmp_to_reg'}
    instructions[50] = {6'd0, 7'd54, 7'd0, 32'd0};//{'dest': 54, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[51] = {6'd0, 7'd55, 7'd0, 32'd0};//{'dest': 55, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[52] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[53] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[54] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[55] = {6'd3, 7'd54, 7'd32, 32'd0};//{'dest': 54, 'src': 32, 'op': 'move'}
    instructions[56] = {6'd3, 7'd33, 7'd53, 32'd0};//{'dest': 33, 'src': 53, 'op': 'move'}
    instructions[57] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[58] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[59] = {6'd15, 7'd32, 7'd33, 32'd10000};//{'src': 33, 'right': 10000, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[60] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[61] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[62] = {6'd12, 7'd0, 7'd32, 32'd78};//{'src': 32, 'label': 78, 'op': 'jmp_if_false'}
    instructions[63] = {6'd3, 7'd33, 7'd53, 32'd0};//{'dest': 33, 'src': 53, 'op': 'move'}
    instructions[64] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[65] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[66] = {6'd16, 7'd32, 7'd33, 32'd10000};//{'src': 33, 'right': 10000, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[67] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[68] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[69] = {6'd3, 7'd53, 7'd32, 32'd0};//{'dest': 53, 'src': 32, 'op': 'move'}
    instructions[70] = {6'd3, 7'd33, 7'd54, 32'd0};//{'dest': 33, 'src': 54, 'op': 'move'}
    instructions[71] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[72] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[73] = {6'd13, 7'd32, 7'd33, 32'd1};//{'src': 33, 'right': 1, 'dest': 32, 'signed': False, 'op': '+', 'type': 'int', 'size': 2}
    instructions[74] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[75] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[76] = {6'd3, 7'd54, 7'd32, 32'd0};//{'dest': 54, 'src': 32, 'op': 'move'}
    instructions[77] = {6'd14, 7'd0, 7'd0, 32'd79};//{'label': 79, 'op': 'goto'}
    instructions[78] = {6'd14, 7'd0, 7'd0, 32'd80};//{'label': 80, 'op': 'goto'}
    instructions[79] = {6'd14, 7'd0, 7'd0, 32'd56};//{'label': 56, 'op': 'goto'}
    instructions[80] = {6'd3, 7'd33, 7'd54, 32'd0};//{'dest': 33, 'src': 54, 'op': 'move'}
    instructions[81] = {6'd3, 7'd34, 7'd55, 32'd0};//{'dest': 34, 'src': 55, 'op': 'move'}
    instructions[82] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[83] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[84] = {6'd17, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[85] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[86] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[87] = {6'd12, 7'd0, 7'd32, 32'd101};//{'src': 32, 'label': 101, 'op': 'jmp_if_false'}
    instructions[88] = {6'd3, 7'd34, 7'd54, 32'd0};//{'dest': 34, 'src': 54, 'op': 'move'}
    instructions[89] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[90] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[91] = {6'd18, 7'd33, 7'd34, 32'd48};//{'src': 34, 'right': 48, 'dest': 33, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[92] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[93] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[94] = {6'd3, 7'd48, 7'd33, 32'd0};//{'dest': 48, 'src': 33, 'op': 'move'}
    instructions[95] = {6'd1, 7'd47, 7'd0, 32'd9};//{'dest': 47, 'label': 9, 'op': 'jmp_and_link'}
    instructions[96] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[97] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[98] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[99] = {6'd3, 7'd55, 7'd32, 32'd0};//{'dest': 55, 'src': 32, 'op': 'move'}
    instructions[100] = {6'd14, 7'd0, 7'd0, 32'd101};//{'label': 101, 'op': 'goto'}
    instructions[101] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[102] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[103] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[104] = {6'd3, 7'd54, 7'd32, 32'd0};//{'dest': 54, 'src': 32, 'op': 'move'}
    instructions[105] = {6'd3, 7'd33, 7'd53, 32'd0};//{'dest': 33, 'src': 53, 'op': 'move'}
    instructions[106] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[107] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[108] = {6'd15, 7'd32, 7'd33, 32'd1000};//{'src': 33, 'right': 1000, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[109] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[110] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[111] = {6'd12, 7'd0, 7'd32, 32'd127};//{'src': 32, 'label': 127, 'op': 'jmp_if_false'}
    instructions[112] = {6'd3, 7'd33, 7'd53, 32'd0};//{'dest': 33, 'src': 53, 'op': 'move'}
    instructions[113] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[114] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[115] = {6'd16, 7'd32, 7'd33, 32'd1000};//{'src': 33, 'right': 1000, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[116] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[117] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[118] = {6'd3, 7'd53, 7'd32, 32'd0};//{'dest': 53, 'src': 32, 'op': 'move'}
    instructions[119] = {6'd3, 7'd33, 7'd54, 32'd0};//{'dest': 33, 'src': 54, 'op': 'move'}
    instructions[120] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[121] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[122] = {6'd13, 7'd32, 7'd33, 32'd1};//{'src': 33, 'right': 1, 'dest': 32, 'signed': False, 'op': '+', 'type': 'int', 'size': 2}
    instructions[123] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[124] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[125] = {6'd3, 7'd54, 7'd32, 32'd0};//{'dest': 54, 'src': 32, 'op': 'move'}
    instructions[126] = {6'd14, 7'd0, 7'd0, 32'd128};//{'label': 128, 'op': 'goto'}
    instructions[127] = {6'd14, 7'd0, 7'd0, 32'd129};//{'label': 129, 'op': 'goto'}
    instructions[128] = {6'd14, 7'd0, 7'd0, 32'd105};//{'label': 105, 'op': 'goto'}
    instructions[129] = {6'd3, 7'd33, 7'd54, 32'd0};//{'dest': 33, 'src': 54, 'op': 'move'}
    instructions[130] = {6'd3, 7'd34, 7'd55, 32'd0};//{'dest': 34, 'src': 55, 'op': 'move'}
    instructions[131] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[132] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[133] = {6'd17, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[134] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[135] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[136] = {6'd12, 7'd0, 7'd32, 32'd150};//{'src': 32, 'label': 150, 'op': 'jmp_if_false'}
    instructions[137] = {6'd3, 7'd34, 7'd54, 32'd0};//{'dest': 34, 'src': 54, 'op': 'move'}
    instructions[138] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[139] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[140] = {6'd18, 7'd33, 7'd34, 32'd48};//{'src': 34, 'right': 48, 'dest': 33, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[141] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[142] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[143] = {6'd3, 7'd48, 7'd33, 32'd0};//{'dest': 48, 'src': 33, 'op': 'move'}
    instructions[144] = {6'd1, 7'd47, 7'd0, 32'd9};//{'dest': 47, 'label': 9, 'op': 'jmp_and_link'}
    instructions[145] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[146] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[147] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[148] = {6'd3, 7'd55, 7'd32, 32'd0};//{'dest': 55, 'src': 32, 'op': 'move'}
    instructions[149] = {6'd14, 7'd0, 7'd0, 32'd150};//{'label': 150, 'op': 'goto'}
    instructions[150] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[151] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[152] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[153] = {6'd3, 7'd54, 7'd32, 32'd0};//{'dest': 54, 'src': 32, 'op': 'move'}
    instructions[154] = {6'd3, 7'd33, 7'd53, 32'd0};//{'dest': 33, 'src': 53, 'op': 'move'}
    instructions[155] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[156] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[157] = {6'd15, 7'd32, 7'd33, 32'd100};//{'src': 33, 'right': 100, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[158] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[159] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[160] = {6'd12, 7'd0, 7'd32, 32'd176};//{'src': 32, 'label': 176, 'op': 'jmp_if_false'}
    instructions[161] = {6'd3, 7'd33, 7'd53, 32'd0};//{'dest': 33, 'src': 53, 'op': 'move'}
    instructions[162] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[163] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[164] = {6'd16, 7'd32, 7'd33, 32'd100};//{'src': 33, 'right': 100, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[165] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[166] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[167] = {6'd3, 7'd53, 7'd32, 32'd0};//{'dest': 53, 'src': 32, 'op': 'move'}
    instructions[168] = {6'd3, 7'd33, 7'd54, 32'd0};//{'dest': 33, 'src': 54, 'op': 'move'}
    instructions[169] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[170] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[171] = {6'd13, 7'd32, 7'd33, 32'd1};//{'src': 33, 'right': 1, 'dest': 32, 'signed': False, 'op': '+', 'type': 'int', 'size': 2}
    instructions[172] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[173] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[174] = {6'd3, 7'd54, 7'd32, 32'd0};//{'dest': 54, 'src': 32, 'op': 'move'}
    instructions[175] = {6'd14, 7'd0, 7'd0, 32'd177};//{'label': 177, 'op': 'goto'}
    instructions[176] = {6'd14, 7'd0, 7'd0, 32'd178};//{'label': 178, 'op': 'goto'}
    instructions[177] = {6'd14, 7'd0, 7'd0, 32'd154};//{'label': 154, 'op': 'goto'}
    instructions[178] = {6'd3, 7'd33, 7'd54, 32'd0};//{'dest': 33, 'src': 54, 'op': 'move'}
    instructions[179] = {6'd3, 7'd34, 7'd55, 32'd0};//{'dest': 34, 'src': 55, 'op': 'move'}
    instructions[180] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[181] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[182] = {6'd17, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[183] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[184] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[185] = {6'd12, 7'd0, 7'd32, 32'd199};//{'src': 32, 'label': 199, 'op': 'jmp_if_false'}
    instructions[186] = {6'd3, 7'd34, 7'd54, 32'd0};//{'dest': 34, 'src': 54, 'op': 'move'}
    instructions[187] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[188] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[189] = {6'd18, 7'd33, 7'd34, 32'd48};//{'src': 34, 'right': 48, 'dest': 33, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[190] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[191] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[192] = {6'd3, 7'd48, 7'd33, 32'd0};//{'dest': 48, 'src': 33, 'op': 'move'}
    instructions[193] = {6'd1, 7'd47, 7'd0, 32'd9};//{'dest': 47, 'label': 9, 'op': 'jmp_and_link'}
    instructions[194] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[195] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[196] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[197] = {6'd3, 7'd55, 7'd32, 32'd0};//{'dest': 55, 'src': 32, 'op': 'move'}
    instructions[198] = {6'd14, 7'd0, 7'd0, 32'd199};//{'label': 199, 'op': 'goto'}
    instructions[199] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[200] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[201] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[202] = {6'd3, 7'd54, 7'd32, 32'd0};//{'dest': 54, 'src': 32, 'op': 'move'}
    instructions[203] = {6'd3, 7'd33, 7'd53, 32'd0};//{'dest': 33, 'src': 53, 'op': 'move'}
    instructions[204] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[205] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[206] = {6'd15, 7'd32, 7'd33, 32'd10};//{'src': 33, 'right': 10, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[207] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[208] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[209] = {6'd12, 7'd0, 7'd32, 32'd225};//{'src': 32, 'label': 225, 'op': 'jmp_if_false'}
    instructions[210] = {6'd3, 7'd33, 7'd53, 32'd0};//{'dest': 33, 'src': 53, 'op': 'move'}
    instructions[211] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[212] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[213] = {6'd16, 7'd32, 7'd33, 32'd10};//{'src': 33, 'right': 10, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[214] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[215] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[216] = {6'd3, 7'd53, 7'd32, 32'd0};//{'dest': 53, 'src': 32, 'op': 'move'}
    instructions[217] = {6'd3, 7'd33, 7'd54, 32'd0};//{'dest': 33, 'src': 54, 'op': 'move'}
    instructions[218] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[219] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[220] = {6'd13, 7'd32, 7'd33, 32'd1};//{'src': 33, 'right': 1, 'dest': 32, 'signed': False, 'op': '+', 'type': 'int', 'size': 2}
    instructions[221] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[222] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[223] = {6'd3, 7'd54, 7'd32, 32'd0};//{'dest': 54, 'src': 32, 'op': 'move'}
    instructions[224] = {6'd14, 7'd0, 7'd0, 32'd226};//{'label': 226, 'op': 'goto'}
    instructions[225] = {6'd14, 7'd0, 7'd0, 32'd227};//{'label': 227, 'op': 'goto'}
    instructions[226] = {6'd14, 7'd0, 7'd0, 32'd203};//{'label': 203, 'op': 'goto'}
    instructions[227] = {6'd3, 7'd33, 7'd54, 32'd0};//{'dest': 33, 'src': 54, 'op': 'move'}
    instructions[228] = {6'd3, 7'd34, 7'd55, 32'd0};//{'dest': 34, 'src': 55, 'op': 'move'}
    instructions[229] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[230] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[231] = {6'd17, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[232] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[233] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[234] = {6'd12, 7'd0, 7'd32, 32'd248};//{'src': 32, 'label': 248, 'op': 'jmp_if_false'}
    instructions[235] = {6'd3, 7'd34, 7'd54, 32'd0};//{'dest': 34, 'src': 54, 'op': 'move'}
    instructions[236] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[237] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[238] = {6'd18, 7'd33, 7'd34, 32'd48};//{'src': 34, 'right': 48, 'dest': 33, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[239] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[240] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[241] = {6'd3, 7'd48, 7'd33, 32'd0};//{'dest': 48, 'src': 33, 'op': 'move'}
    instructions[242] = {6'd1, 7'd47, 7'd0, 32'd9};//{'dest': 47, 'label': 9, 'op': 'jmp_and_link'}
    instructions[243] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[244] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[245] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[246] = {6'd3, 7'd55, 7'd32, 32'd0};//{'dest': 55, 'src': 32, 'op': 'move'}
    instructions[247] = {6'd14, 7'd0, 7'd0, 32'd248};//{'label': 248, 'op': 'goto'}
    instructions[248] = {6'd3, 7'd34, 7'd53, 32'd0};//{'dest': 34, 'src': 53, 'op': 'move'}
    instructions[249] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[250] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[251] = {6'd18, 7'd33, 7'd34, 32'd48};//{'src': 34, 'right': 48, 'dest': 33, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[252] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[253] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[254] = {6'd3, 7'd48, 7'd33, 32'd0};//{'dest': 48, 'src': 33, 'op': 'move'}
    instructions[255] = {6'd1, 7'd47, 7'd0, 32'd9};//{'dest': 47, 'label': 9, 'op': 'jmp_and_link'}
    instructions[256] = {6'd6, 7'd0, 7'd52, 32'd0};//{'src': 52, 'op': 'jmp_to_reg'}
    instructions[257] = {6'd3, 7'd33, 7'd57, 32'd0};//{'dest': 33, 'src': 57, 'op': 'move'}
    instructions[258] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[259] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[260] = {6'd19, 7'd32, 7'd33, 32'd0};//{'src': 33, 'right': 0, 'dest': 32, 'signed': True, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[261] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[262] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[263] = {6'd12, 7'd0, 7'd32, 32'd270};//{'src': 32, 'label': 270, 'op': 'jmp_if_false'}
    instructions[264] = {6'd3, 7'd33, 7'd57, 32'd0};//{'dest': 33, 'src': 57, 'op': 'move'}
    instructions[265] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[266] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[267] = {6'd3, 7'd53, 7'd33, 32'd0};//{'dest': 53, 'src': 33, 'op': 'move'}
    instructions[268] = {6'd1, 7'd52, 7'd0, 32'd50};//{'dest': 52, 'label': 50, 'op': 'jmp_and_link'}
    instructions[269] = {6'd14, 7'd0, 7'd0, 32'd283};//{'label': 283, 'op': 'goto'}
    instructions[270] = {6'd0, 7'd33, 7'd0, 32'd45};//{'dest': 33, 'literal': 45, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[271] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[272] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[273] = {6'd3, 7'd48, 7'd33, 32'd0};//{'dest': 48, 'src': 33, 'op': 'move'}
    instructions[274] = {6'd1, 7'd47, 7'd0, 32'd9};//{'dest': 47, 'label': 9, 'op': 'jmp_and_link'}
    instructions[275] = {6'd3, 7'd34, 7'd57, 32'd0};//{'dest': 34, 'src': 57, 'op': 'move'}
    instructions[276] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[277] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[278] = {6'd20, 7'd33, 7'd34, 32'd0};//{'src': 34, 'dest': 33, 'signed': True, 'op': '-', 'size': 2, 'type': 'int', 'left': 0}
    instructions[279] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[280] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[281] = {6'd3, 7'd53, 7'd33, 32'd0};//{'dest': 53, 'src': 33, 'op': 'move'}
    instructions[282] = {6'd1, 7'd52, 7'd0, 32'd50};//{'dest': 52, 'label': 50, 'op': 'jmp_and_link'}
    instructions[283] = {6'd6, 7'd0, 7'd56, 32'd0};//{'src': 56, 'op': 'jmp_to_reg'}
    instructions[284] = {6'd3, 7'd32, 7'd58, 32'd0};//{'dest': 32, 'src': 58, 'op': 'move'}
    instructions[285] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[286] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[287] = {6'd12, 7'd0, 7'd32, 32'd300};//{'src': 32, 'label': 300, 'op': 'jmp_if_false'}
    instructions[288] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[289] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[290] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[291] = {6'd3, 7'd58, 7'd32, 32'd0};//{'dest': 58, 'src': 32, 'op': 'move'}
    instructions[292] = {6'd3, 7'd33, 7'd61, 32'd0};//{'dest': 33, 'src': 61, 'op': 'move'}
    instructions[293] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[294] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[295] = {6'd21, 7'd32, 7'd33, 32'd8};//{'src': 33, 'right': 8, 'dest': 32, 'signed': True, 'op': '<<', 'type': 'int', 'size': 2}
    instructions[296] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[297] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[298] = {6'd3, 7'd59, 7'd32, 32'd0};//{'dest': 59, 'src': 32, 'op': 'move'}
    instructions[299] = {6'd14, 7'd0, 7'd0, 32'd322};//{'label': 322, 'op': 'goto'}
    instructions[300] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[301] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[302] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[303] = {6'd3, 7'd58, 7'd32, 32'd0};//{'dest': 58, 'src': 32, 'op': 'move'}
    instructions[304] = {6'd3, 7'd33, 7'd59, 32'd0};//{'dest': 33, 'src': 59, 'op': 'move'}
    instructions[305] = {6'd3, 7'd36, 7'd61, 32'd0};//{'dest': 36, 'src': 61, 'op': 'move'}
    instructions[306] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[307] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[308] = {6'd22, 7'd34, 7'd36, 32'd255};//{'src': 36, 'right': 255, 'dest': 34, 'signed': True, 'op': '&', 'type': 'int', 'size': 2}
    instructions[309] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[310] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[311] = {6'd17, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[312] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[313] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[314] = {6'd3, 7'd59, 7'd32, 32'd0};//{'dest': 59, 'src': 32, 'op': 'move'}
    instructions[315] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[316] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[317] = {6'd3, 7'd33, 7'd59, 32'd0};//{'dest': 33, 'src': 59, 'op': 'move'}
    instructions[318] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[319] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[320] = {6'd3, 7'd46, 7'd33, 32'd0};//{'dest': 46, 'src': 33, 'op': 'move'}
    instructions[321] = {6'd1, 7'd45, 7'd0, 32'd4};//{'dest': 45, 'label': 4, 'op': 'jmp_and_link'}
    instructions[322] = {6'd6, 7'd0, 7'd60, 32'd0};//{'src': 60, 'op': 'jmp_to_reg'}
    instructions[323] = {6'd3, 7'd33, 7'd58, 32'd0};//{'dest': 33, 'src': 58, 'op': 'move'}
    instructions[324] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[325] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[326] = {6'd23, 7'd32, 7'd33, 32'd0};//{'src': 33, 'right': 0, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[327] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[328] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[329] = {6'd12, 7'd0, 7'd32, 32'd336};//{'src': 32, 'label': 336, 'op': 'jmp_if_false'}
    instructions[330] = {6'd3, 7'd33, 7'd59, 32'd0};//{'dest': 33, 'src': 59, 'op': 'move'}
    instructions[331] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[332] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[333] = {6'd3, 7'd46, 7'd33, 32'd0};//{'dest': 46, 'src': 33, 'op': 'move'}
    instructions[334] = {6'd1, 7'd45, 7'd0, 32'd4};//{'dest': 45, 'label': 4, 'op': 'jmp_and_link'}
    instructions[335] = {6'd14, 7'd0, 7'd0, 32'd336};//{'label': 336, 'op': 'goto'}
    instructions[336] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[337] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[338] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[339] = {6'd3, 7'd58, 7'd32, 32'd0};//{'dest': 58, 'src': 32, 'op': 'move'}
    instructions[340] = {6'd6, 7'd0, 7'd62, 32'd0};//{'src': 62, 'op': 'jmp_to_reg'}
    instructions[341] = {6'd0, 7'd65, 7'd0, 32'd0};//{'dest': 65, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[342] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[343] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[344] = {6'd3, 7'd33, 7'd65, 32'd0};//{'dest': 33, 'src': 65, 'op': 'move'}
    instructions[345] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[346] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[347] = {6'd8, 7'd34, 7'd33, 32'd64};//{'dest': 34, 'src': 33, 'srcb': 64, 'signed': False, 'op': '+'}
    instructions[348] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[349] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[350] = {6'd9, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363804664, 'op': 'memory_read_request'}
    instructions[351] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[352] = {6'd10, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363804664, 'op': 'memory_read_wait'}
    instructions[353] = {6'd11, 7'd32, 7'd34, 32'd0};//{'dest': 32, 'src': 34, 'sequence': 140350363804664, 'element_size': 2, 'op': 'memory_read'}
    instructions[354] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[355] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[356] = {6'd12, 7'd0, 7'd32, 32'd374};//{'src': 32, 'label': 374, 'op': 'jmp_if_false'}
    instructions[357] = {6'd3, 7'd34, 7'd65, 32'd0};//{'dest': 34, 'src': 65, 'op': 'move'}
    instructions[358] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[359] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[360] = {6'd8, 7'd36, 7'd34, 32'd64};//{'dest': 36, 'src': 34, 'srcb': 64, 'signed': False, 'op': '+'}
    instructions[361] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[362] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[363] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363809336, 'op': 'memory_read_request'}
    instructions[364] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[365] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363809336, 'op': 'memory_read_wait'}
    instructions[366] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363809336, 'element_size': 2, 'op': 'memory_read'}
    instructions[367] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[368] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[369] = {6'd3, 7'd61, 7'd33, 32'd0};//{'dest': 61, 'src': 33, 'op': 'move'}
    instructions[370] = {6'd1, 7'd60, 7'd0, 32'd284};//{'dest': 60, 'label': 284, 'op': 'jmp_and_link'}
    instructions[371] = {6'd3, 7'd32, 7'd65, 32'd0};//{'dest': 32, 'src': 65, 'op': 'move'}
    instructions[372] = {6'd13, 7'd65, 7'd65, 32'd1};//{'src': 65, 'right': 1, 'dest': 65, 'signed': False, 'op': '+', 'size': 2}
    instructions[373] = {6'd14, 7'd0, 7'd0, 32'd375};//{'label': 375, 'op': 'goto'}
    instructions[374] = {6'd14, 7'd0, 7'd0, 32'd376};//{'label': 376, 'op': 'goto'}
    instructions[375] = {6'd14, 7'd0, 7'd0, 32'd342};//{'label': 342, 'op': 'goto'}
    instructions[376] = {6'd6, 7'd0, 7'd63, 32'd0};//{'src': 63, 'op': 'jmp_to_reg'}
    instructions[377] = {6'd0, 7'd68, 7'd0, 32'd0};//{'dest': 68, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[378] = {6'd0, 7'd69, 7'd0, 32'd0};//{'dest': 69, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[379] = {6'd0, 7'd70, 7'd0, 32'd0};//{'dest': 70, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[380] = {6'd0, 7'd71, 7'd0, 32'd0};//{'dest': 71, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[381] = {6'd0, 7'd72, 7'd0, 32'd0};//{'dest': 72, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[382] = {6'd0, 7'd73, 7'd0, 32'd0};//{'dest': 73, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[383] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[384] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[385] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[386] = {6'd15, 7'd32, 7'd33, 32'd10000};//{'src': 33, 'right': 10000, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[387] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[388] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[389] = {6'd12, 7'd0, 7'd32, 32'd400};//{'src': 32, 'label': 400, 'op': 'jmp_if_false'}
    instructions[390] = {6'd3, 7'd32, 7'd72, 32'd0};//{'dest': 32, 'src': 72, 'op': 'move'}
    instructions[391] = {6'd13, 7'd72, 7'd72, 32'd1};//{'src': 72, 'right': 1, 'dest': 72, 'signed': False, 'op': '+', 'size': 2}
    instructions[392] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[393] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[394] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[395] = {6'd16, 7'd32, 7'd33, 32'd10000};//{'src': 33, 'right': 10000, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[396] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[397] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[398] = {6'd3, 7'd67, 7'd32, 32'd0};//{'dest': 67, 'src': 32, 'op': 'move'}
    instructions[399] = {6'd14, 7'd0, 7'd0, 32'd401};//{'label': 401, 'op': 'goto'}
    instructions[400] = {6'd14, 7'd0, 7'd0, 32'd402};//{'label': 402, 'op': 'goto'}
    instructions[401] = {6'd14, 7'd0, 7'd0, 32'd383};//{'label': 383, 'op': 'goto'}
    instructions[402] = {6'd3, 7'd33, 7'd72, 32'd0};//{'dest': 33, 'src': 72, 'op': 'move'}
    instructions[403] = {6'd3, 7'd34, 7'd73, 32'd0};//{'dest': 34, 'src': 73, 'op': 'move'}
    instructions[404] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[405] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[406] = {6'd17, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[407] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[408] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[409] = {6'd12, 7'd0, 7'd32, 32'd423};//{'src': 32, 'label': 423, 'op': 'jmp_if_false'}
    instructions[410] = {6'd3, 7'd34, 7'd72, 32'd0};//{'dest': 34, 'src': 72, 'op': 'move'}
    instructions[411] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[412] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[413] = {6'd24, 7'd33, 7'd34, 32'd48};//{'src': 34, 'dest': 33, 'signed': False, 'op': '|', 'size': 2, 'type': 'int', 'left': 48}
    instructions[414] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[415] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[416] = {6'd3, 7'd61, 7'd33, 32'd0};//{'dest': 61, 'src': 33, 'op': 'move'}
    instructions[417] = {6'd1, 7'd60, 7'd0, 32'd284};//{'dest': 60, 'label': 284, 'op': 'jmp_and_link'}
    instructions[418] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[419] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[420] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[421] = {6'd3, 7'd73, 7'd32, 32'd0};//{'dest': 73, 'src': 32, 'op': 'move'}
    instructions[422] = {6'd14, 7'd0, 7'd0, 32'd423};//{'label': 423, 'op': 'goto'}
    instructions[423] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[424] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[425] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[426] = {6'd15, 7'd32, 7'd33, 32'd1000};//{'src': 33, 'right': 1000, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[427] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[428] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[429] = {6'd12, 7'd0, 7'd32, 32'd440};//{'src': 32, 'label': 440, 'op': 'jmp_if_false'}
    instructions[430] = {6'd3, 7'd32, 7'd71, 32'd0};//{'dest': 32, 'src': 71, 'op': 'move'}
    instructions[431] = {6'd13, 7'd71, 7'd71, 32'd1};//{'src': 71, 'right': 1, 'dest': 71, 'signed': False, 'op': '+', 'size': 2}
    instructions[432] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[433] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[434] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[435] = {6'd16, 7'd32, 7'd33, 32'd1000};//{'src': 33, 'right': 1000, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[436] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[437] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[438] = {6'd3, 7'd67, 7'd32, 32'd0};//{'dest': 67, 'src': 32, 'op': 'move'}
    instructions[439] = {6'd14, 7'd0, 7'd0, 32'd441};//{'label': 441, 'op': 'goto'}
    instructions[440] = {6'd14, 7'd0, 7'd0, 32'd442};//{'label': 442, 'op': 'goto'}
    instructions[441] = {6'd14, 7'd0, 7'd0, 32'd423};//{'label': 423, 'op': 'goto'}
    instructions[442] = {6'd3, 7'd33, 7'd71, 32'd0};//{'dest': 33, 'src': 71, 'op': 'move'}
    instructions[443] = {6'd3, 7'd34, 7'd73, 32'd0};//{'dest': 34, 'src': 73, 'op': 'move'}
    instructions[444] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[445] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[446] = {6'd17, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[447] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[448] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[449] = {6'd12, 7'd0, 7'd32, 32'd463};//{'src': 32, 'label': 463, 'op': 'jmp_if_false'}
    instructions[450] = {6'd3, 7'd34, 7'd71, 32'd0};//{'dest': 34, 'src': 71, 'op': 'move'}
    instructions[451] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[452] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[453] = {6'd24, 7'd33, 7'd34, 32'd48};//{'src': 34, 'dest': 33, 'signed': False, 'op': '|', 'size': 2, 'type': 'int', 'left': 48}
    instructions[454] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[455] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[456] = {6'd3, 7'd61, 7'd33, 32'd0};//{'dest': 61, 'src': 33, 'op': 'move'}
    instructions[457] = {6'd1, 7'd60, 7'd0, 32'd284};//{'dest': 60, 'label': 284, 'op': 'jmp_and_link'}
    instructions[458] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[459] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[460] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[461] = {6'd3, 7'd73, 7'd32, 32'd0};//{'dest': 73, 'src': 32, 'op': 'move'}
    instructions[462] = {6'd14, 7'd0, 7'd0, 32'd463};//{'label': 463, 'op': 'goto'}
    instructions[463] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[464] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[465] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[466] = {6'd15, 7'd32, 7'd33, 32'd100};//{'src': 33, 'right': 100, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[467] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[468] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[469] = {6'd12, 7'd0, 7'd32, 32'd480};//{'src': 32, 'label': 480, 'op': 'jmp_if_false'}
    instructions[470] = {6'd3, 7'd32, 7'd70, 32'd0};//{'dest': 32, 'src': 70, 'op': 'move'}
    instructions[471] = {6'd13, 7'd70, 7'd70, 32'd1};//{'src': 70, 'right': 1, 'dest': 70, 'signed': False, 'op': '+', 'size': 2}
    instructions[472] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[473] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[474] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[475] = {6'd16, 7'd32, 7'd33, 32'd100};//{'src': 33, 'right': 100, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[476] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[477] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[478] = {6'd3, 7'd67, 7'd32, 32'd0};//{'dest': 67, 'src': 32, 'op': 'move'}
    instructions[479] = {6'd14, 7'd0, 7'd0, 32'd481};//{'label': 481, 'op': 'goto'}
    instructions[480] = {6'd14, 7'd0, 7'd0, 32'd482};//{'label': 482, 'op': 'goto'}
    instructions[481] = {6'd14, 7'd0, 7'd0, 32'd463};//{'label': 463, 'op': 'goto'}
    instructions[482] = {6'd3, 7'd33, 7'd70, 32'd0};//{'dest': 33, 'src': 70, 'op': 'move'}
    instructions[483] = {6'd3, 7'd34, 7'd73, 32'd0};//{'dest': 34, 'src': 73, 'op': 'move'}
    instructions[484] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[485] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[486] = {6'd17, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[487] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[488] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[489] = {6'd12, 7'd0, 7'd32, 32'd503};//{'src': 32, 'label': 503, 'op': 'jmp_if_false'}
    instructions[490] = {6'd3, 7'd34, 7'd70, 32'd0};//{'dest': 34, 'src': 70, 'op': 'move'}
    instructions[491] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[492] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[493] = {6'd24, 7'd33, 7'd34, 32'd48};//{'src': 34, 'dest': 33, 'signed': False, 'op': '|', 'size': 2, 'type': 'int', 'left': 48}
    instructions[494] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[495] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[496] = {6'd3, 7'd61, 7'd33, 32'd0};//{'dest': 61, 'src': 33, 'op': 'move'}
    instructions[497] = {6'd1, 7'd60, 7'd0, 32'd284};//{'dest': 60, 'label': 284, 'op': 'jmp_and_link'}
    instructions[498] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[499] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[500] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[501] = {6'd3, 7'd73, 7'd32, 32'd0};//{'dest': 73, 'src': 32, 'op': 'move'}
    instructions[502] = {6'd14, 7'd0, 7'd0, 32'd503};//{'label': 503, 'op': 'goto'}
    instructions[503] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[504] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[505] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[506] = {6'd15, 7'd32, 7'd33, 32'd10};//{'src': 33, 'right': 10, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[507] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[508] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[509] = {6'd12, 7'd0, 7'd32, 32'd520};//{'src': 32, 'label': 520, 'op': 'jmp_if_false'}
    instructions[510] = {6'd3, 7'd32, 7'd69, 32'd0};//{'dest': 32, 'src': 69, 'op': 'move'}
    instructions[511] = {6'd13, 7'd69, 7'd69, 32'd1};//{'src': 69, 'right': 1, 'dest': 69, 'signed': False, 'op': '+', 'size': 2}
    instructions[512] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[513] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[514] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[515] = {6'd16, 7'd32, 7'd33, 32'd10};//{'src': 33, 'right': 10, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[516] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[517] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[518] = {6'd3, 7'd67, 7'd32, 32'd0};//{'dest': 67, 'src': 32, 'op': 'move'}
    instructions[519] = {6'd14, 7'd0, 7'd0, 32'd521};//{'label': 521, 'op': 'goto'}
    instructions[520] = {6'd14, 7'd0, 7'd0, 32'd522};//{'label': 522, 'op': 'goto'}
    instructions[521] = {6'd14, 7'd0, 7'd0, 32'd503};//{'label': 503, 'op': 'goto'}
    instructions[522] = {6'd3, 7'd33, 7'd69, 32'd0};//{'dest': 33, 'src': 69, 'op': 'move'}
    instructions[523] = {6'd3, 7'd34, 7'd73, 32'd0};//{'dest': 34, 'src': 73, 'op': 'move'}
    instructions[524] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[525] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[526] = {6'd17, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[527] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[528] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[529] = {6'd12, 7'd0, 7'd32, 32'd543};//{'src': 32, 'label': 543, 'op': 'jmp_if_false'}
    instructions[530] = {6'd3, 7'd34, 7'd69, 32'd0};//{'dest': 34, 'src': 69, 'op': 'move'}
    instructions[531] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[532] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[533] = {6'd24, 7'd33, 7'd34, 32'd48};//{'src': 34, 'dest': 33, 'signed': False, 'op': '|', 'size': 2, 'type': 'int', 'left': 48}
    instructions[534] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[535] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[536] = {6'd3, 7'd61, 7'd33, 32'd0};//{'dest': 61, 'src': 33, 'op': 'move'}
    instructions[537] = {6'd1, 7'd60, 7'd0, 32'd284};//{'dest': 60, 'label': 284, 'op': 'jmp_and_link'}
    instructions[538] = {6'd0, 7'd32, 7'd0, 32'd1};//{'dest': 32, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[539] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[540] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[541] = {6'd3, 7'd73, 7'd32, 32'd0};//{'dest': 73, 'src': 32, 'op': 'move'}
    instructions[542] = {6'd14, 7'd0, 7'd0, 32'd543};//{'label': 543, 'op': 'goto'}
    instructions[543] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[544] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[545] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[546] = {6'd15, 7'd32, 7'd33, 32'd1};//{'src': 33, 'right': 1, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[547] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[548] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[549] = {6'd12, 7'd0, 7'd32, 32'd560};//{'src': 32, 'label': 560, 'op': 'jmp_if_false'}
    instructions[550] = {6'd3, 7'd32, 7'd68, 32'd0};//{'dest': 32, 'src': 68, 'op': 'move'}
    instructions[551] = {6'd13, 7'd68, 7'd68, 32'd1};//{'src': 68, 'right': 1, 'dest': 68, 'signed': False, 'op': '+', 'size': 2}
    instructions[552] = {6'd3, 7'd33, 7'd67, 32'd0};//{'dest': 33, 'src': 67, 'op': 'move'}
    instructions[553] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[554] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[555] = {6'd16, 7'd32, 7'd33, 32'd1};//{'src': 33, 'right': 1, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[556] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[557] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[558] = {6'd3, 7'd67, 7'd32, 32'd0};//{'dest': 67, 'src': 32, 'op': 'move'}
    instructions[559] = {6'd14, 7'd0, 7'd0, 32'd561};//{'label': 561, 'op': 'goto'}
    instructions[560] = {6'd14, 7'd0, 7'd0, 32'd562};//{'label': 562, 'op': 'goto'}
    instructions[561] = {6'd14, 7'd0, 7'd0, 32'd543};//{'label': 543, 'op': 'goto'}
    instructions[562] = {6'd3, 7'd34, 7'd68, 32'd0};//{'dest': 34, 'src': 68, 'op': 'move'}
    instructions[563] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[564] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[565] = {6'd24, 7'd33, 7'd34, 32'd48};//{'src': 34, 'dest': 33, 'signed': False, 'op': '|', 'size': 2, 'type': 'int', 'left': 48}
    instructions[566] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[567] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[568] = {6'd3, 7'd61, 7'd33, 32'd0};//{'dest': 61, 'src': 33, 'op': 'move'}
    instructions[569] = {6'd1, 7'd60, 7'd0, 32'd284};//{'dest': 60, 'label': 284, 'op': 'jmp_and_link'}
    instructions[570] = {6'd6, 7'd0, 7'd66, 32'd0};//{'src': 66, 'op': 'jmp_to_reg'}
    instructions[571] = {6'd0, 7'd75, 7'd0, 32'd0};//{'dest': 75, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[572] = {6'd0, 7'd76, 7'd0, 32'd4};//{'dest': 76, 'literal': 4, 'op': 'literal'}
    instructions[573] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[574] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[575] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[576] = {6'd3, 7'd75, 7'd32, 32'd0};//{'dest': 75, 'src': 32, 'op': 'move'}
    instructions[577] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[578] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[579] = {6'd3, 7'd33, 7'd75, 32'd0};//{'dest': 33, 'src': 75, 'op': 'move'}
    instructions[580] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[581] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[582] = {6'd8, 7'd34, 7'd33, 32'd76};//{'dest': 34, 'src': 33, 'srcb': 76, 'signed': False, 'op': '+'}
    instructions[583] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[584] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[585] = {6'd9, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363824352, 'op': 'memory_read_request'}
    instructions[586] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[587] = {6'd10, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363824352, 'op': 'memory_read_wait'}
    instructions[588] = {6'd11, 7'd32, 7'd34, 32'd0};//{'dest': 32, 'src': 34, 'sequence': 140350363824352, 'element_size': 2, 'op': 'memory_read'}
    instructions[589] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[590] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[591] = {6'd12, 7'd0, 7'd32, 32'd595};//{'src': 32, 'label': 595, 'op': 'jmp_if_false'}
    instructions[592] = {6'd3, 7'd32, 7'd75, 32'd0};//{'dest': 32, 'src': 75, 'op': 'move'}
    instructions[593] = {6'd13, 7'd75, 7'd75, 32'd1};//{'src': 75, 'right': 1, 'dest': 75, 'signed': False, 'op': '+', 'size': 2}
    instructions[594] = {6'd14, 7'd0, 7'd0, 32'd596};//{'label': 596, 'op': 'goto'}
    instructions[595] = {6'd14, 7'd0, 7'd0, 32'd597};//{'label': 597, 'op': 'goto'}
    instructions[596] = {6'd14, 7'd0, 7'd0, 32'd577};//{'label': 577, 'op': 'goto'}
    instructions[597] = {6'd3, 7'd33, 7'd75, 32'd0};//{'dest': 33, 'src': 75, 'op': 'move'}
    instructions[598] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[599] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[600] = {6'd3, 7'd46, 7'd33, 32'd0};//{'dest': 46, 'src': 33, 'op': 'move'}
    instructions[601] = {6'd1, 7'd45, 7'd0, 32'd4};//{'dest': 45, 'label': 4, 'op': 'jmp_and_link'}
    instructions[602] = {6'd3, 7'd37, 7'd76, 32'd0};//{'dest': 37, 'src': 76, 'op': 'move'}
    instructions[603] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[604] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[605] = {6'd3, 7'd64, 7'd37, 32'd0};//{'dest': 64, 'src': 37, 'op': 'move'}
    instructions[606] = {6'd1, 7'd63, 7'd0, 32'd341};//{'dest': 63, 'label': 341, 'op': 'jmp_and_link'}
    instructions[607] = {6'd1, 7'd62, 7'd0, 32'd323};//{'dest': 62, 'label': 323, 'op': 'jmp_and_link'}
    instructions[608] = {6'd6, 7'd0, 7'd74, 32'd0};//{'src': 74, 'op': 'jmp_to_reg'}
    instructions[609] = {6'd0, 7'd2, 7'd0, 32'd0};//{'dest': 2, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[610] = {6'd0, 7'd3, 7'd0, 32'd0};//{'dest': 3, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[611] = {6'd0, 7'd4, 7'd0, 32'd0};//{'dest': 4, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[612] = {6'd0, 7'd5, 7'd0, 32'd0};//{'dest': 5, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[613] = {6'd0, 7'd6, 7'd0, 32'd0};//{'dest': 6, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[614] = {6'd0, 7'd7, 7'd0, 32'd132};//{'dest': 7, 'literal': 132, 'op': 'literal'}
    instructions[615] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[616] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[617] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[618] = {6'd3, 7'd3, 7'd32, 32'd0};//{'dest': 3, 'src': 32, 'op': 'move'}
    instructions[619] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[620] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[621] = {6'd3, 7'd33, 7'd3, 32'd0};//{'dest': 33, 'src': 3, 'op': 'move'}
    instructions[622] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[623] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[624] = {6'd8, 7'd34, 7'd33, 32'd1};//{'dest': 34, 'src': 33, 'srcb': 1, 'signed': False, 'op': '+'}
    instructions[625] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[626] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[627] = {6'd9, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363827880, 'op': 'memory_read_request'}
    instructions[628] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[629] = {6'd10, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363827880, 'op': 'memory_read_wait'}
    instructions[630] = {6'd11, 7'd32, 7'd34, 32'd0};//{'dest': 32, 'src': 34, 'sequence': 140350363827880, 'element_size': 2, 'op': 'memory_read'}
    instructions[631] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[632] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[633] = {6'd12, 7'd0, 7'd32, 32'd637};//{'src': 32, 'label': 637, 'op': 'jmp_if_false'}
    instructions[634] = {6'd3, 7'd32, 7'd3, 32'd0};//{'dest': 32, 'src': 3, 'op': 'move'}
    instructions[635] = {6'd13, 7'd3, 7'd3, 32'd1};//{'src': 3, 'right': 1, 'dest': 3, 'signed': False, 'op': '+', 'size': 2}
    instructions[636] = {6'd14, 7'd0, 7'd0, 32'd638};//{'label': 638, 'op': 'goto'}
    instructions[637] = {6'd14, 7'd0, 7'd0, 32'd639};//{'label': 639, 'op': 'goto'}
    instructions[638] = {6'd14, 7'd0, 7'd0, 32'd619};//{'label': 619, 'op': 'goto'}
    instructions[639] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[640] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[641] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[642] = {6'd3, 7'd2, 7'd32, 32'd0};//{'dest': 2, 'src': 32, 'op': 'move'}
    instructions[643] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[644] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[645] = {6'd3, 7'd33, 7'd2, 32'd0};//{'dest': 33, 'src': 2, 'op': 'move'}
    instructions[646] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[647] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[648] = {6'd8, 7'd34, 7'd33, 32'd7};//{'dest': 34, 'src': 33, 'srcb': 7, 'signed': False, 'op': '+'}
    instructions[649] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[650] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[651] = {6'd9, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363828808, 'op': 'memory_read_request'}
    instructions[652] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[653] = {6'd10, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363828808, 'op': 'memory_read_wait'}
    instructions[654] = {6'd11, 7'd32, 7'd34, 32'd0};//{'dest': 32, 'src': 34, 'sequence': 140350363828808, 'element_size': 2, 'op': 'memory_read'}
    instructions[655] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[656] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[657] = {6'd12, 7'd0, 7'd32, 32'd661};//{'src': 32, 'label': 661, 'op': 'jmp_if_false'}
    instructions[658] = {6'd3, 7'd32, 7'd2, 32'd0};//{'dest': 32, 'src': 2, 'op': 'move'}
    instructions[659] = {6'd13, 7'd2, 7'd2, 32'd1};//{'src': 2, 'right': 1, 'dest': 2, 'signed': False, 'op': '+', 'size': 2}
    instructions[660] = {6'd14, 7'd0, 7'd0, 32'd662};//{'label': 662, 'op': 'goto'}
    instructions[661] = {6'd14, 7'd0, 7'd0, 32'd663};//{'label': 663, 'op': 'goto'}
    instructions[662] = {6'd14, 7'd0, 7'd0, 32'd643};//{'label': 643, 'op': 'goto'}
    instructions[663] = {6'd3, 7'd33, 7'd2, 32'd0};//{'dest': 33, 'src': 2, 'op': 'move'}
    instructions[664] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[665] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[666] = {6'd13, 7'd32, 7'd33, 32'd5};//{'src': 33, 'right': 5, 'dest': 32, 'signed': False, 'op': '+', 'type': 'int', 'size': 2}
    instructions[667] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[668] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[669] = {6'd3, 7'd4, 7'd32, 32'd0};//{'dest': 4, 'src': 32, 'op': 'move'}
    instructions[670] = {6'd3, 7'd33, 7'd3, 32'd0};//{'dest': 33, 'src': 3, 'op': 'move'}
    instructions[671] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[672] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[673] = {6'd25, 7'd32, 7'd33, 32'd9};//{'src': 33, 'right': 9, 'dest': 32, 'signed': False, 'op': '>', 'type': 'int', 'size': 2}
    instructions[674] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[675] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[676] = {6'd12, 7'd0, 7'd32, 32'd680};//{'src': 32, 'label': 680, 'op': 'jmp_if_false'}
    instructions[677] = {6'd3, 7'd32, 7'd4, 32'd0};//{'dest': 32, 'src': 4, 'op': 'move'}
    instructions[678] = {6'd13, 7'd4, 7'd4, 32'd1};//{'src': 4, 'right': 1, 'dest': 4, 'signed': False, 'op': '+', 'size': 2}
    instructions[679] = {6'd14, 7'd0, 7'd0, 32'd680};//{'label': 680, 'op': 'goto'}
    instructions[680] = {6'd3, 7'd33, 7'd3, 32'd0};//{'dest': 33, 'src': 3, 'op': 'move'}
    instructions[681] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[682] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[683] = {6'd25, 7'd32, 7'd33, 32'd99};//{'src': 33, 'right': 99, 'dest': 32, 'signed': False, 'op': '>', 'type': 'int', 'size': 2}
    instructions[684] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[685] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[686] = {6'd12, 7'd0, 7'd32, 32'd690};//{'src': 32, 'label': 690, 'op': 'jmp_if_false'}
    instructions[687] = {6'd3, 7'd32, 7'd4, 32'd0};//{'dest': 32, 'src': 4, 'op': 'move'}
    instructions[688] = {6'd13, 7'd4, 7'd4, 32'd1};//{'src': 4, 'right': 1, 'dest': 4, 'signed': False, 'op': '+', 'size': 2}
    instructions[689] = {6'd14, 7'd0, 7'd0, 32'd690};//{'label': 690, 'op': 'goto'}
    instructions[690] = {6'd3, 7'd33, 7'd3, 32'd0};//{'dest': 33, 'src': 3, 'op': 'move'}
    instructions[691] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[692] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[693] = {6'd25, 7'd32, 7'd33, 32'd999};//{'src': 33, 'right': 999, 'dest': 32, 'signed': False, 'op': '>', 'type': 'int', 'size': 2}
    instructions[694] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[695] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[696] = {6'd12, 7'd0, 7'd32, 32'd700};//{'src': 32, 'label': 700, 'op': 'jmp_if_false'}
    instructions[697] = {6'd3, 7'd32, 7'd4, 32'd0};//{'dest': 32, 'src': 4, 'op': 'move'}
    instructions[698] = {6'd13, 7'd4, 7'd4, 32'd1};//{'src': 4, 'right': 1, 'dest': 4, 'signed': False, 'op': '+', 'size': 2}
    instructions[699] = {6'd14, 7'd0, 7'd0, 32'd700};//{'label': 700, 'op': 'goto'}
    instructions[700] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[701] = {6'd3, 7'd33, 7'd4, 32'd0};//{'dest': 33, 'src': 4, 'op': 'move'}
    instructions[702] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[703] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[704] = {6'd3, 7'd46, 7'd33, 32'd0};//{'dest': 46, 'src': 33, 'op': 'move'}
    instructions[705] = {6'd1, 7'd45, 7'd0, 32'd4};//{'dest': 45, 'label': 4, 'op': 'jmp_and_link'}
    instructions[706] = {6'd3, 7'd38, 7'd7, 32'd0};//{'dest': 38, 'src': 7, 'op': 'move'}
    instructions[707] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[708] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[709] = {6'd3, 7'd64, 7'd38, 32'd0};//{'dest': 64, 'src': 38, 'op': 'move'}
    instructions[710] = {6'd1, 7'd63, 7'd0, 32'd341};//{'dest': 63, 'label': 341, 'op': 'jmp_and_link'}
    instructions[711] = {6'd3, 7'd33, 7'd3, 32'd0};//{'dest': 33, 'src': 3, 'op': 'move'}
    instructions[712] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[713] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[714] = {6'd3, 7'd67, 7'd33, 32'd0};//{'dest': 67, 'src': 33, 'op': 'move'}
    instructions[715] = {6'd1, 7'd66, 7'd0, 32'd377};//{'dest': 66, 'label': 377, 'op': 'jmp_and_link'}
    instructions[716] = {6'd0, 7'd8, 7'd0, 32'd246};//{'dest': 8, 'literal': 246, 'op': 'literal'}
    instructions[717] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[718] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[719] = {6'd3, 7'd39, 7'd8, 32'd0};//{'dest': 39, 'src': 8, 'op': 'move'}
    instructions[720] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[721] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[722] = {6'd3, 7'd64, 7'd39, 32'd0};//{'dest': 64, 'src': 39, 'op': 'move'}
    instructions[723] = {6'd1, 7'd63, 7'd0, 32'd341};//{'dest': 63, 'label': 341, 'op': 'jmp_and_link'}
    instructions[724] = {6'd1, 7'd62, 7'd0, 32'd323};//{'dest': 62, 'label': 323, 'op': 'jmp_and_link'}
    instructions[725] = {6'd3, 7'd32, 7'd3, 32'd0};//{'dest': 32, 'src': 3, 'op': 'move'}
    instructions[726] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[727] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[728] = {6'd3, 7'd4, 7'd32, 32'd0};//{'dest': 4, 'src': 32, 'op': 'move'}
    instructions[729] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[730] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[731] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[732] = {6'd3, 7'd5, 7'd32, 32'd0};//{'dest': 5, 'src': 32, 'op': 'move'}
    instructions[733] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[734] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[735] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[736] = {6'd3, 7'd6, 7'd32, 32'd0};//{'dest': 6, 'src': 32, 'op': 'move'}
    instructions[737] = {6'd3, 7'd33, 7'd4, 32'd0};//{'dest': 33, 'src': 4, 'op': 'move'}
    instructions[738] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[739] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[740] = {6'd15, 7'd32, 7'd33, 32'd1046};//{'src': 33, 'right': 1046, 'dest': 32, 'signed': False, 'op': '>=', 'type': 'int', 'size': 2}
    instructions[741] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[742] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[743] = {6'd12, 7'd0, 7'd32, 32'd790};//{'src': 32, 'label': 790, 'op': 'jmp_if_false'}
    instructions[744] = {6'd3, 7'd33, 7'd4, 32'd0};//{'dest': 33, 'src': 4, 'op': 'move'}
    instructions[745] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[746] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[747] = {6'd16, 7'd32, 7'd33, 32'd1046};//{'src': 33, 'right': 1046, 'dest': 32, 'signed': False, 'op': '-', 'type': 'int', 'size': 2}
    instructions[748] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[749] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[750] = {6'd3, 7'd4, 7'd32, 32'd0};//{'dest': 4, 'src': 32, 'op': 'move'}
    instructions[751] = {6'd0, 7'd33, 7'd0, 32'd1046};//{'dest': 33, 'literal': 1046, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[752] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[753] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[754] = {6'd3, 7'd46, 7'd33, 32'd0};//{'dest': 46, 'src': 33, 'op': 'move'}
    instructions[755] = {6'd1, 7'd45, 7'd0, 32'd4};//{'dest': 45, 'label': 4, 'op': 'jmp_and_link'}
    instructions[756] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[757] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[758] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[759] = {6'd3, 7'd6, 7'd32, 32'd0};//{'dest': 6, 'src': 32, 'op': 'move'}
    instructions[760] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[761] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[762] = {6'd3, 7'd33, 7'd6, 32'd0};//{'dest': 33, 'src': 6, 'op': 'move'}
    instructions[763] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[764] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[765] = {6'd26, 7'd32, 7'd33, 32'd1046};//{'src': 33, 'right': 1046, 'dest': 32, 'signed': False, 'op': '<', 'type': 'int', 'size': 2}
    instructions[766] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[767] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[768] = {6'd12, 7'd0, 7'd32, 32'd788};//{'src': 32, 'label': 788, 'op': 'jmp_if_false'}
    instructions[769] = {6'd3, 7'd34, 7'd5, 32'd0};//{'dest': 34, 'src': 5, 'op': 'move'}
    instructions[770] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[771] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[772] = {6'd8, 7'd36, 7'd34, 32'd1};//{'dest': 36, 'src': 34, 'srcb': 1, 'signed': False, 'op': '+'}
    instructions[773] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[774] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[775] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363840168, 'op': 'memory_read_request'}
    instructions[776] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[777] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363840168, 'op': 'memory_read_wait'}
    instructions[778] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363840168, 'element_size': 2, 'op': 'memory_read'}
    instructions[779] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[780] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[781] = {6'd3, 7'd61, 7'd33, 32'd0};//{'dest': 61, 'src': 33, 'op': 'move'}
    instructions[782] = {6'd1, 7'd60, 7'd0, 32'd284};//{'dest': 60, 'label': 284, 'op': 'jmp_and_link'}
    instructions[783] = {6'd3, 7'd32, 7'd5, 32'd0};//{'dest': 32, 'src': 5, 'op': 'move'}
    instructions[784] = {6'd13, 7'd5, 7'd5, 32'd1};//{'src': 5, 'right': 1, 'dest': 5, 'signed': False, 'op': '+', 'size': 2}
    instructions[785] = {6'd3, 7'd32, 7'd6, 32'd0};//{'dest': 32, 'src': 6, 'op': 'move'}
    instructions[786] = {6'd13, 7'd6, 7'd6, 32'd1};//{'src': 6, 'right': 1, 'dest': 6, 'signed': False, 'op': '+', 'size': 2}
    instructions[787] = {6'd14, 7'd0, 7'd0, 32'd760};//{'label': 760, 'op': 'goto'}
    instructions[788] = {6'd1, 7'd62, 7'd0, 32'd323};//{'dest': 62, 'label': 323, 'op': 'jmp_and_link'}
    instructions[789] = {6'd14, 7'd0, 7'd0, 32'd791};//{'label': 791, 'op': 'goto'}
    instructions[790] = {6'd14, 7'd0, 7'd0, 32'd792};//{'label': 792, 'op': 'goto'}
    instructions[791] = {6'd14, 7'd0, 7'd0, 32'd737};//{'label': 737, 'op': 'goto'}
    instructions[792] = {6'd3, 7'd33, 7'd4, 32'd0};//{'dest': 33, 'src': 4, 'op': 'move'}
    instructions[793] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[794] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[795] = {6'd3, 7'd46, 7'd33, 32'd0};//{'dest': 46, 'src': 33, 'op': 'move'}
    instructions[796] = {6'd1, 7'd45, 7'd0, 32'd4};//{'dest': 45, 'label': 4, 'op': 'jmp_and_link'}
    instructions[797] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[798] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[799] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[800] = {6'd3, 7'd6, 7'd32, 32'd0};//{'dest': 6, 'src': 32, 'op': 'move'}
    instructions[801] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[802] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[803] = {6'd3, 7'd33, 7'd6, 32'd0};//{'dest': 33, 'src': 6, 'op': 'move'}
    instructions[804] = {6'd3, 7'd34, 7'd4, 32'd0};//{'dest': 34, 'src': 4, 'op': 'move'}
    instructions[805] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[806] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[807] = {6'd27, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '<', 'type': 'int', 'size': 2}
    instructions[808] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[809] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[810] = {6'd12, 7'd0, 7'd32, 32'd830};//{'src': 32, 'label': 830, 'op': 'jmp_if_false'}
    instructions[811] = {6'd3, 7'd34, 7'd5, 32'd0};//{'dest': 34, 'src': 5, 'op': 'move'}
    instructions[812] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[813] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[814] = {6'd8, 7'd36, 7'd34, 32'd1};//{'dest': 36, 'src': 34, 'srcb': 1, 'signed': False, 'op': '+'}
    instructions[815] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[816] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[817] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363842392, 'op': 'memory_read_request'}
    instructions[818] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[819] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363842392, 'op': 'memory_read_wait'}
    instructions[820] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363842392, 'element_size': 2, 'op': 'memory_read'}
    instructions[821] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[822] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[823] = {6'd3, 7'd61, 7'd33, 32'd0};//{'dest': 61, 'src': 33, 'op': 'move'}
    instructions[824] = {6'd1, 7'd60, 7'd0, 32'd284};//{'dest': 60, 'label': 284, 'op': 'jmp_and_link'}
    instructions[825] = {6'd3, 7'd32, 7'd5, 32'd0};//{'dest': 32, 'src': 5, 'op': 'move'}
    instructions[826] = {6'd13, 7'd5, 7'd5, 32'd1};//{'src': 5, 'right': 1, 'dest': 5, 'signed': False, 'op': '+', 'size': 2}
    instructions[827] = {6'd3, 7'd32, 7'd6, 32'd0};//{'dest': 32, 'src': 6, 'op': 'move'}
    instructions[828] = {6'd13, 7'd6, 7'd6, 32'd1};//{'src': 6, 'right': 1, 'dest': 6, 'signed': False, 'op': '+', 'size': 2}
    instructions[829] = {6'd14, 7'd0, 7'd0, 32'd801};//{'label': 801, 'op': 'goto'}
    instructions[830] = {6'd1, 7'd62, 7'd0, 32'd323};//{'dest': 62, 'label': 323, 'op': 'jmp_and_link'}
    instructions[831] = {6'd6, 7'd0, 7'd0, 32'd0};//{'src': 0, 'op': 'jmp_to_reg'}
    instructions[832] = {6'd3, 7'd15, 7'd13, 32'd0};//{'dest': 15, 'src': 13, 'op': 'move'}
    instructions[833] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[834] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[835] = {6'd3, 7'd33, 7'd15, 32'd0};//{'dest': 33, 'src': 15, 'op': 'move'}
    instructions[836] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[837] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[838] = {6'd8, 7'd34, 7'd33, 32'd11};//{'dest': 34, 'src': 33, 'srcb': 11, 'signed': False, 'op': '+'}
    instructions[839] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[840] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[841] = {6'd9, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363832192, 'op': 'memory_read_request'}
    instructions[842] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[843] = {6'd10, 7'd0, 7'd34, 32'd0};//{'element_size': 2, 'src': 34, 'sequence': 140350363832192, 'op': 'memory_read_wait'}
    instructions[844] = {6'd11, 7'd32, 7'd34, 32'd0};//{'dest': 32, 'src': 34, 'sequence': 140350363832192, 'element_size': 2, 'op': 'memory_read'}
    instructions[845] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[846] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[847] = {6'd12, 7'd0, 7'd32, 32'd923};//{'src': 32, 'label': 923, 'op': 'jmp_if_false'}
    instructions[848] = {6'd3, 7'd34, 7'd15, 32'd0};//{'dest': 34, 'src': 15, 'op': 'move'}
    instructions[849] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[850] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[851] = {6'd8, 7'd36, 7'd34, 32'd11};//{'dest': 36, 'src': 34, 'srcb': 11, 'signed': False, 'op': '+'}
    instructions[852] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[853] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[854] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363844976, 'op': 'memory_read_request'}
    instructions[855] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[856] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363844976, 'op': 'memory_read_wait'}
    instructions[857] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363844976, 'element_size': 2, 'op': 'memory_read'}
    instructions[858] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[859] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[860] = {6'd3, 7'd57, 7'd33, 32'd0};//{'dest': 57, 'src': 33, 'op': 'move'}
    instructions[861] = {6'd1, 7'd56, 7'd0, 32'd257};//{'dest': 56, 'label': 257, 'op': 'jmp_and_link'}
    instructions[862] = {6'd0, 7'd16, 7'd0, 32'd253};//{'dest': 16, 'literal': 253, 'op': 'literal'}
    instructions[863] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[864] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[865] = {6'd3, 7'd35, 7'd16, 32'd0};//{'dest': 35, 'src': 16, 'op': 'move'}
    instructions[866] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[867] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[868] = {6'd3, 7'd50, 7'd35, 32'd0};//{'dest': 50, 'src': 35, 'op': 'move'}
    instructions[869] = {6'd1, 7'd49, 7'd0, 32'd14};//{'dest': 49, 'label': 14, 'op': 'jmp_and_link'}
    instructions[870] = {6'd3, 7'd33, 7'd15, 32'd0};//{'dest': 33, 'src': 15, 'op': 'move'}
    instructions[871] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[872] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[873] = {6'd3, 7'd57, 7'd33, 32'd0};//{'dest': 57, 'src': 33, 'op': 'move'}
    instructions[874] = {6'd1, 7'd56, 7'd0, 32'd257};//{'dest': 56, 'label': 257, 'op': 'jmp_and_link'}
    instructions[875] = {6'd0, 7'd17, 7'd0, 32'd255};//{'dest': 17, 'literal': 255, 'op': 'literal'}
    instructions[876] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[877] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[878] = {6'd3, 7'd35, 7'd17, 32'd0};//{'dest': 35, 'src': 17, 'op': 'move'}
    instructions[879] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[880] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[881] = {6'd3, 7'd50, 7'd35, 32'd0};//{'dest': 50, 'src': 35, 'op': 'move'}
    instructions[882] = {6'd1, 7'd49, 7'd0, 32'd14};//{'dest': 49, 'label': 14, 'op': 'jmp_and_link'}
    instructions[883] = {6'd3, 7'd33, 7'd15, 32'd0};//{'dest': 33, 'src': 15, 'op': 'move'}
    instructions[884] = {6'd3, 7'd34, 7'd14, 32'd0};//{'dest': 34, 'src': 14, 'op': 'move'}
    instructions[885] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[886] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[887] = {6'd28, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[888] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[889] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[890] = {6'd12, 7'd0, 7'd32, 32'd897};//{'src': 32, 'label': 897, 'op': 'jmp_if_false'}
    instructions[891] = {6'd0, 7'd32, 7'd0, -32'd1};//{'dest': 32, 'literal': -1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[892] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[893] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[894] = {6'd3, 7'd10, 7'd32, 32'd0};//{'dest': 10, 'src': 32, 'op': 'move'}
    instructions[895] = {6'd6, 7'd0, 7'd9, 32'd0};//{'src': 9, 'op': 'jmp_to_reg'}
    instructions[896] = {6'd14, 7'd0, 7'd0, 32'd897};//{'label': 897, 'op': 'goto'}
    instructions[897] = {6'd3, 7'd34, 7'd15, 32'd0};//{'dest': 34, 'src': 15, 'op': 'move'}
    instructions[898] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[899] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[900] = {6'd8, 7'd36, 7'd34, 32'd11};//{'dest': 36, 'src': 34, 'srcb': 11, 'signed': False, 'op': '+'}
    instructions[901] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[902] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[903] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363831976, 'op': 'memory_read_request'}
    instructions[904] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[905] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363831976, 'op': 'memory_read_wait'}
    instructions[906] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363831976, 'element_size': 2, 'op': 'memory_read'}
    instructions[907] = {6'd3, 7'd34, 7'd12, 32'd0};//{'dest': 34, 'src': 12, 'op': 'move'}
    instructions[908] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[909] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[910] = {6'd28, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[911] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[912] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[913] = {6'd12, 7'd0, 7'd32, 32'd920};//{'src': 32, 'label': 920, 'op': 'jmp_if_false'}
    instructions[914] = {6'd3, 7'd32, 7'd15, 32'd0};//{'dest': 32, 'src': 15, 'op': 'move'}
    instructions[915] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[916] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[917] = {6'd3, 7'd10, 7'd32, 32'd0};//{'dest': 10, 'src': 32, 'op': 'move'}
    instructions[918] = {6'd6, 7'd0, 7'd9, 32'd0};//{'src': 9, 'op': 'jmp_to_reg'}
    instructions[919] = {6'd14, 7'd0, 7'd0, 32'd920};//{'label': 920, 'op': 'goto'}
    instructions[920] = {6'd3, 7'd32, 7'd15, 32'd0};//{'dest': 32, 'src': 15, 'op': 'move'}
    instructions[921] = {6'd29, 7'd15, 7'd15, 32'd1};//{'src': 15, 'right': 1, 'dest': 15, 'signed': True, 'op': '+', 'size': 2}
    instructions[922] = {6'd14, 7'd0, 7'd0, 32'd924};//{'label': 924, 'op': 'goto'}
    instructions[923] = {6'd14, 7'd0, 7'd0, 32'd925};//{'label': 925, 'op': 'goto'}
    instructions[924] = {6'd14, 7'd0, 7'd0, 32'd833};//{'label': 833, 'op': 'goto'}
    instructions[925] = {6'd0, 7'd32, 7'd0, -32'd1};//{'dest': 32, 'literal': -1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[926] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[927] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[928] = {6'd3, 7'd10, 7'd32, 32'd0};//{'dest': 10, 'src': 32, 'op': 'move'}
    instructions[929] = {6'd6, 7'd0, 7'd9, 32'd0};//{'src': 9, 'op': 'jmp_to_reg'}
    instructions[930] = {6'd0, 7'd19, 7'd0, 32'd0};//{'dest': 19, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[931] = {6'd0, 7'd20, 7'd0, 32'd0};//{'dest': 20, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[932] = {6'd0, 7'd21, 7'd0, 32'd0};//{'dest': 21, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[933] = {6'd0, 7'd22, 7'd0, 32'd257};//{'dest': 22, 'literal': 257, 'op': 'literal'}
    instructions[934] = {6'd0, 7'd23, 7'd0, 32'd0};//{'dest': 23, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[935] = {6'd0, 7'd24, 7'd0, 32'd0};//{'dest': 24, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[936] = {6'd0, 7'd25, 7'd0, 32'd0};//{'dest': 25, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[937] = {6'd0, 7'd26, 7'd0, 32'd0};//{'dest': 26, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[938] = {6'd0, 7'd27, 7'd0, 32'd0};//{'dest': 27, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[939] = {6'd0, 7'd28, 7'd0, 32'd0};//{'dest': 28, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[940] = {6'd0, 7'd29, 7'd0, 32'd1717};//{'dest': 29, 'literal': 1717, 'op': 'literal'}
    instructions[941] = {6'd0, 7'd30, 7'd0, 32'd2597};//{'dest': 30, 'literal': 2597, 'op': 'literal'}
    instructions[942] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[943] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[944] = {6'd3, 7'd40, 7'd30, 32'd0};//{'dest': 40, 'src': 30, 'op': 'move'}
    instructions[945] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[946] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[947] = {6'd3, 7'd50, 7'd40, 32'd0};//{'dest': 50, 'src': 40, 'op': 'move'}
    instructions[948] = {6'd1, 7'd49, 7'd0, 32'd14};//{'dest': 49, 'label': 14, 'op': 'jmp_and_link'}
    instructions[949] = {6'd0, 7'd31, 7'd0, 32'd2635};//{'dest': 31, 'literal': 2635, 'op': 'literal'}
    instructions[950] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[951] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[952] = {6'd3, 7'd41, 7'd31, 32'd0};//{'dest': 41, 'src': 31, 'op': 'move'}
    instructions[953] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[954] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[955] = {6'd3, 7'd50, 7'd41, 32'd0};//{'dest': 50, 'src': 41, 'op': 'move'}
    instructions[956] = {6'd1, 7'd49, 7'd0, 32'd14};//{'dest': 49, 'label': 14, 'op': 'jmp_and_link'}
    instructions[957] = {6'd30, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'input': 'socket', 'op': 'read'}
    instructions[958] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[959] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[960] = {6'd3, 7'd19, 7'd32, 32'd0};//{'dest': 19, 'src': 32, 'op': 'move'}
    instructions[961] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[962] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[963] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[964] = {6'd3, 7'd21, 7'd32, 32'd0};//{'dest': 21, 'src': 32, 'op': 'move'}
    instructions[965] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[966] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[967] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[968] = {6'd3, 7'd20, 7'd32, 32'd0};//{'dest': 20, 'src': 32, 'op': 'move'}
    instructions[969] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[970] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[971] = {6'd3, 7'd33, 7'd20, 32'd0};//{'dest': 33, 'src': 20, 'op': 'move'}
    instructions[972] = {6'd3, 7'd34, 7'd19, 32'd0};//{'dest': 34, 'src': 19, 'op': 'move'}
    instructions[973] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[974] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[975] = {6'd27, 7'd32, 7'd33, 32'd34};//{'srcb': 34, 'src': 33, 'dest': 32, 'signed': False, 'op': '<', 'type': 'int', 'size': 2}
    instructions[976] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[977] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[978] = {6'd12, 7'd0, 7'd32, 32'd1022};//{'src': 32, 'label': 1022, 'op': 'jmp_if_false'}
    instructions[979] = {6'd30, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'input': 'socket', 'op': 'read'}
    instructions[980] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[981] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[982] = {6'd3, 7'd23, 7'd32, 32'd0};//{'dest': 23, 'src': 32, 'op': 'move'}
    instructions[983] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[984] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[985] = {6'd3, 7'd42, 7'd23, 32'd0};//{'dest': 42, 'src': 23, 'op': 'move'}
    instructions[986] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[987] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[988] = {6'd31, 7'd36, 7'd42, 32'd8};//{'src': 42, 'right': 8, 'dest': 36, 'signed': False, 'op': '>>', 'type': 'int', 'size': 2}
    instructions[989] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[990] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[991] = {6'd32, 7'd32, 7'd36, 32'd255};//{'src': 36, 'right': 255, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[992] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[993] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[994] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[995] = {6'd8, 7'd34, 7'd33, 32'd22};//{'dest': 34, 'src': 33, 'srcb': 22, 'signed': False, 'op': '+'}
    instructions[996] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[997] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[998] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[999] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1000] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1001] = {6'd3, 7'd36, 7'd23, 32'd0};//{'dest': 36, 'src': 23, 'op': 'move'}
    instructions[1002] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1003] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1004] = {6'd32, 7'd32, 7'd36, 32'd255};//{'src': 36, 'right': 255, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1005] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1006] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1007] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1008] = {6'd8, 7'd34, 7'd33, 32'd22};//{'dest': 34, 'src': 33, 'srcb': 22, 'signed': False, 'op': '+'}
    instructions[1009] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1010] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1011] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1012] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1013] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1014] = {6'd3, 7'd33, 7'd20, 32'd0};//{'dest': 33, 'src': 20, 'op': 'move'}
    instructions[1015] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1016] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1017] = {6'd13, 7'd32, 7'd33, 32'd2};//{'src': 33, 'right': 2, 'dest': 32, 'signed': False, 'op': '+', 'type': 'int', 'size': 2}
    instructions[1018] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1019] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1020] = {6'd3, 7'd20, 7'd32, 32'd0};//{'dest': 20, 'src': 32, 'op': 'move'}
    instructions[1021] = {6'd14, 7'd0, 7'd0, 32'd969};//{'label': 969, 'op': 'goto'}
    instructions[1022] = {6'd0, 7'd34, 7'd0, 32'd0};//{'dest': 34, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1023] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1024] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1025] = {6'd8, 7'd36, 7'd34, 32'd22};//{'dest': 36, 'src': 34, 'srcb': 22, 'signed': False, 'op': '+'}
    instructions[1026] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1027] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1028] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363851736, 'op': 'memory_read_request'}
    instructions[1029] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1030] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363851736, 'op': 'memory_read_wait'}
    instructions[1031] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363851736, 'element_size': 2, 'op': 'memory_read'}
    instructions[1032] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1033] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1034] = {6'd23, 7'd32, 7'd33, 32'd71};//{'src': 33, 'right': 71, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[1035] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1036] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1037] = {6'd12, 7'd0, 7'd32, 32'd1051};//{'src': 32, 'label': 1051, 'op': 'jmp_if_false'}
    instructions[1038] = {6'd0, 7'd34, 7'd0, 32'd1};//{'dest': 34, 'literal': 1, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1039] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1040] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1041] = {6'd8, 7'd36, 7'd34, 32'd22};//{'dest': 36, 'src': 34, 'srcb': 22, 'signed': False, 'op': '+'}
    instructions[1042] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1043] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1044] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363852024, 'op': 'memory_read_request'}
    instructions[1045] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1046] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363852024, 'op': 'memory_read_wait'}
    instructions[1047] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363852024, 'element_size': 2, 'op': 'memory_read'}
    instructions[1048] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1049] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1050] = {6'd23, 7'd32, 7'd33, 32'd69};//{'src': 33, 'right': 69, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[1051] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1052] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1053] = {6'd12, 7'd0, 7'd32, 32'd1067};//{'src': 32, 'label': 1067, 'op': 'jmp_if_false'}
    instructions[1054] = {6'd0, 7'd34, 7'd0, 32'd2};//{'dest': 34, 'literal': 2, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1055] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1056] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1057] = {6'd8, 7'd36, 7'd34, 32'd22};//{'dest': 36, 'src': 34, 'srcb': 22, 'signed': False, 'op': '+'}
    instructions[1058] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1059] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1060] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363852384, 'op': 'memory_read_request'}
    instructions[1061] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1062] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363852384, 'op': 'memory_read_wait'}
    instructions[1063] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363852384, 'element_size': 2, 'op': 'memory_read'}
    instructions[1064] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1065] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1066] = {6'd23, 7'd32, 7'd33, 32'd84};//{'src': 33, 'right': 84, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[1067] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1068] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1069] = {6'd12, 7'd0, 7'd32, 32'd1083};//{'src': 32, 'label': 1083, 'op': 'jmp_if_false'}
    instructions[1070] = {6'd0, 7'd34, 7'd0, 32'd3};//{'dest': 34, 'literal': 3, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1071] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1072] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1073] = {6'd8, 7'd36, 7'd34, 32'd22};//{'dest': 36, 'src': 34, 'srcb': 22, 'signed': False, 'op': '+'}
    instructions[1074] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1075] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1076] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363852744, 'op': 'memory_read_request'}
    instructions[1077] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1078] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363852744, 'op': 'memory_read_wait'}
    instructions[1079] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363852744, 'element_size': 2, 'op': 'memory_read'}
    instructions[1080] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1081] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1082] = {6'd23, 7'd32, 7'd33, 32'd32};//{'src': 33, 'right': 32, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[1083] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1084] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1085] = {6'd12, 7'd0, 7'd32, 32'd1099};//{'src': 32, 'label': 1099, 'op': 'jmp_if_false'}
    instructions[1086] = {6'd0, 7'd34, 7'd0, 32'd4};//{'dest': 34, 'literal': 4, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1087] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1088] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1089] = {6'd8, 7'd36, 7'd34, 32'd22};//{'dest': 36, 'src': 34, 'srcb': 22, 'signed': False, 'op': '+'}
    instructions[1090] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1091] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1092] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350364164464, 'op': 'memory_read_request'}
    instructions[1093] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1094] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350364164464, 'op': 'memory_read_wait'}
    instructions[1095] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350364164464, 'element_size': 2, 'op': 'memory_read'}
    instructions[1096] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1097] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1098] = {6'd23, 7'd32, 7'd33, 32'd47};//{'src': 33, 'right': 47, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[1099] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1100] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1101] = {6'd12, 7'd0, 7'd32, 32'd1131};//{'src': 32, 'label': 1131, 'op': 'jmp_if_false'}
    instructions[1102] = {6'd0, 7'd34, 7'd0, 32'd5};//{'dest': 34, 'literal': 5, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1103] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1104] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1105] = {6'd8, 7'd36, 7'd34, 32'd22};//{'dest': 36, 'src': 34, 'srcb': 22, 'signed': False, 'op': '+'}
    instructions[1106] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1107] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1108] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363853672, 'op': 'memory_read_request'}
    instructions[1109] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1110] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363853672, 'op': 'memory_read_wait'}
    instructions[1111] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363853672, 'element_size': 2, 'op': 'memory_read'}
    instructions[1112] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1113] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1114] = {6'd23, 7'd32, 7'd33, 32'd63};//{'src': 33, 'right': 63, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[1115] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1116] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1117] = {6'd34, 7'd0, 7'd32, 32'd1131};//{'src': 32, 'label': 1131, 'op': 'jmp_if_true'}
    instructions[1118] = {6'd0, 7'd34, 7'd0, 32'd5};//{'dest': 34, 'literal': 5, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1119] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1120] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1121] = {6'd8, 7'd36, 7'd34, 32'd22};//{'dest': 36, 'src': 34, 'srcb': 22, 'signed': False, 'op': '+'}
    instructions[1122] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1123] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1124] = {6'd9, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363853960, 'op': 'memory_read_request'}
    instructions[1125] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1126] = {6'd10, 7'd0, 7'd36, 32'd0};//{'element_size': 2, 'src': 36, 'sequence': 140350363853960, 'op': 'memory_read_wait'}
    instructions[1127] = {6'd11, 7'd33, 7'd36, 32'd0};//{'dest': 33, 'src': 36, 'sequence': 140350363853960, 'element_size': 2, 'op': 'memory_read'}
    instructions[1128] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1129] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1130] = {6'd23, 7'd32, 7'd33, 32'd32};//{'src': 33, 'right': 32, 'dest': 32, 'signed': False, 'op': '==', 'type': 'int', 'size': 2}
    instructions[1131] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1132] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1133] = {6'd12, 7'd0, 7'd32, 32'd1815};//{'src': 32, 'label': 1815, 'op': 'jmp_if_false'}
    instructions[1134] = {6'd0, 7'd32, 7'd0, 32'd5};//{'dest': 32, 'literal': 5, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1135] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1136] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1137] = {6'd3, 7'd27, 7'd32, 32'd0};//{'dest': 27, 'src': 32, 'op': 'move'}
    instructions[1138] = {6'd3, 7'd43, 7'd22, 32'd0};//{'dest': 43, 'src': 22, 'op': 'move'}
    instructions[1139] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1140] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1141] = {6'd3, 7'd11, 7'd43, 32'd0};//{'dest': 11, 'src': 43, 'op': 'move'}
    instructions[1142] = {6'd0, 7'd33, 7'd0, 32'd32};//{'dest': 33, 'literal': 32, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1143] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1144] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1145] = {6'd3, 7'd12, 7'd33, 32'd0};//{'dest': 12, 'src': 33, 'op': 'move'}
    instructions[1146] = {6'd3, 7'd33, 7'd27, 32'd0};//{'dest': 33, 'src': 27, 'op': 'move'}
    instructions[1147] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1148] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1149] = {6'd3, 7'd13, 7'd33, 32'd0};//{'dest': 13, 'src': 33, 'op': 'move'}
    instructions[1150] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1151] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1152] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1153] = {6'd3, 7'd14, 7'd33, 32'd0};//{'dest': 14, 'src': 33, 'op': 'move'}
    instructions[1154] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1155] = {6'd3, 7'd32, 7'd10, 32'd0};//{'dest': 32, 'src': 10, 'op': 'move'}
    instructions[1156] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1157] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1158] = {6'd3, 7'd28, 7'd32, 32'd0};//{'dest': 28, 'src': 32, 'op': 'move'}
    instructions[1159] = {6'd0, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1160] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1161] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1162] = {6'd3, 7'd26, 7'd32, 32'd0};//{'dest': 26, 'src': 32, 'op': 'move'}
    instructions[1163] = {6'd3, 7'd43, 7'd22, 32'd0};//{'dest': 43, 'src': 22, 'op': 'move'}
    instructions[1164] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1165] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1166] = {6'd3, 7'd11, 7'd43, 32'd0};//{'dest': 11, 'src': 43, 'op': 'move'}
    instructions[1167] = {6'd0, 7'd34, 7'd0, 32'd65};//{'dest': 34, 'literal': 65, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1168] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1169] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1170] = {6'd3, 7'd12, 7'd34, 32'd0};//{'dest': 12, 'src': 34, 'op': 'move'}
    instructions[1171] = {6'd3, 7'd34, 7'd27, 32'd0};//{'dest': 34, 'src': 27, 'op': 'move'}
    instructions[1172] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1173] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1174] = {6'd3, 7'd13, 7'd34, 32'd0};//{'dest': 13, 'src': 34, 'op': 'move'}
    instructions[1175] = {6'd3, 7'd34, 7'd28, 32'd0};//{'dest': 34, 'src': 28, 'op': 'move'}
    instructions[1176] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1177] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1178] = {6'd3, 7'd14, 7'd34, 32'd0};//{'dest': 14, 'src': 34, 'op': 'move'}
    instructions[1179] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1180] = {6'd3, 7'd33, 7'd10, 32'd0};//{'dest': 33, 'src': 10, 'op': 'move'}
    instructions[1181] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1182] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1183] = {6'd35, 7'd32, 7'd33, -32'd1};//{'src': 33, 'right': -1, 'dest': 32, 'signed': True, 'op': '!=', 'type': 'int', 'size': 2}
    instructions[1184] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1185] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1186] = {6'd12, 7'd0, 7'd32, 32'd1195};//{'src': 32, 'label': 1195, 'op': 'jmp_if_false'}
    instructions[1187] = {6'd3, 7'd33, 7'd26, 32'd0};//{'dest': 33, 'src': 26, 'op': 'move'}
    instructions[1188] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1189] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1190] = {6'd18, 7'd32, 7'd33, 32'd1};//{'src': 33, 'right': 1, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[1191] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1192] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1193] = {6'd3, 7'd26, 7'd32, 32'd0};//{'dest': 26, 'src': 32, 'op': 'move'}
    instructions[1194] = {6'd14, 7'd0, 7'd0, 32'd1195};//{'label': 1195, 'op': 'goto'}
    instructions[1195] = {6'd3, 7'd43, 7'd22, 32'd0};//{'dest': 43, 'src': 22, 'op': 'move'}
    instructions[1196] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1197] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1198] = {6'd3, 7'd11, 7'd43, 32'd0};//{'dest': 11, 'src': 43, 'op': 'move'}
    instructions[1199] = {6'd0, 7'd34, 7'd0, 32'd66};//{'dest': 34, 'literal': 66, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1200] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1201] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1202] = {6'd3, 7'd12, 7'd34, 32'd0};//{'dest': 12, 'src': 34, 'op': 'move'}
    instructions[1203] = {6'd3, 7'd34, 7'd27, 32'd0};//{'dest': 34, 'src': 27, 'op': 'move'}
    instructions[1204] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1205] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1206] = {6'd3, 7'd13, 7'd34, 32'd0};//{'dest': 13, 'src': 34, 'op': 'move'}
    instructions[1207] = {6'd3, 7'd34, 7'd28, 32'd0};//{'dest': 34, 'src': 28, 'op': 'move'}
    instructions[1208] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1209] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1210] = {6'd3, 7'd14, 7'd34, 32'd0};//{'dest': 14, 'src': 34, 'op': 'move'}
    instructions[1211] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1212] = {6'd3, 7'd33, 7'd10, 32'd0};//{'dest': 33, 'src': 10, 'op': 'move'}
    instructions[1213] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1214] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1215] = {6'd35, 7'd32, 7'd33, -32'd1};//{'src': 33, 'right': -1, 'dest': 32, 'signed': True, 'op': '!=', 'type': 'int', 'size': 2}
    instructions[1216] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1217] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1218] = {6'd12, 7'd0, 7'd32, 32'd1227};//{'src': 32, 'label': 1227, 'op': 'jmp_if_false'}
    instructions[1219] = {6'd3, 7'd33, 7'd26, 32'd0};//{'dest': 33, 'src': 26, 'op': 'move'}
    instructions[1220] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1221] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1222] = {6'd18, 7'd32, 7'd33, 32'd2};//{'src': 33, 'right': 2, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[1223] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1224] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1225] = {6'd3, 7'd26, 7'd32, 32'd0};//{'dest': 26, 'src': 32, 'op': 'move'}
    instructions[1226] = {6'd14, 7'd0, 7'd0, 32'd1227};//{'label': 1227, 'op': 'goto'}
    instructions[1227] = {6'd3, 7'd43, 7'd22, 32'd0};//{'dest': 43, 'src': 22, 'op': 'move'}
    instructions[1228] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1229] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1230] = {6'd3, 7'd11, 7'd43, 32'd0};//{'dest': 11, 'src': 43, 'op': 'move'}
    instructions[1231] = {6'd0, 7'd34, 7'd0, 32'd67};//{'dest': 34, 'literal': 67, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1232] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1233] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1234] = {6'd3, 7'd12, 7'd34, 32'd0};//{'dest': 12, 'src': 34, 'op': 'move'}
    instructions[1235] = {6'd3, 7'd34, 7'd27, 32'd0};//{'dest': 34, 'src': 27, 'op': 'move'}
    instructions[1236] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1237] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1238] = {6'd3, 7'd13, 7'd34, 32'd0};//{'dest': 13, 'src': 34, 'op': 'move'}
    instructions[1239] = {6'd3, 7'd34, 7'd28, 32'd0};//{'dest': 34, 'src': 28, 'op': 'move'}
    instructions[1240] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1241] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1242] = {6'd3, 7'd14, 7'd34, 32'd0};//{'dest': 14, 'src': 34, 'op': 'move'}
    instructions[1243] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1244] = {6'd3, 7'd33, 7'd10, 32'd0};//{'dest': 33, 'src': 10, 'op': 'move'}
    instructions[1245] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1246] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1247] = {6'd35, 7'd32, 7'd33, -32'd1};//{'src': 33, 'right': -1, 'dest': 32, 'signed': True, 'op': '!=', 'type': 'int', 'size': 2}
    instructions[1248] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1249] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1250] = {6'd12, 7'd0, 7'd32, 32'd1259};//{'src': 32, 'label': 1259, 'op': 'jmp_if_false'}
    instructions[1251] = {6'd3, 7'd33, 7'd26, 32'd0};//{'dest': 33, 'src': 26, 'op': 'move'}
    instructions[1252] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1253] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1254] = {6'd18, 7'd32, 7'd33, 32'd4};//{'src': 33, 'right': 4, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[1255] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1256] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1257] = {6'd3, 7'd26, 7'd32, 32'd0};//{'dest': 26, 'src': 32, 'op': 'move'}
    instructions[1258] = {6'd14, 7'd0, 7'd0, 32'd1259};//{'label': 1259, 'op': 'goto'}
    instructions[1259] = {6'd3, 7'd43, 7'd22, 32'd0};//{'dest': 43, 'src': 22, 'op': 'move'}
    instructions[1260] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1261] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1262] = {6'd3, 7'd11, 7'd43, 32'd0};//{'dest': 11, 'src': 43, 'op': 'move'}
    instructions[1263] = {6'd0, 7'd34, 7'd0, 32'd68};//{'dest': 34, 'literal': 68, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1264] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1265] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1266] = {6'd3, 7'd12, 7'd34, 32'd0};//{'dest': 12, 'src': 34, 'op': 'move'}
    instructions[1267] = {6'd3, 7'd34, 7'd27, 32'd0};//{'dest': 34, 'src': 27, 'op': 'move'}
    instructions[1268] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1269] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1270] = {6'd3, 7'd13, 7'd34, 32'd0};//{'dest': 13, 'src': 34, 'op': 'move'}
    instructions[1271] = {6'd3, 7'd34, 7'd28, 32'd0};//{'dest': 34, 'src': 28, 'op': 'move'}
    instructions[1272] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1273] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1274] = {6'd3, 7'd14, 7'd34, 32'd0};//{'dest': 14, 'src': 34, 'op': 'move'}
    instructions[1275] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1276] = {6'd3, 7'd33, 7'd10, 32'd0};//{'dest': 33, 'src': 10, 'op': 'move'}
    instructions[1277] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1278] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1279] = {6'd35, 7'd32, 7'd33, -32'd1};//{'src': 33, 'right': -1, 'dest': 32, 'signed': True, 'op': '!=', 'type': 'int', 'size': 2}
    instructions[1280] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1281] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1282] = {6'd12, 7'd0, 7'd32, 32'd1291};//{'src': 32, 'label': 1291, 'op': 'jmp_if_false'}
    instructions[1283] = {6'd3, 7'd33, 7'd26, 32'd0};//{'dest': 33, 'src': 26, 'op': 'move'}
    instructions[1284] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1285] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1286] = {6'd18, 7'd32, 7'd33, 32'd8};//{'src': 33, 'right': 8, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[1287] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1288] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1289] = {6'd3, 7'd26, 7'd32, 32'd0};//{'dest': 26, 'src': 32, 'op': 'move'}
    instructions[1290] = {6'd14, 7'd0, 7'd0, 32'd1291};//{'label': 1291, 'op': 'goto'}
    instructions[1291] = {6'd3, 7'd43, 7'd22, 32'd0};//{'dest': 43, 'src': 22, 'op': 'move'}
    instructions[1292] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1293] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1294] = {6'd3, 7'd11, 7'd43, 32'd0};//{'dest': 11, 'src': 43, 'op': 'move'}
    instructions[1295] = {6'd0, 7'd34, 7'd0, 32'd69};//{'dest': 34, 'literal': 69, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1296] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1297] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1298] = {6'd3, 7'd12, 7'd34, 32'd0};//{'dest': 12, 'src': 34, 'op': 'move'}
    instructions[1299] = {6'd3, 7'd34, 7'd27, 32'd0};//{'dest': 34, 'src': 27, 'op': 'move'}
    instructions[1300] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1301] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1302] = {6'd3, 7'd13, 7'd34, 32'd0};//{'dest': 13, 'src': 34, 'op': 'move'}
    instructions[1303] = {6'd3, 7'd34, 7'd28, 32'd0};//{'dest': 34, 'src': 28, 'op': 'move'}
    instructions[1304] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1305] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1306] = {6'd3, 7'd14, 7'd34, 32'd0};//{'dest': 14, 'src': 34, 'op': 'move'}
    instructions[1307] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1308] = {6'd3, 7'd33, 7'd10, 32'd0};//{'dest': 33, 'src': 10, 'op': 'move'}
    instructions[1309] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1310] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1311] = {6'd35, 7'd32, 7'd33, -32'd1};//{'src': 33, 'right': -1, 'dest': 32, 'signed': True, 'op': '!=', 'type': 'int', 'size': 2}
    instructions[1312] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1313] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1314] = {6'd12, 7'd0, 7'd32, 32'd1323};//{'src': 32, 'label': 1323, 'op': 'jmp_if_false'}
    instructions[1315] = {6'd3, 7'd33, 7'd26, 32'd0};//{'dest': 33, 'src': 26, 'op': 'move'}
    instructions[1316] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1317] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1318] = {6'd18, 7'd32, 7'd33, 32'd16};//{'src': 33, 'right': 16, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[1319] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1320] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1321] = {6'd3, 7'd26, 7'd32, 32'd0};//{'dest': 26, 'src': 32, 'op': 'move'}
    instructions[1322] = {6'd14, 7'd0, 7'd0, 32'd1323};//{'label': 1323, 'op': 'goto'}
    instructions[1323] = {6'd3, 7'd43, 7'd22, 32'd0};//{'dest': 43, 'src': 22, 'op': 'move'}
    instructions[1324] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1325] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1326] = {6'd3, 7'd11, 7'd43, 32'd0};//{'dest': 11, 'src': 43, 'op': 'move'}
    instructions[1327] = {6'd0, 7'd34, 7'd0, 32'd70};//{'dest': 34, 'literal': 70, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1328] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1329] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1330] = {6'd3, 7'd12, 7'd34, 32'd0};//{'dest': 12, 'src': 34, 'op': 'move'}
    instructions[1331] = {6'd3, 7'd34, 7'd27, 32'd0};//{'dest': 34, 'src': 27, 'op': 'move'}
    instructions[1332] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1333] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1334] = {6'd3, 7'd13, 7'd34, 32'd0};//{'dest': 13, 'src': 34, 'op': 'move'}
    instructions[1335] = {6'd3, 7'd34, 7'd28, 32'd0};//{'dest': 34, 'src': 28, 'op': 'move'}
    instructions[1336] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1337] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1338] = {6'd3, 7'd14, 7'd34, 32'd0};//{'dest': 14, 'src': 34, 'op': 'move'}
    instructions[1339] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1340] = {6'd3, 7'd33, 7'd10, 32'd0};//{'dest': 33, 'src': 10, 'op': 'move'}
    instructions[1341] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1342] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1343] = {6'd35, 7'd32, 7'd33, -32'd1};//{'src': 33, 'right': -1, 'dest': 32, 'signed': True, 'op': '!=', 'type': 'int', 'size': 2}
    instructions[1344] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1345] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1346] = {6'd12, 7'd0, 7'd32, 32'd1355};//{'src': 32, 'label': 1355, 'op': 'jmp_if_false'}
    instructions[1347] = {6'd3, 7'd33, 7'd26, 32'd0};//{'dest': 33, 'src': 26, 'op': 'move'}
    instructions[1348] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1349] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1350] = {6'd18, 7'd32, 7'd33, 32'd32};//{'src': 33, 'right': 32, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[1351] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1352] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1353] = {6'd3, 7'd26, 7'd32, 32'd0};//{'dest': 26, 'src': 32, 'op': 'move'}
    instructions[1354] = {6'd14, 7'd0, 7'd0, 32'd1355};//{'label': 1355, 'op': 'goto'}
    instructions[1355] = {6'd3, 7'd43, 7'd22, 32'd0};//{'dest': 43, 'src': 22, 'op': 'move'}
    instructions[1356] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1357] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1358] = {6'd3, 7'd11, 7'd43, 32'd0};//{'dest': 11, 'src': 43, 'op': 'move'}
    instructions[1359] = {6'd0, 7'd34, 7'd0, 32'd71};//{'dest': 34, 'literal': 71, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1360] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1361] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1362] = {6'd3, 7'd12, 7'd34, 32'd0};//{'dest': 12, 'src': 34, 'op': 'move'}
    instructions[1363] = {6'd3, 7'd34, 7'd27, 32'd0};//{'dest': 34, 'src': 27, 'op': 'move'}
    instructions[1364] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1365] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1366] = {6'd3, 7'd13, 7'd34, 32'd0};//{'dest': 13, 'src': 34, 'op': 'move'}
    instructions[1367] = {6'd3, 7'd34, 7'd28, 32'd0};//{'dest': 34, 'src': 28, 'op': 'move'}
    instructions[1368] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1369] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1370] = {6'd3, 7'd14, 7'd34, 32'd0};//{'dest': 14, 'src': 34, 'op': 'move'}
    instructions[1371] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1372] = {6'd3, 7'd33, 7'd10, 32'd0};//{'dest': 33, 'src': 10, 'op': 'move'}
    instructions[1373] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1374] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1375] = {6'd35, 7'd32, 7'd33, -32'd1};//{'src': 33, 'right': -1, 'dest': 32, 'signed': True, 'op': '!=', 'type': 'int', 'size': 2}
    instructions[1376] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1377] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1378] = {6'd12, 7'd0, 7'd32, 32'd1387};//{'src': 32, 'label': 1387, 'op': 'jmp_if_false'}
    instructions[1379] = {6'd3, 7'd33, 7'd26, 32'd0};//{'dest': 33, 'src': 26, 'op': 'move'}
    instructions[1380] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1381] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1382] = {6'd18, 7'd32, 7'd33, 32'd64};//{'src': 33, 'right': 64, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[1383] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1384] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1385] = {6'd3, 7'd26, 7'd32, 32'd0};//{'dest': 26, 'src': 32, 'op': 'move'}
    instructions[1386] = {6'd14, 7'd0, 7'd0, 32'd1387};//{'label': 1387, 'op': 'goto'}
    instructions[1387] = {6'd3, 7'd43, 7'd22, 32'd0};//{'dest': 43, 'src': 22, 'op': 'move'}
    instructions[1388] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1389] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1390] = {6'd3, 7'd11, 7'd43, 32'd0};//{'dest': 11, 'src': 43, 'op': 'move'}
    instructions[1391] = {6'd0, 7'd34, 7'd0, 32'd72};//{'dest': 34, 'literal': 72, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1392] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1393] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1394] = {6'd3, 7'd12, 7'd34, 32'd0};//{'dest': 12, 'src': 34, 'op': 'move'}
    instructions[1395] = {6'd3, 7'd34, 7'd27, 32'd0};//{'dest': 34, 'src': 27, 'op': 'move'}
    instructions[1396] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1397] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1398] = {6'd3, 7'd13, 7'd34, 32'd0};//{'dest': 13, 'src': 34, 'op': 'move'}
    instructions[1399] = {6'd3, 7'd34, 7'd28, 32'd0};//{'dest': 34, 'src': 28, 'op': 'move'}
    instructions[1400] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1401] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1402] = {6'd3, 7'd14, 7'd34, 32'd0};//{'dest': 14, 'src': 34, 'op': 'move'}
    instructions[1403] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1404] = {6'd3, 7'd33, 7'd10, 32'd0};//{'dest': 33, 'src': 10, 'op': 'move'}
    instructions[1405] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1406] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1407] = {6'd35, 7'd32, 7'd33, -32'd1};//{'src': 33, 'right': -1, 'dest': 32, 'signed': True, 'op': '!=', 'type': 'int', 'size': 2}
    instructions[1408] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1409] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1410] = {6'd12, 7'd0, 7'd32, 32'd1419};//{'src': 32, 'label': 1419, 'op': 'jmp_if_false'}
    instructions[1411] = {6'd3, 7'd33, 7'd26, 32'd0};//{'dest': 33, 'src': 26, 'op': 'move'}
    instructions[1412] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1413] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1414] = {6'd18, 7'd32, 7'd33, 32'd128};//{'src': 33, 'right': 128, 'dest': 32, 'signed': False, 'op': '|', 'type': 'int', 'size': 2}
    instructions[1415] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1416] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1417] = {6'd3, 7'd26, 7'd32, 32'd0};//{'dest': 26, 'src': 32, 'op': 'move'}
    instructions[1418] = {6'd14, 7'd0, 7'd0, 32'd1419};//{'label': 1419, 'op': 'goto'}
    instructions[1419] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1420] = {6'd3, 7'd32, 7'd26, 32'd0};//{'dest': 32, 'src': 26, 'op': 'move'}
    instructions[1421] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1422] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1423] = {6'd36, 7'd0, 7'd32, 32'd0};//{'src': 32, 'output': 'leds', 'op': 'write'}
    instructions[1424] = {6'd37, 7'd33, 7'd0, 32'd0};//{'dest': 33, 'input': 'switches', 'op': 'read'}
    instructions[1425] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1426] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1427] = {6'd38, 7'd32, 7'd33, 32'd0};//{'dest': 32, 'src': 33, 'op': '~'}
    instructions[1428] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1429] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1430] = {6'd3, 7'd24, 7'd32, 32'd0};//{'dest': 24, 'src': 32, 'op': 'move'}
    instructions[1431] = {6'd3, 7'd44, 7'd29, 32'd0};//{'dest': 44, 'src': 29, 'op': 'move'}
    instructions[1432] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1433] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1434] = {6'd3, 7'd11, 7'd44, 32'd0};//{'dest': 11, 'src': 44, 'op': 'move'}
    instructions[1435] = {6'd0, 7'd33, 7'd0, 32'd58};//{'dest': 33, 'literal': 58, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1436] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1437] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1438] = {6'd3, 7'd12, 7'd33, 32'd0};//{'dest': 12, 'src': 33, 'op': 'move'}
    instructions[1439] = {6'd0, 7'd33, 7'd0, 32'd0};//{'dest': 33, 'literal': 0, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1440] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1441] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1442] = {6'd3, 7'd13, 7'd33, 32'd0};//{'dest': 13, 'src': 33, 'op': 'move'}
    instructions[1443] = {6'd0, 7'd33, 7'd0, 32'd1460};//{'dest': 33, 'literal': 1460, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1444] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1445] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1446] = {6'd3, 7'd14, 7'd33, 32'd0};//{'dest': 14, 'src': 33, 'op': 'move'}
    instructions[1447] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1448] = {6'd3, 7'd32, 7'd10, 32'd0};//{'dest': 32, 'src': 10, 'op': 'move'}
    instructions[1449] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1450] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1451] = {6'd3, 7'd21, 7'd32, 32'd0};//{'dest': 21, 'src': 32, 'op': 'move'}
    instructions[1452] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1453] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1454] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1455] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1456] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1457] = {6'd13, 7'd32, 7'd33, 32'd2};//{'src': 33, 'right': 2, 'dest': 32, 'signed': False, 'op': '+', 'type': 'int', 'size': 2}
    instructions[1458] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1459] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1460] = {6'd3, 7'd21, 7'd32, 32'd0};//{'dest': 21, 'src': 32, 'op': 'move'}
    instructions[1461] = {6'd3, 7'd33, 7'd24, 32'd0};//{'dest': 33, 'src': 24, 'op': 'move'}
    instructions[1462] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1463] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1464] = {6'd32, 7'd32, 7'd33, 32'd128};//{'src': 33, 'right': 128, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1465] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1466] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1467] = {6'd12, 7'd0, 7'd32, 32'd1477};//{'src': 32, 'label': 1477, 'op': 'jmp_if_false'}
    instructions[1468] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1469] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1470] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1471] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1472] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1473] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1474] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1475] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1476] = {6'd14, 7'd0, 7'd0, 32'd1485};//{'label': 1485, 'op': 'goto'}
    instructions[1477] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1478] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1479] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1480] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1481] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1482] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1483] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1484] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1485] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1486] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1487] = {6'd3, 7'd33, 7'd24, 32'd0};//{'dest': 33, 'src': 24, 'op': 'move'}
    instructions[1488] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1489] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1490] = {6'd32, 7'd32, 7'd33, 32'd64};//{'src': 33, 'right': 64, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1491] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1492] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1493] = {6'd12, 7'd0, 7'd32, 32'd1503};//{'src': 32, 'label': 1503, 'op': 'jmp_if_false'}
    instructions[1494] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1495] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1496] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1497] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1498] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1499] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1500] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1501] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1502] = {6'd14, 7'd0, 7'd0, 32'd1511};//{'label': 1511, 'op': 'goto'}
    instructions[1503] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1504] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1505] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1506] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1507] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1508] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1509] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1510] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1511] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1512] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1513] = {6'd3, 7'd33, 7'd24, 32'd0};//{'dest': 33, 'src': 24, 'op': 'move'}
    instructions[1514] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1515] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1516] = {6'd32, 7'd32, 7'd33, 32'd32};//{'src': 33, 'right': 32, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1517] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1518] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1519] = {6'd12, 7'd0, 7'd32, 32'd1529};//{'src': 32, 'label': 1529, 'op': 'jmp_if_false'}
    instructions[1520] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1521] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1522] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1523] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1524] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1525] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1526] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1527] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1528] = {6'd14, 7'd0, 7'd0, 32'd1537};//{'label': 1537, 'op': 'goto'}
    instructions[1529] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1530] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1531] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1532] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1533] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1534] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1535] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1536] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1537] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1538] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1539] = {6'd3, 7'd33, 7'd24, 32'd0};//{'dest': 33, 'src': 24, 'op': 'move'}
    instructions[1540] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1541] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1542] = {6'd32, 7'd32, 7'd33, 32'd16};//{'src': 33, 'right': 16, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1543] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1544] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1545] = {6'd12, 7'd0, 7'd32, 32'd1555};//{'src': 32, 'label': 1555, 'op': 'jmp_if_false'}
    instructions[1546] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1547] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1548] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1549] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1550] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1551] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1552] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1553] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1554] = {6'd14, 7'd0, 7'd0, 32'd1563};//{'label': 1563, 'op': 'goto'}
    instructions[1555] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1556] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1557] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1558] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1559] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1560] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1561] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1562] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1563] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1564] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1565] = {6'd3, 7'd33, 7'd24, 32'd0};//{'dest': 33, 'src': 24, 'op': 'move'}
    instructions[1566] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1567] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1568] = {6'd32, 7'd32, 7'd33, 32'd8};//{'src': 33, 'right': 8, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1569] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1570] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1571] = {6'd12, 7'd0, 7'd32, 32'd1581};//{'src': 32, 'label': 1581, 'op': 'jmp_if_false'}
    instructions[1572] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1573] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1574] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1575] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1576] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1577] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1578] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1579] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1580] = {6'd14, 7'd0, 7'd0, 32'd1589};//{'label': 1589, 'op': 'goto'}
    instructions[1581] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1582] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1583] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1584] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1585] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1586] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1587] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1588] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1589] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1590] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1591] = {6'd3, 7'd33, 7'd24, 32'd0};//{'dest': 33, 'src': 24, 'op': 'move'}
    instructions[1592] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1593] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1594] = {6'd32, 7'd32, 7'd33, 32'd4};//{'src': 33, 'right': 4, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1595] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1596] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1597] = {6'd12, 7'd0, 7'd32, 32'd1607};//{'src': 32, 'label': 1607, 'op': 'jmp_if_false'}
    instructions[1598] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1599] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1600] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1601] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1602] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1603] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1604] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1605] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1606] = {6'd14, 7'd0, 7'd0, 32'd1615};//{'label': 1615, 'op': 'goto'}
    instructions[1607] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1608] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1609] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1610] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1611] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1612] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1613] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1614] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1615] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1616] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1617] = {6'd3, 7'd33, 7'd24, 32'd0};//{'dest': 33, 'src': 24, 'op': 'move'}
    instructions[1618] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1619] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1620] = {6'd32, 7'd32, 7'd33, 32'd2};//{'src': 33, 'right': 2, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1621] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1622] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1623] = {6'd12, 7'd0, 7'd32, 32'd1633};//{'src': 32, 'label': 1633, 'op': 'jmp_if_false'}
    instructions[1624] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1625] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1626] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1627] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1628] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1629] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1630] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1631] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1632] = {6'd14, 7'd0, 7'd0, 32'd1641};//{'label': 1641, 'op': 'goto'}
    instructions[1633] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1634] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1635] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1636] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1637] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1638] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1639] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1640] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1641] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1642] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1643] = {6'd3, 7'd33, 7'd24, 32'd0};//{'dest': 33, 'src': 24, 'op': 'move'}
    instructions[1644] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1645] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1646] = {6'd32, 7'd32, 7'd33, 32'd1};//{'src': 33, 'right': 1, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1647] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1648] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1649] = {6'd12, 7'd0, 7'd32, 32'd1659};//{'src': 32, 'label': 1659, 'op': 'jmp_if_false'}
    instructions[1650] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1651] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1652] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1653] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1654] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1655] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1656] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1657] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1658] = {6'd14, 7'd0, 7'd0, 32'd1667};//{'label': 1667, 'op': 'goto'}
    instructions[1659] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1660] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1661] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1662] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1663] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1664] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1665] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1666] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1667] = {6'd40, 7'd33, 7'd0, 32'd0};//{'dest': 33, 'input': 'buttons', 'op': 'read'}
    instructions[1668] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1669] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1670] = {6'd38, 7'd32, 7'd33, 32'd0};//{'dest': 32, 'src': 33, 'op': '~'}
    instructions[1671] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1672] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1673] = {6'd3, 7'd25, 7'd32, 32'd0};//{'dest': 25, 'src': 32, 'op': 'move'}
    instructions[1674] = {6'd3, 7'd44, 7'd29, 32'd0};//{'dest': 44, 'src': 29, 'op': 'move'}
    instructions[1675] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1676] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1677] = {6'd3, 7'd11, 7'd44, 32'd0};//{'dest': 11, 'src': 44, 'op': 'move'}
    instructions[1678] = {6'd0, 7'd33, 7'd0, 32'd58};//{'dest': 33, 'literal': 58, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1679] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1680] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1681] = {6'd3, 7'd12, 7'd33, 32'd0};//{'dest': 12, 'src': 33, 'op': 'move'}
    instructions[1682] = {6'd3, 7'd34, 7'd21, 32'd0};//{'dest': 34, 'src': 21, 'op': 'move'}
    instructions[1683] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1684] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1685] = {6'd13, 7'd33, 7'd34, 32'd1};//{'src': 34, 'right': 1, 'dest': 33, 'signed': False, 'op': '+', 'type': 'int', 'size': 2}
    instructions[1686] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1687] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1688] = {6'd3, 7'd13, 7'd33, 32'd0};//{'dest': 13, 'src': 33, 'op': 'move'}
    instructions[1689] = {6'd0, 7'd33, 7'd0, 32'd1460};//{'dest': 33, 'literal': 1460, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1690] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1691] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1692] = {6'd3, 7'd14, 7'd33, 32'd0};//{'dest': 14, 'src': 33, 'op': 'move'}
    instructions[1693] = {6'd1, 7'd9, 7'd0, 32'd832};//{'dest': 9, 'label': 832, 'op': 'jmp_and_link'}
    instructions[1694] = {6'd3, 7'd32, 7'd10, 32'd0};//{'dest': 32, 'src': 10, 'op': 'move'}
    instructions[1695] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1696] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1697] = {6'd3, 7'd21, 7'd32, 32'd0};//{'dest': 21, 'src': 32, 'op': 'move'}
    instructions[1698] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1699] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1700] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1701] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1702] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1703] = {6'd13, 7'd32, 7'd33, 32'd2};//{'src': 33, 'right': 2, 'dest': 32, 'signed': False, 'op': '+', 'type': 'int', 'size': 2}
    instructions[1704] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1705] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1706] = {6'd3, 7'd21, 7'd32, 32'd0};//{'dest': 21, 'src': 32, 'op': 'move'}
    instructions[1707] = {6'd3, 7'd33, 7'd25, 32'd0};//{'dest': 33, 'src': 25, 'op': 'move'}
    instructions[1708] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1709] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1710] = {6'd32, 7'd32, 7'd33, 32'd1};//{'src': 33, 'right': 1, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1711] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1712] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1713] = {6'd12, 7'd0, 7'd32, 32'd1723};//{'src': 32, 'label': 1723, 'op': 'jmp_if_false'}
    instructions[1714] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1715] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1716] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1717] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1718] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1719] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1720] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1721] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1722] = {6'd14, 7'd0, 7'd0, 32'd1731};//{'label': 1731, 'op': 'goto'}
    instructions[1723] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1724] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1725] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1726] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1727] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1728] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1729] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1730] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1731] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1732] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1733] = {6'd3, 7'd33, 7'd25, 32'd0};//{'dest': 33, 'src': 25, 'op': 'move'}
    instructions[1734] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1735] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1736] = {6'd32, 7'd32, 7'd33, 32'd2};//{'src': 33, 'right': 2, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1737] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1738] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1739] = {6'd12, 7'd0, 7'd32, 32'd1749};//{'src': 32, 'label': 1749, 'op': 'jmp_if_false'}
    instructions[1740] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1741] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1742] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1743] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1744] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1745] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1746] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1747] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1748] = {6'd14, 7'd0, 7'd0, 32'd1757};//{'label': 1757, 'op': 'goto'}
    instructions[1749] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1750] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1751] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1752] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1753] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1754] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1755] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1756] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1757] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1758] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1759] = {6'd3, 7'd33, 7'd25, 32'd0};//{'dest': 33, 'src': 25, 'op': 'move'}
    instructions[1760] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1761] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1762] = {6'd32, 7'd32, 7'd33, 32'd4};//{'src': 33, 'right': 4, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1763] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1764] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1765] = {6'd12, 7'd0, 7'd32, 32'd1775};//{'src': 32, 'label': 1775, 'op': 'jmp_if_false'}
    instructions[1766] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1767] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1768] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1769] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1770] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1771] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1772] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1773] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1774] = {6'd14, 7'd0, 7'd0, 32'd1783};//{'label': 1783, 'op': 'goto'}
    instructions[1775] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1776] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1777] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1778] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1779] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1780] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1781] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1782] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1783] = {6'd3, 7'd32, 7'd21, 32'd0};//{'dest': 32, 'src': 21, 'op': 'move'}
    instructions[1784] = {6'd13, 7'd21, 7'd21, 32'd1};//{'src': 21, 'right': 1, 'dest': 21, 'signed': False, 'op': '+', 'size': 2}
    instructions[1785] = {6'd3, 7'd33, 7'd25, 32'd0};//{'dest': 33, 'src': 25, 'op': 'move'}
    instructions[1786] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1787] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1788] = {6'd32, 7'd32, 7'd33, 32'd8};//{'src': 33, 'right': 8, 'dest': 32, 'signed': False, 'op': '&', 'type': 'int', 'size': 2}
    instructions[1789] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1790] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1791] = {6'd12, 7'd0, 7'd32, 32'd1801};//{'src': 32, 'label': 1801, 'op': 'jmp_if_false'}
    instructions[1792] = {6'd0, 7'd32, 7'd0, 32'd48};//{'dest': 32, 'literal': 48, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1793] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1794] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1795] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1796] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1797] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1798] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1799] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1800] = {6'd14, 7'd0, 7'd0, 32'd1809};//{'label': 1809, 'op': 'goto'}
    instructions[1801] = {6'd0, 7'd32, 7'd0, 32'd49};//{'dest': 32, 'literal': 49, 'size': 2, 'signed': 2, 'op': 'literal'}
    instructions[1802] = {6'd3, 7'd33, 7'd21, 32'd0};//{'dest': 33, 'src': 21, 'op': 'move'}
    instructions[1803] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1804] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1805] = {6'd39, 7'd34, 7'd33, 32'd29};//{'dest': 34, 'src': 33, 'srcb': 29, 'signed': True, 'op': '+'}
    instructions[1806] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1807] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1808] = {6'd33, 7'd0, 7'd34, 32'd32};//{'srcb': 32, 'src': 34, 'element_size': 2, 'op': 'memory_write'}
    instructions[1809] = {6'd3, 7'd44, 7'd29, 32'd0};//{'dest': 44, 'src': 29, 'op': 'move'}
    instructions[1810] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1811] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1812] = {6'd3, 7'd1, 7'd44, 32'd0};//{'dest': 1, 'src': 44, 'op': 'move'}
    instructions[1813] = {6'd1, 7'd0, 7'd0, 32'd609};//{'dest': 0, 'label': 609, 'op': 'jmp_and_link'}
    instructions[1814] = {6'd14, 7'd0, 7'd0, 32'd1816};//{'label': 1816, 'op': 'goto'}
    instructions[1815] = {6'd1, 7'd74, 7'd0, 32'd571};//{'dest': 74, 'label': 571, 'op': 'jmp_and_link'}
    instructions[1816] = {6'd14, 7'd0, 7'd0, 32'd957};//{'label': 957, 'op': 'goto'}
    instructions[1817] = {6'd41, 7'd32, 7'd0, 32'd0};//{'dest': 32, 'input': 'rs232_rx', 'op': 'read'}
    instructions[1818] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1819] = {6'd4, 7'd0, 7'd0, 32'd0};//{'op': 'nop'}
    instructions[1820] = {6'd3, 7'd21, 7'd32, 32'd0};//{'dest': 21, 'src': 32, 'op': 'move'}
    instructions[1821] = {6'd6, 7'd0, 7'd18, 32'd0};//{'src': 18, 'op': 'jmp_to_reg'}
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
      opcode_0 = instruction_0[51:46];
      dest_0 = instruction_0[45:39];
      src_0 = instruction_0[38:32];
      srcb_0 = instruction_0[6:0];
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
          s_output_socket_stb <= 1'b1;
          s_output_socket <= register_1;
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
          s_output_rs232_tx_stb <= 1'b1;
          s_output_rs232_tx <= register_1;
        end

        16'd8:
        begin
          result_2 <= $unsigned(register_1) + $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd9:
        begin
          address_2 <= register_1;
        end

        16'd11:
        begin
          result_2 <= data_out_2;
          write_enable_2 <= 1;
        end

        16'd12:
        begin
          if (register_1 == 0) begin
            program_counter <= literal_1;
            stage_0_enable <= 1;
            stage_1_enable <= 0;
            stage_2_enable <= 0;
          end
        end

        16'd13:
        begin
          result_2 <= $unsigned(register_1) + $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd14:
        begin
          program_counter <= literal_1;
          stage_0_enable <= 1;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
        end

        16'd15:
        begin
          result_2 <= $unsigned(register_1) >= $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd16:
        begin
          result_2 <= $unsigned(register_1) - $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd17:
        begin
          result_2 <= $unsigned(register_1) | $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd18:
        begin
          result_2 <= $unsigned(register_1) | $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd19:
        begin
          result_2 <= $signed(register_1) >= $signed(literal_1);
          write_enable_2 <= 1;
        end

        16'd20:
        begin
          result_2 <= $signed(literal_1) - $signed(register_1);
          write_enable_2 <= 1;
        end

        16'd21:
        begin
          result_2 <= $signed(register_1) << $signed(literal_1);
          write_enable_2 <= 1;
        end

        16'd22:
        begin
          result_2 <= $signed(register_1) & $signed(literal_1);
          write_enable_2 <= 1;
        end

        16'd23:
        begin
          result_2 <= $unsigned(register_1) == $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd24:
        begin
          result_2 <= $unsigned(literal_1) | $unsigned(register_1);
          write_enable_2 <= 1;
        end

        16'd25:
        begin
          result_2 <= $unsigned(register_1) > $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd26:
        begin
          result_2 <= $unsigned(register_1) < $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd27:
        begin
          result_2 <= $unsigned(register_1) < $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd28:
        begin
          result_2 <= $unsigned(register_1) == $unsigned(registerb_1);
          write_enable_2 <= 1;
        end

        16'd29:
        begin
          result_2 <= $signed(register_1) + $signed(literal_1);
          write_enable_2 <= 1;
        end

        16'd30:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
          s_input_socket_ack <= 1'b1;
        end

        16'd31:
        begin
          result_2 <= $unsigned(register_1) >> $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd32:
        begin
          result_2 <= $unsigned(register_1) & $unsigned(literal_1);
          write_enable_2 <= 1;
        end

        16'd33:
        begin
          address_2 <= register_1;
          data_in_2 <= registerb_1;
          memory_enable_2 <= 1'b1;
        end

        16'd34:
        begin
          if (register_1 != 0) begin
            program_counter <= literal_1;
            stage_0_enable <= 1;
            stage_1_enable <= 0;
            stage_2_enable <= 0;
          end
        end

        16'd35:
        begin
          result_2 <= $signed(register_1) != $signed(literal_1);
          write_enable_2 <= 1;
        end

        16'd36:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
          s_output_leds_stb <= 1'b1;
          s_output_leds <= register_1;
        end

        16'd37:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
          s_input_switches_ack <= 1'b1;
        end

        16'd38:
        begin
          result_2 <= ~register_1;
          write_enable_2 <= 1;
        end

        16'd39:
        begin
          result_2 <= $signed(register_1) + $signed(registerb_1);
          write_enable_2 <= 1;
        end

        16'd40:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
          s_input_buttons_ack <= 1'b1;
        end

        16'd41:
        begin
          stage_0_enable <= 0;
          stage_1_enable <= 0;
          stage_2_enable <= 0;
          s_input_rs232_rx_ack <= 1'b1;
        end

       endcase
    end
     if (s_output_socket_stb == 1'b1 && output_socket_ack == 1'b1) begin
       s_output_socket_stb <= 1'b0;
       stage_0_enable <= 1;
       stage_1_enable <= 1;
       stage_2_enable <= 1;
     end

     if (s_output_rs232_tx_stb == 1'b1 && output_rs232_tx_ack == 1'b1) begin
       s_output_rs232_tx_stb <= 1'b0;
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

     if (s_output_leds_stb == 1'b1 && output_leds_ack == 1'b1) begin
       s_output_leds_stb <= 1'b0;
       stage_0_enable <= 1;
       stage_1_enable <= 1;
       stage_2_enable <= 1;
     end

    if (s_input_switches_ack == 1'b1 && input_switches_stb == 1'b1) begin
       result_2 <= input_switches;
       write_enable_2 <= 1;
       s_input_switches_ack <= 1'b0;
       stage_0_enable <= 1;
       stage_1_enable <= 1;
       stage_2_enable <= 1;
     end

    if (s_input_buttons_ack == 1'b1 && input_buttons_stb == 1'b1) begin
       result_2 <= input_buttons;
       write_enable_2 <= 1;
       s_input_buttons_ack <= 1'b0;
       stage_0_enable <= 1;
       stage_1_enable <= 1;
       stage_2_enable <= 1;
     end

    if (s_input_rs232_rx_ack == 1'b1 && input_rs232_rx_stb == 1'b1) begin
       result_2 <= input_rs232_rx;
       write_enable_2 <= 1;
       s_input_rs232_rx_ack <= 1'b0;
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
      s_input_switches_ack <= 0;
      s_input_buttons_ack <= 0;
      s_input_socket_ack <= 0;
      s_input_rs232_rx_ack <= 0;
      s_output_rs232_tx_stb <= 0;
      s_output_leds_stb <= 0;
      s_output_socket_stb <= 0;
    end
  end
  assign input_switches_ack = s_input_switches_ack;
  assign input_buttons_ack = s_input_buttons_ack;
  assign input_socket_ack = s_input_socket_ack;
  assign input_rs232_rx_ack = s_input_rs232_rx_ack;
  assign output_rs232_tx_stb = s_output_rs232_tx_stb;
  assign output_rs232_tx = s_output_rs232_tx;
  assign output_leds_stb = s_output_leds_stb;
  assign output_leds = s_output_leds;
  assign output_socket_stb = s_output_socket_stb;
  assign output_socket = s_output_socket;

endmodule
