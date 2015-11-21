from chips.api.api import Output
class Leds(Output):
    def __init__(self, chip, name):
        Output.__init__(self, chip, name)
    def data_sink(self, data):
        print "leds:", bin(data)
