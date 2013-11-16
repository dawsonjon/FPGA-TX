input_file = open("packet")

byte = 0
for lineno, line in enumerate(input_file):
    if lineno == 0:
        print line

    else:
        high = int(line) >> 8
        low = int(line) & 0xff
        print byte, lineno, high, low, chr(high), chr(low)
        byte += 2
    
