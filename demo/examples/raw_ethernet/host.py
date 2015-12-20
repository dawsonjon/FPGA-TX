import os
def run():
    print "1. Connect Ethernet cable from host to development card"
    path = os.path.dirname(os.path.abspath(__file__))
    os.system("sudo python %s/test_ethernet.py"%path)
