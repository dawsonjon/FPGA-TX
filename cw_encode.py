codes = {
"a" : ".-",
"b" : "-...",
"c" : "-.-.",
"d" : "-..",
"e" : ".",
"f" : "..-.",
"g" : "--.",
"h" : "....",
"i" : "..",
"j" : ".---",
"k" : "-.-",
"l" : ".-..",
"m" : "--",
"n" : "-.",
"o" : "---",
"p" : ".--.",
"q" : "--.-",
"r" : ".-.",
"s" : "...",
"t" : "-",
"u" : "..-",
"v" : "...-",
"w" : ".--",
"x" : "-..-",
"y" : "-.--",
"z" : "..--",
" " : " ",
"0" : "-----",
"1" : ".----",
"2" : "..---",
"3" : "...--",
"4" : "....-",
"5" : ".....",
"6" : "-....",
"7" : "--...",
"8" : "---..",
"9" : "----.",
"." : ".-.-.-",
"," : "--..--",
":" : "---...",
"?" : "..--..",
"'" : ".----.",
"-" : "-....-",
"/" : "-..-.",
"(" : "-.--.-",
")" : "-.--.-",
'"' : ".-..-.",
"@" : ".--.-.",
"=" : "-...-",
"\n": ".-.-",
}

import numpy as np
import matplotlib.pyplot as plt
import scipy.io.wavfile as wav
import sys

def encode(message, fs, wpm, pitch):
    words_per_second = wpm / 60.0
    dots_per_second = words_per_second*50.0
    dot_length = 1.0/dots_per_second

    t = np.arange(0, dot_length, 1.0/fs) 
    dit = np.sin(2.0 * np.pi * t * pitch)
    dit *= np.cos(np.linspace(-np.pi, np.pi, len(dit))) * 0.5 + 0.5
    t = np.arange(0, 3*dot_length, 1.0/fs) 
    dah = np.sin(2.0 * np.pi * t * pitch)
    rising_edge = np.cos(np.linspace(-np.pi, 0, len(dit)/2)) * 0.5 + 0.5
    falling_edge = np.cos(np.linspace(0, np.pi, len(dit)/2)) * 0.5 + 0.5
    dah *= np.concatenate([
        rising_edge,
        np.ones(len(dah)-len(rising_edge)-len(falling_edge)),
        falling_edge,
    ])
    off = np.zeros(dot_length * fs)

    modulation = []
    for letter in message:
        symbols = codes.get(letter.lower(), "x")
        for character in symbols:
            if character == ".":
                modulation.append(dit)
                modulation.append(off)
            elif character == "-":
                modulation.append(dah)
                modulation.append(off)
            elif character == " ":
                modulation.append(off)
                modulation.append(off)
        modulation.append(off)
        modulation.append(off)


    return np.concatenate(modulation)
    

pcm_fp = encode(sys.argv[1], 8000, 20, 1000)
wav.write("cw.wav", 8000, pcm_fp)
