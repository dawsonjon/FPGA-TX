Digital AM Radio Reception using Digital LVDS Inputs as 1-bit ADCs
===================================================================


IO pin as 1-bit ADC
-------------------

Modern FPGAs have IO pins capable of differential signalling at rates greater
than 1e9 bits/seconds. When configured as an input an LVDS input behaves as a
very high speed comparator. In this application, the input is used as an RF
ADC. It has a very low resolution of 1-bit, but the high bandwidth allows us to
oversample audio signals, allowing us to regain the necessary resolution at
audio bandwidths.

Hardware
--------


```
v
| random wire ~10m
|
|     +--------+  +----------------+  +-------+  +-----+  +-------+
+-----o  9:1   o----------------------o 30MHz o--o LNA o--o FPGA  |
      |        |  |   coax ~10m    |  | LPF   |  |     |  |       >--o audio
+-----o  unun  o--+----------------+--o       o--o     o--o       |
|     +--------+                      +-------+  +-----+  +-------+
- gnd
```


### FPGA Development Card

![Nexys 4](https://github.com/dawsonjon/FPGA-radio/raw/master/images/nexys_4.JPG)

The hardware consists of an [nexys 4 FPGA development
card](http://store.digilentinc.com/nexys-4-artix-7-fpga-trainer-board-limited-time-see-nexys4-ddr/)
which comes complete with an audio output. The XADC pmod connector allows us to
access a spare LVDS port.  On this card it is connected to a 3.3v bank, rather
than the 2.5v bank usually used for LVDS signalling. In this application, the
LVDS input runs happily at 3.3v, all we need to do is trick the tools into
allowing this configuration by configuring all the other IO on the same bank to
2.5v CMOS or TTL.

### Antenna

The RF input is obtained from a random wire antenna, this consists of around
10m of wire, and an earth connected to a 9:1 unun to achieve an approximate
match to the impedance of a length of coax cable. 

### Anti-aliasing filter

![Antialiasing Filter](https://github.com/dawsonjon/FPGA-radio/raw/master/images/filter.JPG)

Initially a sample rate of 100MHz has been chosen, this gives 50MHz of RF
bandwidth.  In the first Nyquist region, we can easily cover the long wave,
medium wave and short wave bands from 0.1-30MHz.

In order to prevent high frequency signals appearing as aliases, the signal is
first fed through a low pass filter with a cut-off frequency of 30MHz. A 5 pole
Chebychev filter with 1dB pass band ripple was designed using component values
determined from an [on-line calculator.](
https://www-users.cs.york.ac.uk/~fisher/lcfilter/)

### Low Noise Amplifier

![Low Noise Amplifier](https://github.com/dawsonjon/FPGA-radio/raw/master/images/LNA.JPG)

By itself, there is insufficient power at the end of the coax to cause the LVDS
input to toggle, a wide band low noise amplifier which is claimed to give
20-30dB gain over the range 0.1-1 GHz gives the boost in power needed for the
digital input to "see" the RF input.

### Transformer

![Transformer](https://github.com/dawsonjon/FPGA-radio/raw/master/images/transformer.JPG)

The output of the LNA is coupled to the FPGA input using a DIY RF transformer
with a 1:1 ratio. This converts the unbalanced signal to a differential signal,
and removes any DC component. The transformer consists of a 2
turn primary winding and 2 turn secondary winding on a toroidal ferrite core.

##Firmware

The FPGA firmware implements a direct conversion receiver that down-converts
the RF input to the audio range by mixing (multiplying) the input signal with a
local oscillator tuned to the carrier frequency of the wanted signal. 

The detected signal is then averaged over a number of samples, this both
reduces the sample rate to the audio sample rate, and increases the resolution
of the audio. This is where we trade the high bandwidth (many times that of the
audio signal) for a greater resolution in bits.

The audio samples pass through an Automatic Gain Control block (implemented in
software) before being passed out through 1-bit Delta-Sigma audio DAC.

### Numerically Controlled Oscillator

```
    +-----------+  +------------+
    | 32 bit    >--> Multiplier |             +---------+
    | counter   |  |            |             | Sin     |
    +-----------+  |            >---[31:22]---> Lookup  >--[9:0]---> LO
                   |            |             | Table   |
Frequency [31:0] -->            |             +---------+
                   +------------+
```

The local oscillator consists of 32-bit unsigned counter, which is multiplied
by a 32-bit frequency value supplied by the control software. The top 10 bits
then index a table of sin values, generating a scaled 10 bit signed output.
At the moment the table contains all values from -pi to +pi radians, but greater
resolutions could be achieved by exploiting the symmetry of the sine function.
1024 x 10 bits fits into a single FPGA Block RAM.

A Frequency resolution of 32 bits allows the LO to be tuned in the range 0 to Fs/2
in steps of Fs/(2^32). This gives a frequency resolution of ~0.02Hz at 100MHz.
This gives some flexibility to compensate for the +/-100ppm crystal oscillator,
even at higher sampling rates.

### Mixer

```

                                 +------------+
LO [9:0] ------------------------> Multiplier >--------> RF_TIMES_LO
                                 |            |
      +----------------+         |            |
RF ---> Remove DC Bias >--[1:0]-->            |
      +----------------+         +------------+
```

The LVDS input has an output of either 0 or 1 giving the signal a DC bias of 0.5.
This is easily removed by scaling to a 2 bit signed number of either -1 or +1.

The mixer generates two mixing products, F(carrier)+F(lo) and F(carrier)-F(lo).
Tuning F(lo) to F(carrier) places F(carrier)-F(lo) at 0, down-converting the
signal of interest to baseband. The F(carrier)+F(lo) product is much higher
than the baseband frequency and gets filtered out by the decimator. This mixer
should work with AM and single side band modulation, the lower side band gets
converted to a negative audio frequency, and the upper side band to a positive
one.

### Decimator

```
                         +----------+
RF_TIMES_LO[11:0] -------> Decimate >------[25:0]----> AUDIO
                         +----------+
```

The decimator performs the dual function of low pass filtering the signal, and
down sampling to the new sample rate.  A decimation factor of 8192 reduces the
sampling rate from 100MHz to about 12KHz. This should give us about 6.5 usable 
bits of audio resolution.

The decimator is the simplest possible, taking 8192 consecutive samples, and
adding them together to form 1 audio sample. This is equivalent to filtering
with a moving average filter, and throwing away 8191 in every 8192 samples. We
now have 26 bits, but no useful information is contained in the low order bits.
The AGC takes care of this, scaling the audio to fit into the 10-bit range of
the audio DAC.

This decimator leaves lots of room for improvement, a moving average filter has
a slow roll-off, and poor stop-band attenuation, the suppression of out-of-band
signals is not as good as it could be, and these signals will be aliased in the
passband.

A multi-stage CIC filter perhaps followed by a compensation FIR filter should
give better suppression of interfering signals.

### AGC

The AGC is a C component implemented in Chips. The AGC scales the audio data so
that it covers the range of the audio DAC as best as possible. This is achieved
by using a 'leaky' max hold to work out the maximum and minimum audio values
seen over a period of a few seconds. From here the centre and the range are
calculated. The attenuation needed to fit the DAC is ceiling(range/DAC range).
The audio is sample is (sample-centre)/attenuation.

## Testing

During the first experiments, a strong AM radio station was selected. A muffled
and almost inaudible voice was accompanied by a constant audio tone. After some
pondering, it became clear that the tone was due to a mismatch between the
local oscillator and carrier frequency. The carrier hadn't quite been
down converted to DC, but had fallen short and was heard as a tone in the audio
range. Adjusting the tuning frequency closer to the carrier reduced the pitch
of the audio tone. With careful tuning, the tone could be brought within 1 Hz
of the carrier frequency.

This brought on the next hurdle. With the frequencies almost matching, the
carrier and the local oscillator phased in and out, causing the audio to vary
between a strong positive signal when in phase, a strong negative signal when
in anti phase, and quiet periods when out of phase.

There seemed to be two possible solutions at this stage, either to find some
way of locking the phase of the local oscillator to the carrier, to generate a
second signal 90 degrees out of phase with the first, and to calculate the
absolute magnitude of the in-phase and in-quadrature channels. The second
approach was chosen because it seemed simpler, and would allow for some error
in tuning, with the carrier appearing as a constant DC level (which the AGC
would then remove) rather than a tone in the audio range.

The quadrature mixer was easy to arrange, being a copy of the original local
oscillator and mixer, but this time using a lookup table of cos instead of sin.
The absolute magnitude of the two channels was calculated using the CORDIC
algorithm. This has the side effect of also generating a phase output.  This
could be used as the basis of an FM demodulator since the frequency can be
calculated from the difference in phase between one sample and the next.

```
                +----+   +-----------+
RF -----+-------> X  |   | decimate  |  +----------------+
        | sin -->    >--->           >--> CORDIC         |
        |       +----+   +-----------+  | RECT_TO_POLAR  |
        |                               |                >----> magnitude
        |       +----+   +-----------+  |                |
        +-------> X  |   | decimate  |  |                >----> phase
          cos -->    >--->           >-->                |
                +----+   +-----------+  +----------------+
```

This resulted in an intelligible and steady signal, but there is still room
for improvement. A number of strong stations can be received in the medium
wave and short wave bands.


## Increasing Bandwidth

The first attempt to increase bandwidth was by using an IDDR primitive to capture
data on both the rising and falling edge of the clock effectively doubling the
sampling frequency. This first attempt to increase the sampling frequency to 200MHz
was successful, and a noticeable drop in noise was observed. Adjacent samples
are combined by adding, increasing the width by 1-bit going into the decimator.

```
      +------+                                   +------+  +-------------+
CLK --> IDDR >-- Q1 ----+---< *sin(t/2)   >------> ADD  |  | DECIMATE    |
RF --->      >-- Q2 -+  |                     +-->      >-->             |
      +------+       |  +---< *cos(t/2)   >-+ |  +------+  +-------------+
                     |                      | |
                     +------< *sin(t/2+1) >---+  +------+  +-------------+
                     |                      +----> ADD  |  | DECIMATE    |
                     +------< *cos(t/2+1) >------>      >-->             |
                                                 +------+  +-------------+
```

The next improvement in bandwidth was achieved using an ISERDES2 primitive,
this primitive converts a serial input from the pin, into a parallel bus.  The
ISERDES was set up in DDR mode, to provide an 8-bit parallel word. As with the
IDDR2 solution, multiple copies of the mixer and NCO are needed, this time 8.
Two support the ISERDES, 3 clocks are generated in a PLL, and are phase aligned
to the 100MHz clock driving the logic. A 100MHz clock drives the parallel
output registers. A 400 MHz clock and its compliment are used to capture the
incoming data.  A maximum of 1200MHz sampling rate could be achieved using this
method, probably the simplest way to achieve this would be to increase the
logic clock to 150 MHz. This would probably require the wide multipliers in the
NCO to be pipelined more efficiently.

## Conclusion (for now)
The LVDS input of an FPGA can be used to directly sample RF, without the need
for an ADC.  The key to achieving a reasonable SNR is to use a high bandwidth
which can be exchanged for better resolution in the decimation process.

Using this method, I have successfully received strong broadcast stations,
particularly strong signals from the nearby [Brookmans
Park](https://en.wikipedia.org/wiki/Brookmans_Park_transmitting_station) t was
also possible to receive short wave broadcasts. Removing the anti-aliasing
filter also allowed reception of the Luton Airport ATIS service on 120.575MHz.

Next steps:

+ Try to reduce interference from other signals
+ Try to demodulate FM
+ Try transmitting


