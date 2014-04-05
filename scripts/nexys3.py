#!/usr/bin/env python

"""compile, build and download the NEXYS3 demo to the NEXYS3 development kit"""

import sys
import os
import shutil

from user_settings import xilinx

current_directory = os.getcwd()
working_directory = "NEXYS3"
shutil.copyfile("xilinx_input/NEXYS3.ucf", os.path.join(working_directory, "NEXYS3.ucf"))
shutil.copyfile("xilinx_input/NEXYS3.prj", os.path.join(working_directory, "NEXYS3.prj"))
shutil.copyfile("xilinx_input/xst_mixed.opt", os.path.join(working_directory, "xst_mixed.opt"))
shutil.copyfile("xilinx_input/balanced.opt", os.path.join(working_directory, "balanced.opt"))
shutil.copyfile("xilinx_input/bitgen.opt", os.path.join(working_directory, "bitgen.opt"))
os.chdir(working_directory)

if "compile" in sys.argv or "all" in sys.argv:
    print "Compiling C files using chips ...."
    retval = os.system("../chips2/c2verilog ../source/user_design.c")
    retval = os.system("../chips2/c2verilog ../source/server.c")
    if retval != 0:
        sys.exit(-1)

if "synth_estimate" in sys.argv:
    print "Test build to estimate size ...."
    os.mkdir(os.path.join(current_directory, "synth_estimate"))
    os.chdir(os.path.join(current_directory, "synth_estimate"))
    retval = os.system("../chips2/c2verilog ../source/server.c")
    output_file = open("server.prj", "w")
    output_file.write("verilog work server.v")
    output_file.close()
    os.system("%s/xflow -synth xst_mixed.opt -p XC6Slx16-CSG324 -implement balanced.opt -config bitgen.opt server"%xilinx)
    os.chdir(current_directory)
    shutil.rmtree("synth_estimate")

if "build" in sys.argv or "all" in sys.argv:
    print "Building Demo using Xilinx ise ...."
    retval = os.system("%s/xflow -synth xst_mixed.opt -p XC6Slx16-CSG324 -implement balanced.opt -config bitgen.opt NEXYS3"%xilinx)
    if retval != 0:
        sys.exit(-1)
    shutil.copyfile("server.v", os.path.join(current_directory, "precompiled", "server.v"))
    shutil.copyfile("NEXYS3.bit", os.path.join(current_directory, "precompiled", "NEXYS3.bit"))

if "download" in sys.argv or "all" in sys.argv:
    print "Downloading bit file to development kit ...."
    retval = os.system("sudo djtgcfg prog -d Nexys3 -i 0 -f NEXYS3.bit")
    if retval != 0:
        sys.exit(-1)

os.chdir(current_directory)
