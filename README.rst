Chips-2.0 Demo for SP605 Development Card
=========================================

:Author: Jonathan P Dawson
:Date: 2013-10-15
:email: chips@jondawson.org.uk

Dependencies
============

You will need:

+ Xilinx ISE 12.0 or later (webpack edition is free)
+ Python 2.7 or later (but not Python 3)
+ Chips-2.0 (Included)
+ Xilinx SP605 Spartan 6 Development Kit.

Install
=======

Obtain SP605 Demo from:
        + xxxxx (zip archive)
        + xxxxx (clone with git)

Compile C 2 Verilog
====================

./synthesise compile

Build in ISE 
============

Edit the xilinx variable in the scripts/user_settings to point to the xilinx ISE install directory.

./synthesise build

Dowload to SP605 
================

./synthesise download

Setup and Test
==============

::
        
        +----------------+                 +---------------+
        | PC             |                 | Xilinx SP 605 |
        |                |   POWER =======>o               |
        |                |                 |               |
        |          USB   o<===============>o JTAG USB      |
        |                |                 |               |
        |          ETH0  o<===============>o ETHERNET      |
        |                |                 |               |
        | 192.168.1.0    |                 | 192.168.1.1   |
        +----------------+                 +---------------+


        + Connect ethernet port to SP605
        + Configure wthernet port with IP address 192.168.1.0 and subnet mask 255.255.255.0
        + Turn off TCP Window Scaling and TCP timestamps
        + Verify connection using ping command::

                 >ping 192.168.1.1

        + Connect to 192.168.1.1 using your favourite browser.

