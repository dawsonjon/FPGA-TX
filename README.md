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

You will need ![Chips-2.0](www.pyandchips.org) to build the FPGA embedded C code.

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


## Hardware

###FPGA Dev kit

At present, two development cards are supported, the [Digilent Nexys
4](http://store.digilentinc.com/) was used in the first prototypes, the
[Digilent CMOD__A7](http://store.digilentinc.com/) (the 15T version) doesn't
have so many unnecessary peripherals, has a more convenient USB-dongle form
factor, and makes a good basis for a transmitter project.

###Transmitter Prototype

After some initial experiments had been made to establish that the popular
transmission modes could be synthesised in software, a prototype transmitter
was built to demonstrate that the FPGA could be incorporated into a self
contained communications transmitter.

The transmitter prototype consists of an FPGA module to act as a controller
and modulator, a small wideband RF Power Amplifier, and circuitry to allow
an antenna to be switched between transmit and receive modes.

The prototype requires an external 12v power supply to provide sufficient power
for the RF amplifier. When operating the CMOD A7 under USB power, programming
of the flash was unreliable.  To overcome this, a diode was removed from the
CMOD, and an external 5V regulator was used to power the CMOD. This resulted in
much more reliable flash programming.


###Amplifier

The first experiments used a very short length of wire attached to a PMOD
connector, allowing test signals to be picked up a few feet away. To build a
more powerful transmitter a small inexpensive 2 watt broadband amplifier was
purchased on e-ba for use in the transmitter prototype.

![Amplifier](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/amplifier.jpg)

###Attenuator

The FPGA pin is configured to providean 3.3v LVTTL output with the maximum
drive strength of 24mA. Assuming that the LVTTL output can source 24mA and a
2.0V swing, the output impedance of the FPGA is assumed to be approximately 80
ohms. 

With a pk-pk voltage swing of 2V, the RMS voltage swing for a sin wave is
approximately 0.7V. With a load impedance of 80 ohms, the RMS power can be
estimated to be 6.25 mW, or about 8dBm. The wideband amplifier has an input
impedance of 50 ohms, and has a maximum input power of 0dBm. An attenuation of
15dB was chosen to allow some margin.

A pi attenuator was designed using an [online
calculator](http://chemandy.com/calculators/matching-pi-attenuator-calculator.htm).
Resistance values of 120 ohms, 68 ohms and 180 ohms were selected for the
input, output and series resistor respectively.

![Attenuator](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/attenuator.png)

In the prototype the filter is constructed using leaded resistors.

![Attenuator Prototype](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/attenuator_prototype.jpg)

###Filter

In the digital domain, dithering has been used to minimise the harmonic and
spurious signals within the band of interest (0-400MHz). The harmonics a
spurious signal power has not been removed, but spread evenly across the band
in the form of wideband noise.

There is nothing that can be done in the digital domain to remove harmonic and
spurious signals outside the band. For this reason, low pass filter with a cut-off
frequency of 400MHz is added before the amplifier.

An [online calculator](https://www-users.cs.york.ac.uk/~fisher/lcfilter/) was
used to calculate the component values for a fifth order Chebyshev filter with
1dB passband ripple and an impedance of 50 ohms.

![Filter](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/filter.png)

In the prototype, the surface mount capacitors and inductors can only just be made out.

![Filter Prototype](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/filter_prototype.jpg)

###TX/RX Switching

The FPGA module provides two signals to switch between RX and TX modes, TX_PA
turns the amplifier on and off, TX_RX connects and disconnects the receiver
from the antenna. The transmitter is permanently connected to the antenna.

Each signal is fed through an opto-isolator. The TX_PA signal turns on a relay
supplying 12V to the power amplifier. TX_RX controls 2 MOSFETs, one connects or
isolates the receiver, the other shorts the receiver connection during RX mode.
In addition, signal diodes prevent large signals reaching the receiver. A 3rd
MOSFET simply acts as an inverter.

![TX RX switch](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/tx_rx_switch.png)

The MOSFET circuit is based on [this tx rx switch](http://www.n5ese.com/tr_switch.htm). The prototype switch is shown below.


![TX RX switch prototype](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/tx_rx_switch_prototype.jpg)

The FPGA adds additional delay in the TX_RX path. This is to allow for any
delay in the relays switching the power amplifier, and ensures that the
receiver is always isolated while the power amplifier is switching on and off.
![Filter](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/filter.png)

###GPS Calibration

The crystal oscillators used in FPGA development cards typically have an
accuracy of the order +/- 100PPM.  At a frequency of 400MHz, this would give an
error of +/- 40KHz which is clearly not acceptable when communication channels
are typically 12.5KHz wide.

One possibility would be to use a more accurate external oscillator, these are
available with accuracies of around +/-0.1ppm.

An other possibility is to make use of low cost GPS modules. These provide a
reference signal with a period of 1 second. A counter within the firmware
allows us to measure the number of 100MHz clock cycles that occur during each 1
second pulse. This gives us a method of measuring how fast or slow the clock is
running, and allows us to calculate a correction to the commanded frequency.

![gps](https://raw.githubusercontent.com/dawsonjon/FPGA-TX/master/images/gps.jpg)

