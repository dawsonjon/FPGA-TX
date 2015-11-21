from pytun import TapTunnel

tap = TapTunnel()
name="tap0"
tap.addr = '192.168.2.0'
tap.netmask = '255.255.255.0'
tap.mtu = 1500

while(1):
    print(tap.recv(1500))
