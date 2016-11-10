set_property PACKAGE_PIN E3 [get_ports clk_in]                            
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_in]

set_property PACKAGE_PIN C12 [get_ports rst]   
set_property IOSTANDARD LVCMOS25 [get_ports rst]

set_property PACKAGE_PIN C4 [get_ports rs232_rx]                       
set_property IOSTANDARD LVCMOS33 [get_ports rs232_rx]
set_property PACKAGE_PIN D4 [get_ports rs232_tx]                       
set_property IOSTANDARD LVCMOS33 [get_ports rs232_tx]

set_property PACKAGE_PIN F14 [get_ports rf_out]						
set_property IOSTANDARD LVCMOS25 [get_ports rf_out]

set_property PACKAGE_PIN D17 [get_ports test_1]						
set_property IOSTANDARD LVCMOS25 [get_ports test_1]

set_property PACKAGE_PIN E17 [get_ports test_2]						
set_property IOSTANDARD LVCMOS25 [get_ports test_2]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
