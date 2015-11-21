from chips.api.api import Input, Output
from pytun import TunTapDevice, IFF_TAP, IFF_NO_PI
import Queue
import threading


class VirtualNetworkCard:
    def __init__(self, ip='192.168.1.0', netmask='255.255.255.0'):
        tap = TunTapDevice(flags=IFF_TAP|IFF_NO_PI, name="tap0")
        tap.mtu = 1500
        tap.addr = ip
        tap.netmask = netmask
        self.tap = tap
        self.tap.up()

class NetworkOut(Output):
    def __init__(self, chip, name, net):
        Output.__init__(self, chip, name)
        self.net = net
        self.packet_len=0
        self.buff=""

    def data_sink(self, data):
        if not self.packet_len:
            self.packet_len = data
        else:
            byte = (data >> 8) & 0xff
            self.buff += chr(byte)
            self.packet_len -= 1
            if self.packet_len:
                byte = data & 0xff
                self.buff += chr(byte)
                self.packet_len -= 1
        if not self.packet_len and self.buff:
            self.net.tap.write(self.buff)
            self.buff = ""

    
class NetworkIn(Input):
    def __init__(self, chip, name, net):
        Input.__init__(self, chip, name)
        self.packet_len=0
        self.buff = ""
        self.src_rdy=False
        self.queue = Queue.Queue(1)
        self.net = net
        t = threading.Thread(target=self.read_network)
        t.start()

    def read_network(self):
        while 1:
            self.queue.put(self.net.tap.read(1500))
            self.next_src_rdy=True

    def simulation_update(self):
        self.dst_rdy = self.next_dst_rdy
        self.src_rdy = self.next_src_rdy
        if self.update_data:
            self.q = self.data_source()

    def data_source(self):
        if not self.buff:
           self.buff = self.queue.get()
           self.queue.task_done()
           self.next_src_rdy=False
           return len(self.buff)
        else:
           byte = ord(self.buff[0])
           word = byte << 8
           self.buff = self.buff[1:]
           if self.buff:
               byte = ord(self.buff[0])
               word |= byte & 0xff
               self.buff = self.buff[1:]
           return word
