#!/usr/bin/env python

"""compile, build and download the ATLYS demo to the ATLYS development kit"""

import sys
import os
import shutil

from chips.components.components import discard, constant
from chips.compiler.exceptions import C2CHIPError
import user_settings


def compile_user_design(application):
    working_directory = user_settings.working_directory
    if not os.path.exists(working_directory):
        os.mkdir(working_directory)
    current_directory = os.getcwd()
    os.chdir(working_directory)
    application.generate_verilog()
    os.chdir(current_directory)

if len(sys.argv) < 2:
    print "Chips 2.0 Demonstration"
    print ("./run_demo application bsp"
    " [compile | build | simulate | debug | download]")
    sys.exit(1)
    

application = sys.argv[1]
bsp = sys.argv[2]

#select application and bsp from appropriate module
host = __import__("demo.examples.%s.host"%application, globals(), locals(), ["host"], -1)
application = __import__("demo.examples.%s.application"%application, globals(), locals(), ["application"], -1)
bsp = __import__("demo.bsp.%s.bsp"%bsp, globals(), locals(), ["bsp"], -1)

#apply the application to the chip
chip = bsp.chip
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
    if "simulate" in sys.argv:
        chip.debug()

    #if "vsim" in sys.argv:
        #chip.generate_verilog()
        #chip.generate_testbench()
        #chip.compile_iverilog(True)

    if "compile" in sys.argv:
        compile_user_design(chip)

    if "build" in sys.argv:
        build_tool = bsp.build_tool
        build_tool(chip, bsp)

    if "download" in sys.argv:
        download_tool = bsp.download_tool
        download_tool(chip, bsp)

    if "run" in sys.argv:
        host.run()

except C2CHIPError as e:
    print e
