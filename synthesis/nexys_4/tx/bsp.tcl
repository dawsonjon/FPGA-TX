# STEP#1: define the output directory area.
    #
    set outputDir .
    
    # STEP#2: setup design sources and constraints
    #
    read_xdc ./bsp.xdc
    read_verilog main_0.v
read_verilog user_design.v
read_verilog chips_lib.v
read_vhdl fifo.vhd
read_vhdl serial_out.vhd
read_vhdl serial_in.vhd
read_vhdl interpolate.vhd
read_vhdl nco.vhd
read_vhdl serdes.vhd
read_vhdl dac_interface.vhd
read_vhdl transmitter.vhd
read_vhdl bsp.vhd

    #
    # STEP#3: run synthesis, write design checkpoint, report timing,
    # and utilization estimates
    #

    synth_design -top bsp -part XC7A100T-CSG324-1
    write_checkpoint -force $outputDir/post_synth.dcp
    report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
    report_utilization -file $outputDir/post_synth_util.rpt

    # STEP#4: run logic optimization, placement and physical logic optimization,
    # write design checkpoint, report utilization and timing estimates
    #
    opt_design
    place_design
    report_clock_utilization -file $outputDir/clock_util.rpt

    #
    phys_opt_design
    write_checkpoint -force $outputDir/post_place.dcp
    report_utilization -file $outputDir/post_place_util.rpt
    report_timing_summary -file $outputDir/post_place_timing_summary.rpt

    #
    # STEP#5: run the router, write the post-route design checkpoint, report the routing
    # status, report timing, power, and DRC, and finally save the Verilog netlist.
    #
    route_design
    write_checkpoint -force $outputDir/post_route.dcp
    report_route_status -file $outputDir/post_route_status.rpt
    report_timing_summary -file $outputDir/post_route_timing_summary.rpt
    report_power -file $outputDir/post_route_power.rpt
    report_drc -file $outputDir/post_imp_drc.rpt
    write_verilog -force $outputDir/cpu_impl_netlist.v -mode timesim -sdf_anno true


    #
    # STEP#6: generate a bitstream
    #
    write_bitstream -force $outputDir/bsp.bit

    #
    # Create Programming file
    #

    write_cfgmem -force -format mcs -interface spix4 -size 16 -loadbit "up 0x0 $outputDir/bsp.bit" -file bsp.mcs

    