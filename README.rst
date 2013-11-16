Chips-2.0 Demo for SP605 Development Card
=========================================

:Author: Jonathan P Dawson
:Date: 2013-10-15
:email: chips@jondawson.org.uk


This project is intended to demonstrate the capabilities of the `Chips-2.0 <https://github.com/dawsonjon/Chips-2.0>`_  development environment. The project is targets the Xilinx Spartan 6 device, and more specifically, the Xilinx SP605 development platform. The demo implements a TCP/IP socket interface, and a simple web application. So far the demonstration has been tested on a Ubuntu Linux only.

Dependencies
============

You will need:

+ Xilinx ISE 12.0 or later (webpack edition is free)
+ Python 2.7 or later (but not Python 3)
+ Chips-2.0 (Included)
+ Xilinx SP605 Spartan 6 Development Kit.

Install
=======


You can download the full `zip archive <https://github.com/dawsonjon/SP605-Demo/archive/master.zip>`_ or, if you have git installed, you can clone the git the repository with git::

    $ git clone git@github.com:dawsonjon/SP605-Demo.git

Chips Compile
=============

To compile the c code in chips, issue the following command in the project folder::

    $ ./synthesise compile

Build in ISE 
============

Edit the xilinx variable in the scripts/user_settings to point to the xilinx ISE install directory. Then build the design using the following command::

    $ ./synthesise build

Download to SP605 
=================

Power up the SP605, and connect the JTAG USB cable to your PC. Run the download command::

    $ ./synthesise download

You can complete all three steps in one go using the *all* option::

    $ ./synthesise all

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

..

Connect the ethernet port to SP605, using a crossed over ethernet cable (which comes with the development kit).

Using the script, configure ethernet port with IP address 192.168.1.0 and subnet mask 255.255.255.0. Turn off TCP Window Scaling and TCP timestamps::

    $ ./configure_network

Verify connection using ping command::

    $ ping 192.168.1.1
    PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
    64 bytes from 192.168.1.1: icmp_req=2 ttl=255 time=0.207 ms
    64 bytes from 192.168.1.1: icmp_req=3 ttl=255 time=0.263 ms
    64 bytes from 192.168.1.1: icmp_req=4 ttl=255 time=0.124 ms
    64 bytes from 192.168.1.1: icmp_req=5 ttl=255 time=0.185 ms
    64 bytes from 192.168.1.1: icmp_req=6 ttl=255 time=0.275 ms
    --- 192.168.1.1 ping statistics ---
    6 packets transmitted, 5 received, 16% packet loss, time 5001ms
    rtt min/avg/max/mdev = 0.124/0.210/0.275/0.057 ms

Connect to 192.168.1.1 using your favourite browser.

.. image:: https://raw.github.com/dawsonjon/SP605-Demo/master/images/screenshot.png
