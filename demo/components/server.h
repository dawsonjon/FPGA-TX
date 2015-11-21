////////////////////////////////////////////////////////////////////////////////
//
//  CHIPS-2.0 TCP/IP SERVER
//
//  :Author: Jonathan P Dawson
//  :Date: 17/10/2013
//  :email: chips@jondawson.org.uk
//  :license: MIT
//  :Copyright: Copyright (C) Jonathan P Dawson 2013
//
//  A TCP/IP stack that supports a single socket connection.
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// TCP-IP User Settings
//
const unsigned local_mac_address_hi = 0x0001u;
const unsigned local_mac_address_med = 0x0203u;
const unsigned local_mac_address_lo = 0x0405u;
const unsigned local_ip_address_hi = 0xc0A8u;//192/168
const unsigned local_ip_address_lo = 0x0101u;//1/1
//const unsigned local_port = 80u;//http
const unsigned local_port = 23u;//telnet

const unsigned listen = 0;
const unsigned syn_seen = 1;
const unsigned established = 2;
const unsigned wait_close = 3;

const unsigned resendcount = 1000;
const unsigned maxtimeout = 30000000;//30 seconds
const unsigned MTU = 1500 /*Ethernet MTU*/
-20 /*ip header*/
-20; /*tcp_header*/
const unsigned HALF_MTU = 730;
