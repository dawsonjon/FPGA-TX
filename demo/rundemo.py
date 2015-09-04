#!/usr/bin/env python

"""compile, build and download the ATLYS demo to the ATLYS development kit"""

import sys
import os
import shutil

from user_settings import xilinx

working_directory = "synthesis"

def compile_user_design(application):
    if not os.path.exists(working_directory):
        os.mkdir(working_directory)
    current_directory = os.getcwd()
    os.chdir(working_directory)
    application.generate_verilog()
    os.chdir(current_directory)

def build_xst(source_files, bsp):

    """Build using Xilinx ISE an FPGA using the specified BSP
    
    source files is a list of source files.

    bsp specifies a directory containing:
        part - A file containing the part
        bsp.prj - A partial xilinx prj file containing bsp source files
        bsp.ucf - A constraints file containing the user constraints
        *.v - verilog source files
        *.vhd - vhdl source files
        xst_mixed.opt - synthesis options
        balanced.opt - place and route options
        bitgen.opt - bitgen options
    """

    #Create a project area
    #
    if not os.path.exists(working_directory):
        os.mkdir(working_directory)
    current_directory = os.getcwd()
    shutil.copyfile(os.path.join(bsp, "bsp.ucf"), os.path.join(working_directory, "bsp.ucf"))
    shutil.copyfile(os.path.join(bsp, "xst_mixed.opt"), os.path.join(working_directory, "xst_mixed.opt"))
    shutil.copyfile(os.path.join(bsp, "balanced.opt"), os.path.join(working_directory, "balanced.opt"))
    shutil.copyfile(os.path.join(bsp, "bitgen.opt"), os.path.join(working_directory, "bitgen.opt"))

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
    bsp_files = open(os.path.join(bsp, "bsp.prj")).read().splitlines()
    for filename in bsp_files:
        print "Adding file ...", filename
        shutil.copyfile(os.path.join(bsp, filename), os.path.join(working_directory, filename))
        if filename.upper().endswith(".V"):
            prj_file.write("verilog work " + filename + "\n")
        elif filename.upper().endswith(".VHD") or filename.upper().endswith(".VHDL"):
            prj_file.write("vhdl work " + filename + "\n")

    prj_file.close()

    #run the xilinx build
    #

    os.chdir(working_directory)
    print "Building Demo using Xilinx ise ...."
    retval = os.system("%s/xflow -synth xst_mixed.opt -p XC6Slx45-CSG324 -implement balanced.opt -config bitgen.opt bsp"%xilinx)
    if retval != 0:
        sys.exit(-1)
    os.chdir(current_directory)

def download_digilent(board):
    print "Downloading bit file to development kit ...."
    retval = os.system("sudo djtgcfg prog -d %s -i 0 -f %s/bsp.bit"%(board, working_directory))
    if retval != 0:
        sys.exit(-1)

#build_xst(["user_design.v"], os.path.join("bsp", "atlys"))
#download_digilent("Atlys")
