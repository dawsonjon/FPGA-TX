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

## Python Modules

FPGA-TX has some dependencies on Python modules. The software uses the sox tool
to provide a portable and flexible method for capturing/reading audio.

```
sudo apt-get install python-numpy python-scipy python-serial python-wxgtk3.0 python-matplotlib sox git
```

## Serial Port Permissions

To run tx as an ordinary user, you need to grant read and write access to
the appropriate serial device. A convenient way to achieve this on Ubuntu based
systems is to add yourself to the dialout group.

```
sudo usermod -a -G dialout $USER
```

## Install

```
git clone https://github.com/dawsonjon/FPGA-TX.git
cd FPGA-TX
sudo python setup.py install
```

## GUI transmitter (wxtx)

```
wxtx
```

## Command line utility (tx)

```
tx -f=<frequency> -m=<mode>"
```

Accepts data from stdin in mono raw 16-bit pcm format

### Options

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

### Examples


####transmit narrow band FM on 27MHz 

```
sox test.wav -t raw -b 16 -r 12k - | tx -f=12e6 -m=fm -r=12000
```

####transmit stereo FM on 88 MHz

```
sox myfile.mp3 --channels 2 -t raw -b 16 -r 48k - | tx -f=88e6 -m=stereo -r 12000
```

####transmit lower sideband on 10 MHz (using soundcard input, e.g. microphone)

```
rec -t raw -b 16 -r 12k - | tx -f=10e6 -m=lsb
```

FPGA Firmware
=============

## Install Python Modules

```
sudo apt-get install python-numpy python-scipy python-serial
```

## Install Chips-2.0

You will need [Chips-2.0](http://www.pyandchips.org) to build the FPGA embedded C code.

```
git clone --recursive https://github.com/dawsonjon/Chips-2.0.git
cd Chips-2.0
sudo python setup.py install
cd ..
```

## Install Additional software

Requires the vendor's tools for the target FPGA card. Vivado webpack edition
can be downloaded from the [Xilinx](www.xilinx.com) website. You will need to
edit the fpga_tx/user_settings.py file to point to the location where Vivado is
installed.

## Clone the git repo

```
git clone https://github.com/dawsonjon/FPGA-TX.git
cd FPGA-TX
```

## Compiling the C code
This step is optional, you can use the precompiled files.

```
./run_fpga nexys_4 compile
```

## Building the VHDL and Verilog into an FPGA bitstream
This step is optional, you can use the precompiled files.

```
./run_fpga nexys_4 compile build
```

## Download the bitstream into FPGA (volatile)
Do this step if you want to try out the FPGA firmware without overwriting the
SPI PROM.  The FPGA will lose its configuration each time it loses power.

```
./run_fpga nexys_4 compile download
```

## Download the bitstream into SPI Flash (non-volatile)
Do this step if you want to program the SPI PROM on the FPGA card.
The FPGA will retain its configuration if power is lost.

```
./run_demo nexys_4 compile flash
```

Technical Details
=================

## FPGA Firmware

The FPGA firmware consists of 2 major parts, the transmitter written in VHDL,
and the Controller written in C (using Chips to convert to Verilog).

![Firmware](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/firmware.png)

### The Transmitter

The transmitter allows both Quadrature Amplitude Modulation, and Frequency 
modulation. The sample rate is 800 MHz, while the clock rate is 100 MHz, in
each clock cycle, 8 samples are processed. In general, this is achieved by 
implementing 8 parallel data paths.

![Transmitter](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/transmitter.png)


### NCO

The NCO is based on a 32 bit accumulator which generates the phase, the phase
is fed into a lookup table of sin or cosine values. A 32 bit accumulator gives
a resolution 0.186 Hz with an 800 MHz Sample Rate.

![NCO](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/nco.png)

However, since we are working at a sampling frequency of 800 MHz, with a clock
frequency of 100 MHz, it is necassary to calculate the next 8 output samples
each clock cycle. The sequence should be: accumulator, accumulator + frequency,
accumulator + 2 * frequency .. accumulator + 7 * frequency. Since muliplication
by a power of 2 is a much cheaper opperation, a tree can be employed to
calculated these values using shifts and adds. The logic paths can easily be
broken using pipeline registers, so long as the feedback loop only has a one
clock cycle latency.

![NCO](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/ncox8.png)

### Interpolate

The Interpolate block increases the sample rate of the I/Q data by 65536. With
an output sampling rate of 800 MHz, the input sampling rate is 12000 Hz. The
Interpolate block is based on an first order CIC filter. The first step is a
differentiator, followed by an up-sampler, and finally an integrator.

### Up-convert

The IQ data is up converted to the carrier frequency, by multiplying by the cos
and -sin components of the NCO. The sin and cosine components are added to form
complex samples. 

### DAC Interface

The first function of the DAC interface is to perform 1-bit quantization. 
In this design, there isn't any Digital to Analog converter, only a digital FPGA
pin.  Dithering is performed to reduce in-band harmonics. Dithering is achieved by
comparing the data to a random number, the result is a single bit output whose
probability of being 1 is proportional to the signal level. This has the same
effect as adding -6dB of broadband noise to the signal.

The effects of dithering can be seen in the following plots. In both plots, the
fundamental frequency is set to 110 MHz. With no dithering, there are many spurious
and harmonic emissions, with the largest being the third harmonic at 330 MHz. 

With dithering applied, the strength of the third harmonic is greatly reduced,
and there are fewer spurious emissions. The power contained in the harmonics
has been spread evenly across the spectrum. 

In the third plot a low pass filter has been added.

![Without dithering](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/110_mhz_no_dither.png)
![With dithering](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/110_mhz_dithered.png)
![With dithering and filter](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/110_mhz_dithered_filtered.png)


The second function is to serialise the 8 parallel data streams into a single
stream of data before outputting on a logic pin. This is achieved using an
OSERDES component.

