varicodes = [
"1010101011",  #00  NUL Null character
"1011011011",  #01  SOH Start of Header
"1011101101",  #02  STX Start of Text
"1101110111",  #03  ETX End of Text
"1011101011",  #04  EOT End of Transmission
"1101011111",  #05  ENQ Enquiry
"1011101111",  #06  ACK Acknowledgment
"1011111101",  #07  BEL Bell
"1011111111",  #08  BS  Backspace
"11101111",    #09  HT  Horizontal Tab
"11101",       #0A  LF  Line feed
"1101101111",  #0B  VT  Vertical Tab
"1011011101",  #0C  FF  Form feed
"11111",       #0D  CR  Carriage return
"1101110101",  #0E  SO  Shift Out
"1110101011",  #0F  SI  Shift In
"1011110111",  #10  DLE Data Link Escape
"1011110101",  #11  DC1 Device Control 1 (XON)
"1110101101",  #12  DC2 Device Control 2
"1110101111",  #13  DC3 Device Control 3 (XOFF)
"1101011011",  #14  DC4 Device Control 4
"1101101011",  #15  NAK Negative Acknowledgement
"1101101101",  #16  SYN Synchronous Idle
"1101010111",  #17  ETB End of Trans. Block
"1101111011",  #18  CAN Cancel
"1101111101",  #19  EM  End of Medium
"1110110111",  #1A  SUB Substitute
"1101010101",  #1B  ESC Escape
"1101011101",  #1C  FS  File Separator
"1110111011",  #1D  GS  Group Separator
"1011111011",  #1E  RS  Record Separator
"1101111111",  #1F  US  Unit Separator
"1",           #20  SP
"111111111",   #21  !
"101011111",   #22  "
"111110101",   #23  #
"111011011",   #24  $
"1011010101",  #25  %
"1010111011",  #26  &
"101111111",   #27  '
"11111011",    #28  (
"11110111",    #29  )
"101101111",   #2A  *
"111011111",   #2B  +
"1110101",     #2C  ,
"110101",      #2D  -
"1010111",     #2E  .
"110101111",   #2F  /
"10110111",    #30  0
"10111101",    #31  1
"11101101",    #32  2
"11111111",    #33  3
"101110111",   #34  4
"101011011",   #35  5
"101101011",   #36  6
"110101101",   #37  7
"110101011",   #38  8
"110110111",   #39  9
"11110101",    #3A  :
"110111101",   #3B  ;
"111101101",   #3C  <
"1010101",     #3D  =
"111010111",   #3E  >
"1010101111",  #3F  ?
"1010111101",  #40  @
"1111101",     #41  A
"11101011",    #42  B
"10101101",    #43  C
"10110101",    #44  D
"1110111",     #45  E
"11011011",    #46  F
"11111101",    #47  G
"101010101",   #48  H
"1111111",     #49  I
"111111101",   #4A  J
"101111101",   #4B  K
"11010111",    #4C  L
"10111011",    #4D  M
"11011101",    #4E  N
"10101011",    #4F  O
"11010101",    #50  P
"111011101",   #51  Q
"10101111",    #52  R
"1101111",     #53  S
"1101101",     #54  T
"101010111",   #55  U
"110110101",   #56  V
"101011101",   #57  W
"101110101",   #58  X
"101111011",   #59  Y
"1010101101",  #5A  Z
"111110111",   #5B  [
"111101111",   #5C  \
"111111011",   #5D  ]
"1010111111",  #5E  ^
"101101101",   #5F  _
"1011011111",  #60  `
"1011",        #61  a
"1011111",     #62  b
"101111",      #63  c
"101101",      #64  d
"11",          #65  e
"111101",      #66  f
"1011011",     #67  g
"101011",      #68  h
"1101",        #69  i
"111101011",   #6A  j
"10111111",    #6B  k
"11011",       #6C  l
"111011",      #6D  m
"1111",        #6E  n
"111",         #6F  o
"111111",      #70  p
"110111111",   #71  q
"10101",       #72  r
"10111",       #73  s
"101",         #74  t
"110111",      #75  u
"1111011",     #76  v
"1101011",     #77  w
"11011111",    #78  x
"1011101",     #79  y
"111010101",   #7A  z
"1010110111",  #7B  {
"110111011",   #7C  |
"1010110101",  #7D  }
"1011010111",  #7E  ~
"1110110101",  #7F  DEL
]

import struct
import sys

import numpy as np
import matplotlib.pyplot as plt
import scipy.signal as signal
import scipy.io.wavfile as wav

def encode(message, sample_rate, baud_rate, subcarrier_frequency):
    n = sample_rate//baud_rate

    #varicode message
    varicoded = "".join([varicodes[ord(i)]+"0000" for i in message])
    varicoded = "1111110000" + varicoded + "000001111111"

    #phase code
    one  = np.ones(n) 
    zero = np.concatenate([
            np.cos(np.linspace(0, np.pi, n/2))+1,
            np.cos(np.linspace(0, np.pi, n/2))-1
    ])*0.5

    phase = 1
    phase_codes = []
    for i in varicoded:
        if i=='1':
            phase_codes.append(phase*one)
        else:
            phase_codes.append(phase*zero)
            phase *= -1
    phase_coded = np.concatenate(phase_codes)


    #add subcarrier
    t = np.arange(0, len(phase_coded))
    subcarrier = np.sin(2*np.pi*t*subcarrier_frequency/sample_rate)

    plt.plot(phase_coded*subcarrier)
    plt.show()
    return phase_coded * subcarrier

pcm_fp = encode("hello world", 8000, 31.25, 1000)*0.5
wav.write("psk.wav", 8000, pcm_fp)

