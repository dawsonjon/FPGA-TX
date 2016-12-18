set_property PACKAGE_PIN L17 [get_ports clk_in]                            
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports clk_in]

set_property PACKAGE_PIN A18 [get_ports rst]   
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property PACKAGE_PIN J17 [get_ports rs232_rx]                       
set_property IOSTANDARD LVCMOS33 [get_ports rs232_rx]
set_property PACKAGE_PIN J18 [get_ports rs232_tx]                       
set_property IOSTANDARD LVCMOS33 [get_ports rs232_tx]

set_property PACKAGE_PIN A17 [get_ports ld1]						
set_property IOSTANDARD LVCMOS33 [get_ports ld1]

set_property PACKAGE_PIN R3 [get_ports rf_out]						
set_property IOSTANDARD LVTTL [get_ports rf_out]
set_property DRIVE 24 [get_ports rf_out]						

set_property PACKAGE_PIN T3 [get_ports pps]						
set_property IOSTANDARD LVCMOS33 [get_ports pps]

set_property PACKAGE_PIN R2 [get_ports gps_tx]						
set_property IOSTANDARD LVCMOS33 [get_ports gps_tx]

set_property PACKAGE_PIN T1 [get_ports gps_rx]						
set_property IOSTANDARD LVCMOS33 [get_ports gps_rx]

set_property PACKAGE_PIN T2 [get_ports tx_rx]						
set_property IOSTANDARD LVCMOS33 [get_ports tx_rx]

set_property PACKAGE_PIN U1 [get_ports tx_pa]						
set_property IOSTANDARD LVCMOS33 [get_ports tx_pa]

set_property PACKAGE_PIN U5 [get_ports {leds[0]}]                   
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property PACKAGE_PIN U2 [get_ports {leds[1]}]                   
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property PACKAGE_PIN W6 [get_ports {leds[2]}]                   
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property PACKAGE_PIN U3 [get_ports {leds[3]}]                   
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property PACKAGE_PIN U7 [get_ports {leds[4]}]                   
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]
set_property PACKAGE_PIN W7 [get_ports {leds[5]}]                   
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]
set_property PACKAGE_PIN U8 [get_ports {leds[6]}]                   
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]
set_property PACKAGE_PIN V8 [get_ports {leds[7]}]                   
set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
