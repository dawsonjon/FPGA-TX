#!/usr/bin/env python

"""compile, build and download the ATLYS demo to the ATLYS development kit"""

import sys
import os
import shutil

from user_settings import vivado as vivado_path

def digilent(chip, bsp, working_directory):
    print "Downloading bit file to development kit ...."
    board = bsp.board
    retval = os.system("sudo djtgcfg prog -d %s -i 0 -f %s/bsp.bit"%(board, working_directory))
    if retval != 0:
        sys.exit(-1)

def vivado(chip, bsp, working_directory):
    print "Downloading bit file to development kit ...."
    current_directory = os.getcwd()
    os.chdir(working_directory)
    download_script = open("download.tcl", "w")
    download_script.write(
    """open_hw
    connect_hw_server
    open_hw_target
    current_hw_device [lindex [get_hw_devices xc7a100t_0] 0]
    refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7a100t_0] 0]
    set_property PROBES.FILE {} [lindex [get_hw_devices] 0]
    set_property PROGRAM.FILE {bsp.bit} [lindex [get_hw_devices xc7a100t_0] 0]
    program_hw_devices [lindex [get_hw_devices xc7a100t_0] 0]
    refresh_hw_device [lindex [get_hw_devices xc7a100t_0] 0]
    """)
    download_script.close()
    retval = os.system("%s/vivado -mode batch -source download.tcl"%vivado_path) 
    if retval != 0: 
        sys.exit(-1) 
    os.chdir(current_directory)

