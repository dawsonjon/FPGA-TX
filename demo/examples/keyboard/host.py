import os

def run():
    print "Chips Demo keyboard example"
    print "1. Connect to Serial Port at 115200 baud using terminal emulator (e.g. hyperterm, cutecom ...)"
    print "2. Connect keyboard to development card"
    print "3. Hit reset button"
    os.system("sudo cutecom")
