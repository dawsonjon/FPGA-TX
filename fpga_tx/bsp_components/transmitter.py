from numpy import *
from scipy import *
from scipy.signal import periodogram
from matplotlib.pyplot import *
from numpy.fft import fftshift

def plot_spurs(fs, t, quantized_lo, noise_shaped_lo):
    f, quantized_lo = periodogram(quantized_lo, fs, window="hann")
    f, noise_shaped_lo = periodogram(noise_shaped_lo, fs, window="hann")
    hold(True)
    #plot(f, 20.0*log10(quantized_lo))
    plot(f, 20.0*log10(noise_shaped_lo))
    show()


def noise_shape(x):
    return ((rand(len(x)) < ((x+1)*0.5))-0.5)*2.0


Fs = 800.0e6
Flo = 100.0e6
Fsignal = 1.0e3

t = arange(0.0, 1.0e-3, 1.0/Fs)
lo = sin(Flo * 2.0 * pi * t)
signal = sin(Fsignal  * 2.0 * pi * t) + cos(Fsignal  * 2.0 * pi * t)
plot(t, signal)
show()



