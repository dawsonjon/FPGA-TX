Chips Demo
==========

Try out some simple Chips-2.0 applications on real hardware.

Supported FPGA cards
--------------------

Chips-Demo has been tested on the following hardware.

nexys_4
'''''''

http://store.digilentinc.com/nexys-4-artix-7-fpga-trainer-board-limited-time-see-nexys4-ddr/


atlys
'''''

http://store.digilentinc.com/atlys-spartan-6-fpga-trainer-board-limited-time-see-nexys-video/


Demonstration Apps
------------------

These demonstration apps show how Chips-2.0 can be used with real hardware. The
demonstrations are not complex, but could form the basis of a more complex
project.

+ hello_world
+ keyboard
+ tri_color
+ image_processor
+ audio_output
+ clock
+ svga_hello_world
+ temperature
+ raw_ethernet
+ seven_segment
+ web_server
+ enigma_machine
+ knight_rider
+ benchmark

Pre-requisites
--------------

Requires the vendor's tools for the target FPGA card. This will be Xilinx
Vivado or ISE. For the atlys card, you will need to install the Digilent Adept
download utility.

Download
--------

Running the demonstrations
--------------------------

Synopsis
''''''''

./run_demo <application> <bsp> <compile|build|download|run>

e.g. The following command will compile, build and download the hello world project to a nexys_4 FPGA card, and launch a serial terminal.

./run_demo hello_world nexys_4 compile build download run


