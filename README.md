FPGA-TX
=======

FPGA-TX is an FPGA based radio transmitter, that can transmit at frequencies up
to 400MHz. So far, FPGA-TX supports AM, FM, LSB, USB, Wideband FM, and Wideband
FM Stereo.

![screenshot](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/screenshot.png)

So far FPGA-TX has been tested on Ubuntu, but it uses portable libraries, so
could be ported to other platforms with a little effort.

Before you transmit, know your laws. FPGA-TX has not been tested for compliance
with regulations governing transmission of radio signals. You are responsible
for using FPGA-TX legally.


Software
========

Prerequisites
-------------

### Python Modules

FPGA-TX has some dependencies on Python modules. The software uses the sox tool
to provide a portable and flexible method for capturing/reading audio.

```
sudo apt-get install python-numpy python-scipy python-matplotlib python-serial sox
```

Serial Port Permissions
-----------------------

To run tx.py as an ordinary user, you need to grant read and write access to
the appropriate serial device. A convenient way to achieve this on Ubuntu based
systems is to add yourself to the dialout group.

```
sudo usermod -a -G dialout $USER
```

GUI transmitter (wxtx.py)
----------------------------
```
wxtx.py
```

Command line utility (tx.py)
----------------------------

```
tx.py -f=<frequency> -m=<mode>"
```

Accepts data from stdin in mono raw 16-bit pcm format

Options
-------

```
-f=<frequency>
```

Specify transmit frequency in Hz

```
-m=<mode>
```

Mode may be AM or FM

```
-d=<device>
```

specify USB/serial device of transmitter. default is /dev/ttyUSB1

Examples
--------


####transmit narrow band fm on 27MHz 

```
sox test.wav -t raw -b 16 -r 12k - | tx.py -f=12e6 -m=fm -r=12000
```

####transmit stereo FM on 88 MHz

```
sox myfile.mp3 --channels 2 -t raw -b 16 -r 48k - | tx.py -f=88e6 -m=stereo -r 12000
```

####transmit lower sideband on 10 MHz (using soundcard input, e.g. microphone)

```
rec -t raw -b 16 -r 12k - | tx.py -f=10e6 -m=lsb
```

FPGA Firmware
=============

Prerequisites
-------------

### Python Modules

```
sudo apt-get install python-numpy python-scipy python-serial
```

### Chips-2.0
You will need Chips-2.0 to build the FPGA embedded C code.

```
git clone --recursive https://github.com/dawsonjon/Chips-2.0.git
cd Chips-2.0
sudo python setup install
cd ..
```

### Additional software
Requires the vendor's tools for the target FPGA card. Vivado webpack edition
can be downloaded from the [Xilinx](www.xilinx.com) website. You will need to
edit the fpga_tx/user_settings.py file to point to the location where Vivado is
installed.

Build Process
-------------

### Clone the git repo

```
git clone https://github.com/dawsonjon/FPGA-TX.git
cd FPGA-TX
```


### Compiling the C code
This step is optional, you can use the precompiled files.

```
./run_fpga nexys_4 compile
```

### Building the VHDL and Verilog into an FPGA bitstream
This step is optional, you can use the precompiled files.

```
./run_fpga nexys_4 compile build
```

### Download the bitstream into FPGA (volatile)
Do this step if you want to try out the FPGA firmware without overwriting the
SPI PROM.  The FPGA will lose its configuration each time it loses power.

```
./run_fpga nexys_4 compile download
```

### Download the bitstream into SPI Flash (non-volatile)
Do this step if you want to program the SPI PROM on the FPGA card.
The FPGA will retain its configuration if power is lost.

```
./run_demo nexys_4 compile flash
```
