import os

def run():
    print "1. Connect ethernet to dev card"
    path = os.path.dirname(os.path.abspath(__file__))
    filename = os.path.join(path, "test.bmp")
    os.system('sudo python %s/send_images.py "%s"'%(path, filename))

if __name__ == "__main__":
    run()
