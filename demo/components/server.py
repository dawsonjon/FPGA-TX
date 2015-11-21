from chips.api.api import Chip, Component, Wire, Input, Output
from chips.components.components import line_arbiter


def server(chip, ethernet_rx, ethernet_tx, application_in, application_out, console_out):

    ip_rx = Component("ip_rx.c", options={"memory_size":64})
    ip_tx = Component("ip_tx.c", options={"memory_size":256})
    icmp = Component("icmp.c", options={"memory_size":1024})
    decoupler = Component("decoupler.c", options={"memory_size":64})
    tcp_rx = Component("tcp_rx.c", options={"memory_size":256})
    tcp_tx = Component("tcp_tx.c", options={"memory_size":1024})

    icmp_in = Wire(chip)
    icmp_out = Wire(chip)
    arp = Wire(chip)
    tcp_in = Wire(chip)
    tcp_out = Wire(chip)
    tcp_decoupler_in = Wire(chip)
    tcp_decoupler_out = Wire(chip)

    stdout = [Wire(chip) for i in range(5)]
    
    ip_rx(

        chip = chip,

        inputs = {
            "ethernet_in" : ethernet_rx,
        },

        outputs = {
            "icmp_out" : icmp_in,
            "tcp_out" : tcp_in,
            "arp" : arp,
            "cout" : stdout[0],
        },

        parameters = {}

    )


    ip_tx(

        chip = chip,

        inputs = {
            "icmp_in" : icmp_out,
            "tcp_in" : tcp_out,
            "arp" : arp,
        },

        outputs = {
            "ethernet_out" : ethernet_tx,
            "cout" : stdout[1],
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
            "cout" : stdout[2]
        },
        parameters = {}

    )

    decoupler(

        chip = chip,

        inputs = {
            "tcp_in" : tcp_decoupler_in,
        },

        outputs = {
            "tcp_out" : tcp_decoupler_out,
        },
        parameters = {}

    )

    tcp_rx(

        chip = chip,

        inputs = {
            "tcp_in" : tcp_in,
        },

        outputs = {
            "tcp_out" : tcp_decoupler_in,
            "application_out" : application_out,
            "cout" : stdout[3]
        },
        parameters = {}

    )

    tcp_tx(

        chip = chip,

        inputs = {
            "application_in" : application_in,
            "tcp_in" : tcp_decoupler_out,
        },

        outputs = {
            "tcp_out" : tcp_out,
            "cout" : stdout[4]
        },
        parameters = {}

    )

    line_arbiter(chip, stdout, console_out)


if __name__ == "__main__":

    import sys

    from demo.io_models.network import VirtualNetworkCard, NetworkIn, NetworkOut
    from demo.io_models.console import ConsoleOut
    from chips.components.components import constant
    from chips.utils.debugger import Debugger
    from chips.compiler.exceptions import C2CHIPError
    from chips.api.gui import GuiChip

    try:
        vnc = VirtualNetworkCard()
        chip = Chip("server")
        wire = Wire(chip)
        server(chip, 
            NetworkIn(chip, "eth_in", vnc), 
            NetworkOut(chip, "eth_out", vnc),
            wire,
            wire,
            ConsoleOut(chip, "stdout")
        )
        Debugger(chip)
    except C2CHIPError as e:
        print e.message
