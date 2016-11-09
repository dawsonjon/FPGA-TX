#!/usr/bin/env python

"""Compile, build and program FPGA TX firmware"""

import sys
import os
import shutil

from chips.components.components import discard, constant
from chips.compiler.exceptions import C2CHIPError
import user_settings
all_bsps = ["nexys_4"]

def compile_user_design(application, working_directory):
    if not os.path.exists(working_directory):
        os.makedirs(working_directory)
    current_directory = os.getcwd()
    os.chdir(working_directory)
    application.generate_verilog()
    os.chdir(current_directory)

if len(sys.argv) < 3:
    print "FPGA TX Firmware configuration"
    print ("./run_fpga bsp"
    " [compile | build | download | flash]")
    print ""
    print "compile - compile chips design into verilog"
    print "build - synthesise and build bitstream with vendor tools"
    print "download - download bitstream to hardware"
    print "flash - download bitstream to non-volatile memory"
    print ""
    print "example:"
    print "./run_fpga nexys_4 compile build download #full build process"
    print ""
    print "available bsps:"
    for bsp in all_bsps:
        print "+", bsp
    print ""
    sys.exit(1)

    
application="tx"
bsp = sys.argv[1]
working_directory = os.path.join(user_settings.working_directory, bsp, application)

#select application and bsp from appropriate module
application = __import__("fpga_tx.c_code.application", globals(), locals(), ["application"], -1)
bsp = __import__("fpga_tx.bsp.%s.bsp"%bsp, globals(), locals(), ["bsp"], -1)

#apply the application to the chip
chip = bsp.make_chip()
application.application(chip)

#terminate unused bsp io
for i in chip.inputs.values():
    if i.sink is None:
        discard(chip, i)

for i in chip.outputs.values():
    if i.source is None:
        constant(chip, 0, out=i)

#run the demo
try:

    if "compile" in sys.argv:
        compile_user_design(chip, working_directory)

    if "build" in sys.argv:
        build_tool = bsp.build_tool
        build_tool(chip, bsp, working_directory)

    if "download" in sys.argv:
        download_tool = bsp.download_tool
        download_tool(chip, bsp, working_directory)

    if "flash" in sys.argv:
        flash_tool = bsp.flash_tool
        flash_tool(chip, bsp, working_directory)

except C2CHIPError as e:
    print e
