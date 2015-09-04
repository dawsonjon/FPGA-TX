from chips.api.api import Component, Chip, Input, Output, Stimulus, Response

atlys_simulation = Chip("atly_test_bench")
user_design = Component("source/user_design.c")

eth_values = Response(atlys_simulation, "eth_tx", "int")
rs232_values = Response(atlys_simulation, "rs232_tx", "int")
led_values = Response(atlys_simulation, "led", "int")

user_design(

    chip = atlys_simulation, 

    inputs = {
        "eth_rx": Stimulus(atlys_simulation, "eth_rx", "int", [0]),
        "rs232_rx": Stimulus(atlys_simulation, "rs232_rx", "int", [0]),
        "switches": Stimulus(atlys_simulation, "switches", "int", [0, 1, 2, 3, 4]),
        "buttons": Stimulus(atlys_simulation, "buttons", "int", [0]),
        "timer": Stimulus(atlys_simulation, "timer", "int", [0, 1]),
    },

    outputs = {
        "eth_tx": eth_values,
        "rs232_tx": rs232_values,
        "leds": led_values,
    }
)

atlys_simulation.simulation_reset()
atlys_simulation.simulation_run()
atlys_simulation.generate_verilog()

print "".join([chr(i) for i in rs232_values])
print list(led_values)
