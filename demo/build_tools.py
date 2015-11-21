#!/usr/bin/env python

"""compile, build and download the ATLYS demo to the ATLYS development kit"""

import sys
import os
import shutil

from user_settings import ise, vivado, working_directory

def build_ise(chip, bsp):

    """Build using Xilinx ISE an FPGA using the specified BSP
    
    chip is a chip instance.

    bsp specifies a directory that must contain:
        bsp.py - A python module defining:
            chip - a model of the target hardware
            buildoptions - the target part
            buildtool - the target part
            downloadoptions - the target part
            downloadtool - the target part
        bsp.prj - A partial xilinx prj file containing bsp source files
        bsp.ucf - A constraints file containing the user constraints
        *.v - verilog source files
        *.vhd - vhdl source files
        xst_mixed.opt - synthesis options
        balanced.opt - place and route options
        bitgen.opt - bitgen options
    """

    source_files = [i + ".v" for i in chip.components]
    source_files += [chip.name + ".v"]
    source_files += ["chips_lib.v"]

    #Create a project area
    #
    bsp_dir = os.path.dirname(bsp.__file__)
    if not os.path.exists(working_directory):
        os.mkdir(working_directory)
    current_directory = os.getcwd()
    shutil.copyfile(os.path.join(bsp_dir, "bsp.ucf"), os.path.join(working_directory, "bsp.ucf"))
    shutil.copyfile(os.path.join(bsp_dir, "xst_mixed.opt"), os.path.join(working_directory, "xst_mixed.opt"))
    shutil.copyfile(os.path.join(bsp_dir, "balanced.opt"), os.path.join(working_directory, "balanced.opt"))
    shutil.copyfile(os.path.join(bsp_dir, "bitgen.opt"), os.path.join(working_directory, "bitgen.opt"))

    #create a comprehensive file list
    #

    #first add the source files
    print "Creating ISE project ..."
    prj_file = open(os.path.join(working_directory, "bsp.prj"), 'w')
    for path in source_files:
        print "Adding file ...", path
        _, filename = os.path.split(path)
        if filename.upper().endswith(".V"):
            prj_file.write("verilog work " + filename + "\n")
        elif filename.upper().endswith(".VHD") or filename.upper().endswith(".VHDL"):
            prj_file.write("vhdl work " + filename + "\n")

    #then add the bsp files
    bsp_files = open(os.path.join(bsp_dir, "bsp.prj")).read().splitlines()
    for filename in bsp_files:
        print "Adding file ...", filename
        shutil.copyfile(os.path.join(bsp_dir, filename), os.path.join(working_directory, filename))
        if filename.upper().endswith(".V"):
            prj_file.write("verilog work " + filename + "\n")
        elif filename.upper().endswith(".VHD") or filename.upper().endswith(".VHDL"):
            prj_file.write("vhdl work " + filename + "\n")

    prj_file.close()

    #run the xilinx build
    #

    os.chdir(working_directory)
    print "Building Demo using Xilinx ise ...."
    retval = os.system("%s/xflow -synth xst_mixed.opt -p XC6Slx45-CSG324 -implement balanced.opt -config bitgen.opt bsp"%ise)
    if retval != 0:
        sys.exit(-1)
    os.chdir(current_directory)

def build_vivado(chip, bsp):

    """Build using Xilinx Vivado an FPGA using the specified BSP
    
    chip is a chip instance.

    bsp specifies a directory that must contain:
        bsp.py - A python module defining:
            chip - a model of the target hardware
            device - the target part
            buildtool - the appriopriate build tool
            downloadoptions - the target part
        bsp.prj - A partial xilinx prj file containing bsp source files
        bsp.xdc - A constraints file containing the user constraints
        *.v - verilog source files
        *.vhd - vhdl source files
    """

    source_files = [i + ".v" for i in chip.components]
    source_files += [chip.name + ".v"]
    source_files += ["chips_lib.v"]

    #Create a project area
    #
    bsp_dir = os.path.dirname(bsp.__file__)
    if not os.path.exists(working_directory):
        os.mkdir(working_directory)
    current_directory = os.getcwd()
    shutil.copyfile(os.path.join(bsp_dir, "bsp.xdc"), os.path.join(working_directory, "bsp.xdc"))

    #create a comprehensive file list
    #
    #first add the source files
    print "Creating Vivado project ..."
    prj_file = open(os.path.join(working_directory, "bsp.tcl"), 'w')
    prj_file.write(
    """# STEP#1: define the output directory area.
    #
    set outputDir .
    
    # STEP#2: setup design sources and constraints
    #
    read_xdc ./bsp.xdc
    """)

    #first add the source files
    for path in source_files:
        print "Adding file ...", path
        _, filename = os.path.split(path)
        if filename.upper().endswith(".V"):
            prj_file.write("read_verilog " + filename + "\n")
        elif filename.upper().endswith(".VHD") or filename.upper().endswith(".VHDL"):
            prj_file.write("read_vhdl " + filename + "\n")

    #then add the bsp files
    bsp_files = open(os.path.join(bsp_dir, "bsp.prj")).read().splitlines()
    for filename in bsp_files:
        print "Adding file ...", filename
        shutil.copyfile(os.path.join(bsp_dir, filename), os.path.join(working_directory, filename))
        if filename.upper().endswith(".V"):
            prj_file.write("read_verilog " + filename + "\n")
        elif filename.upper().endswith(".VHD") or filename.upper().endswith(".VHDL"):
            prj_file.write("read_vhdl " + filename + "\n")

    prj_file.write(
    """
    #
    # STEP#3: run synthesis, write design checkpoint, report timing,
    # and utilization estimates
    #

    synth_design -top bsp -part %s
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
    """ % bsp.device)
    prj_file.close()

    #run the xilinx build
    #
    os.chdir(working_directory)
    print "Building Demo using Xilinx ise ...."
    retval = os.system("%s/vivado -mode batch -source bsp.tcl"%vivado)
    if retval != 0:
        sys.exit(-1)
    os.chdir(current_directory)
