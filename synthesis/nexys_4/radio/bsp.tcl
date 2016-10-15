# STEP#1: define the output directory area.
    #
    set outputDir .
    
    # STEP#2: setup design sources and constraints
    #
    read_xdc ./bsp.xdc
    read_verilog main_12.v
read_verilog main_11.v
read_verilog main_13.v
read_verilog main_10.v
read_verilog main_0.v
read_verilog main_1.v
read_verilog main_2.v
read_verilog main_3.v
read_verilog main_4.v
read_verilog main_5.v
read_verilog main_6.v
read_verilog main_7.v
read_verilog main_8.v
read_verilog main_9.v
read_verilog user_design.v
read_verilog chips_lib.v
read_vhdl serial_out.vhd
read_vhdl serial_in.vhd
read_vhdl rmii_ethernet.vhd
read_vhdl i2c.vhd
read_vhdl pwm.vhd
read_vhdl keyboard.vhd
read_vhdl bram.vhd
read_vhdl svga_package.vhd
read_vhdl svga_core.vhd
read_vhdl svga_timing_gen.vhd
read_vhdl pwm_audio.vhd
read_vhdl rectangular_to_polar.vhd
read_vhdl cic_filter.vhd
read_vhdl radio.vhd
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
    