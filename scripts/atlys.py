#!/usr/bin/env python

"""compile, build and download the ATLYS demo to the ATLYS development kit"""

import sys
import os
import shutil

from user_settings import xilinx

current_directory = os.getcwd()
working_directory = "ATLYS"
shutil.copyfile("xilinx_input/ATLYS.ucf", os.path.join(working_directory, "ATLYS.ucf"))
shutil.copyfile("xilinx_input/ATLYS.prj", os.path.join(working_directory, "ATLYS.prj"))
shutil.copyfile("xilinx_input/xst_mixed.opt", os.path.join(working_directory, "xst_mixed.opt"))
shutil.copyfile("xilinx_input/balanced.opt", os.path.join(working_directory, "balanced.opt"))
shutil.copyfile("xilinx_input/bitgen.opt", os.path.join(working_directory, "bitgen.opt"))
os.chdir(working_directory)

if "compile" in sys.argv or "all" in sys.argv:
    print "Compiling C files using chips ...."
    retval = os.system("../chips2/c2verilog no_reuse ../source/user_design_atlys.c")
    retval = os.system("../chips2/c2verilog no_reuse ../source/server.c")
    if retval != 0:
        sys.exit(-1)

if "build" in sys.argv or "all" in sys.argv:
    print "Building Demo using Xilinx ise ...."
    retval = os.system("%s/xflow -synth xst_mixed.opt -p XC6Slx45-CSG324 -implement balanced.opt -config bitgen.opt ATLYS"%xilinx)
    if retval != 0:
        sys.exit(-1)

if "download" in sys.argv or "all" in sys.argv:
    print "Downloading bit file to development kit ...."
    retval = os.system("sudo djtgcfg prog -d Atlys -i 0 -f ATLYS.bit")
    if retval != 0:
        sys.exit(-1)

os.chdir(current_directory)
