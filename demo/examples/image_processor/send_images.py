from PIL import Image
import random
import struct
import time
from raw_ethernet import *

def send_images(filename):
    user_select_adaptor()

    #read test image
    im = Image.open(filename)
    image_data = list(im.getdata())
    width, height = im.size
    
    #communicate
    t0 = time.clock()
    new_image = []
    for i in range(256):
        row = struct.pack(">" + "h"*256, *image_data[:256])
        image_data = image_data[256:]
        send(row)
        new_row = struct.unpack(">" + "h"*256, get())
        new_image.extend(new_row)
    t1 = time.clock()
    bytes_sent = width * height * 2
    time_taken = t1-t0
    print bytes_sent, "bytes transferred in", time_taken, "seconds"
    print ((bytes_sent/time_taken) * 8)/1000000, "Mbits/s"

    #show the result
    new_im = Image.new(im.mode, (width, height))
    new_im.putdata(new_image)
    new_im.show() 
    new_im.save("out.bmp") 

if __name__ == "__main__":
    send_images(sys.argv[1])
