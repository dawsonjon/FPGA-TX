#!/usr/bin/env python

"""Compile, build and download the ATLYS demo to the ATLYS development kit"""

import sys
import os
import shutil

from chips.components.components import discard, constant
from chips.compiler.exceptions import C2CHIPError
import user_settings

def compile_user_design(application, working_directory):
    if not os.path.exists(working_directory):
        os.makedirs(working_directory)
    current_directory = os.getcwd()
    os.chdir(working_directory)
    application.generate_verilog()
    os.chdir(current_directory)

all_applications = [i for i in os.listdir("demo/examples") if ".py" not in i]
all_bsps = [i for i in os.listdir("demo/bsp") if ".py" not in i]

#build all demonstrations
try:
    if "build_all" in sys.argv:
        for bsp_name in all_bsps:
            for application_name in all_applications:
                print "building:", application_name, "for hardware platform", bsp_name
                print ""
                working_directory = os.path.join(user_settings.working_directory, bsp_name, application_name)
                host = __import__("demo.examples.%s.host"%application_name, globals(), locals(), ["host"], -1)
                application = __import__("demo.examples.%s.application"%application_name, globals(), locals(), ["application"], -1)
                bsp = __import__("demo.bsp.%s.bsp"%bsp_name, globals(), locals(), ["bsp"], -1)
                chip = bsp.make_chip()
                try:
                    application.application(chip)
                except KeyError:
                    continue
                #terminate unused bsp io
                for i in chip.inputs.values():
                    if i.sink is None:
                        discard(chip, i)
                for i in chip.outputs.values():
                    if i.source is None:
                        constant(chip, 0, out=i)
                compile_user_design(chip, working_directory)
                build_tool = bsp.build_tool
                build_tool(chip, bsp, working_directory)
        sys.exit(1)
except C2CHIPError as e:
    print e
    sys.exit(1)

if len(sys.argv) < 3:
    print "Chips 2.0 Demonstration"
    print ("./run_demo application bsp"
    " [compile | build | download | run]")
    print ""
    print "application - a demonstration application"
    print "bsp - a hardware target definition"
    print ""
    print "compile - compile chips design into verilog"
    print "build - synthesise and build bitstream with vendor tools"
    print "download - download bitstream to hardware"
    print "run - run demonstration application on host"
    print ""
    print "example:"
    print "./run_demo audio_output nexys_4 compile build download run #full build process"
    print "./run_demo audio_output nexys_4 download run #run a pre-built demo"
    print ""
    print "available bsps:"
    for bsp in all_bsps:
        print "+", bsp
    print ""
    print "available applications:"
    for application in all_applications:
        print "+", application
    print ""
    sys.exit(1)

    

application = sys.argv[1]
bsp = sys.argv[2]
working_directory = os.path.join(user_settings.working_directory, bsp, application)

#select application and bsp from appropriate module
host = __import__("demo.examples.%s.host"%application, globals(), locals(), ["host"], -1)
application = __import__("demo.examples.%s.application"%application, globals(), locals(), ["application"], -1)
bsp = __import__("demo.bsp.%s.bsp"%bsp, globals(), locals(), ["bsp"], -1)

#apply the application to the chip
chip = bsp.make_chip()
print chip.inputs.values()
#try:
application.application(chip)
#except KeyError:
    #pass

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

    if "build_all" in sys.argv:
        for bsp in bsps:
            for application in applications:
                working_directory = os.path.join(user_settings.working_directory, bsp, application)
                host = __import__("demo.examples.%s.host"%application, globals(), locals(), ["host"], -1)
                application = __import__("demo.examples.%s.application"%application, globals(), locals(), ["application"], -1)
                bsp = __import__("demo.bsp.%s.bsp"%bsp, globals(), locals(), ["bsp"], -1)
                chip = bsp.make_chip()
                application.application(chip)
                compile_user_design(chip, working_directory)
                build_tool = bsp.build_tool
                build_tool(chip, bsp, working_directory)

    if "download" in sys.argv:
        download_tool = bsp.download_tool
        download_tool(chip, bsp, working_directory)

    if "run" in sys.argv:
        host.run()

except C2CHIPError as e:
    print e
