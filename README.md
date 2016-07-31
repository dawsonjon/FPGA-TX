Chips Demo
==========

Try out some simple [Chips-2.0](http://pyandchips.org) applications on real hardware.

Supported FPGA cards
--------------------

Chips-Demo has been tested on the following hardware:

1. [nexys 4](http://store.digilentinc.com/nexys-4-artix-7-fpga-trainer-board-limited-time-see-nexys4-ddr/)
2. [atlys](http://store.digilentinc.com/atlys-spartan-6-fpga-trainer-board-limited-time-see-nexys-video/)

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

Download
--------

```
git clone --recursive https://github.com/dawsonjon/Chips-Demo.git
```

Pre-requisites
--------------

### Chips-2.0
The first thing you need is Chips-2.0. A compatible version is included in chips-demo. 

```
cd Chips-Demo
sudo python setup.py install
```

### Additional software
Requires the vendor's tools for the target FPGA card. This will be [Xilinx](www.xilinx.com) Vivado or ISE. For the atlys card, you will need to install the [Digilent Adept](http://store.digilentinc.com/digilent-adept-2-download-only/) 
download utility.

Some apps will require additional software to be installed on the target hardware. It would be worth installing the following software.

+ cutecom
+ python-pil
+ scipy

```
sudo apt-get install cutecom python-scipy python-pil python-scipy
```

Running the demonstrations
--------------------------

### Synopsis
```
./run_demo <application> <bsp> <compile|build|download|run>
```
+ *application* - is the name of the app to run
+ *bsp* - is the target FPGA development card
+ *compile* - compile the app into verilog with *Chips-2.0*
+ *build* - build an FPGA bitstream for the target FPGA using the FPGA vendor's tools
+ *run* - run a support application on the host PC e.g. cutecom

For example, the following command will compile, build and download the hello world project to a nexys_4 FPGA card, and launch a serial terminal.

./run_demo hello_world nexys_4 compile build download run

