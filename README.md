FPGA-TX
=======

FPGA-TX is an FPGA based radio transmitter, that can transmit using common
modulation schemes up to a frequency of 400MHz. 

Before you transmit, know your laws. FPGA-TX has not been tested for compliance
with regulations governing transmission of radio signals. You are responsible
for using your FPGA-TX legally.


Software
========

Prerequisites
-------------

### Python Modules

```
sudo apt-get install python-numpy python-scipy python-serial
```

tx.py -f=<frequency> -m=<mode>"

Accepts data from stdin in mono raw 16-bit pcm format

Sampling rate should be 12kS/s for AM, LSB and USB modes
Sampling rate must be specified for FM, WBFM and STEREO modes
For WBFM and STEREO, sampling rate must be greater than 30KHz,
44.1K or 48K are recommended.

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
sox test.wav -t raw -b 16 -r 12k - | ./tx.py -f=12e6 -m=fm -r=12000
```

####transmit stereo FM on 88 MHz
```
e.g. sox test.wav --channels 2 -t raw -b 16 -r 48k - | ./tx.py -f=88e6 -m=stereo -r 12000
```

####transmit lower sideband on 10 MHz
```
e.g. sox test.wav -t raw -b 16 -r 12k - | ./tx.py -f=100e6 -m=lsb
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
git clone https://github.com/dawsonjon/Chips-2.0.git
cd Chips-2.0
sudo python setup.py install
```

### Additional software
Requires the vendor's tools for the target FPGA card. Vivado webpack edition
can be downloaded from the [Xilinx](www.xilinx.com) website. You will need to
edit the demo/user_settings.py file to point to the location where Vivado is
installed.

Build Process
-------------

### Compiling the C code
This step is optional, you can use the precompiled files.

```
./run_demo tx nexys_4 compile
```

### Building the VHDL and Verilog into an FPGA bitstream
This step is optional, you can use the precompiled files.

```
./run_demo tx nexys_4 compile build
```

### Download the bitstream into FPGA (volatile)
Do this step if you want to try out the FPGA firmware without overwriting the SPI PROM.
The FPGA will lose its configuration each time it loses power.

```
./run_demo tx nexys_4 compile download
```

### Download the bitstream into SPI Flash (non-volatile)
Do this step if you want to program the SPI PROM on the FPGA card.
The FPGA will retain its configuration if power is lost.

```
./run_demo tx nexys_4 compile flash
```
