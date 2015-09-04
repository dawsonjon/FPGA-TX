from chips.api.api import Chip, Component, Wire, Input, Output
from chips.compiler.exceptions import C2CHIPError
import sys

class Console(Output):
    def __init__(self, chip, name):
        Output.__init__(self, chip, name)
        self.buf = ""
    def data_sink(self, data):
        self.buf += chr(data);
        if self.buf[-1] == "\n":
            print self.buf
            self.buf = ""
        #sys.stdout.flush()

def server(chip, ethernet_rx, ethernet_tx):

    ip_rx = Component("ip_rx.c")
    ip_tx = Component("ip_tx.c")
    icmp = Component("icmp.c")

    icmp_in = Wire(chip)
    icmp_out = Wire(chip)
    arp = Wire(chip)

    ip_rx(

        chip = chip,

        inputs = {
            "ethernet_in" : ethernet_rx,
        },

        outputs = {
            "icmp_out" : icmp_in,
            "arp" : arp,
            "cout" : Console(chip, "blah")
        },

        parameters = {}

    )

    ip_tx(

        chip = chip,

        inputs = {
            "icmp_in" : icmp_out,
            "arp" : arp,
        },

        outputs = {
            "ethernet_out" : ethernet_tx,
            "cout" : Console(chip, "blah1")
        },
        parameters = {}

    )

    icmp(

        chip = chip,

        inputs = {
            "icmp_in" : icmp_in,
        },

        outputs = {
            "icmp_out" : icmp_out,
            "cout" : Console(chip, "blah2")
        },
        parameters = {}

    )

if __name__ == "__main__":

    from chips.api.gui import GuiChip
    from pytun import TunTapDevice, IFF_TAP, IFF_NO_PI
    tap = TunTapDevice(flags=IFF_TAP|IFF_NO_PI, name="tap0")
    tap.addr = '192.168.1.0'
    tap.netmask = '255.255.255.0'
    tap.mtu = 1500
    tap.up()

    class NetworkOut(Output):
        def __init__(self, chip, name):
            Output.__init__(self, chip, name)
            self.packet_len=0
            self.buff=""
        def data_sink(self, data):
            #print self.packet_len, data
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
                print "sending"
                tap.write(self.buff)
                self.buff = ""

    class NetworkIn(Input):
        def __init__(self, chip, name):
            Input.__init__(self, chip, name)
            self.packet_len=0
            self.buff = ""
        def data_source(self):
            if not self.buff:
               self.buff = tap.read(1500)
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

    def ready(self):
        if not self.buff:
            return tap in select.select([tap], [], [])[0]
        return True

    try:
        chip = GuiChip("server")
        server(chip, NetworkIn(chip, "eth_in"), NetworkOut(chip, "eth_out"))
        chip.debug()
    except C2CHIPError as e:
        print e.message
