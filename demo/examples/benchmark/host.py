import os
def run():
    print "1. connect (USB?) serial cable to host"
    print "2. launch terminal emulator software, and connect to dev card at 115200 baud 8n1"
    os.system("sudo cutecom")
