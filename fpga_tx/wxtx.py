#!/usr/bin/env python

import subprocess
import threading

from numpy import arange, sin, pi, linspace
import matplotlib
matplotlib.use('WXAgg')

from matplotlib.backends.backend_wxagg import FigureCanvasWxAgg as FigureCanvas
from matplotlib.backends.backend_wx import NavigationToolbar2Wx
from matplotlib.figure import Figure

import wx
import wx.lib.filebrowsebutton as filebrowse

import tx

modes = ["AM", "FM", "WBFM", "LSB", "USB", "STEREO"]
sources = ["Soundcard", "File"]
device = "/dev/ttyUSB1"

def setup_plot(figure, axes):
    axes.clear()
    figure.subplots_adjust(left=0.2, bottom=0.2)
    figure.set_facecolor('0.1')
    axes.spines['bottom'].set_color('0.9')
    axes.spines['top'].set_color('0.9') 
    axes.spines['right'].set_color('0.9')
    axes.spines['left'].set_color('0.9')
    axes.yaxis.label.set_color('0.9')
    axes.xaxis.label.set_color('0.9')
    axes.tick_params(axis='x', colors='0.9')
    axes.tick_params(axis='y', colors='0.9')
    axes.set_xlabel("Frequency (kHz)")
    axes.set_ylabel("Magnitude (dB)")
    axes.grid(color='0.8')

def transmit(frequency, mode, source, input_file, cutoff, deviation):
    if mode.upper() == "AM":
        fs = 12000
        channels = 1
        modulator = tx.AMModulator(
            frequency=frequency,
            cutoff=cutoff,
            sample_rate=12000
        )
    elif mode.upper() == "USB":
        fs = 12000
        channels = 1
        modulator = tx.SSBModulator(
            frequency=frequency,
            cutoff=cutoff,
            sample_rate=12000
        )
    elif mode.upper() == "LSB":
        fs = 12000
        channels = 1
        modulator = tx.SSBModulator(
            frequency=frequency,
            sample_rate=12000,
            cutoff=cutoff,
            lsb = True
        )
    elif mode.upper() == "FM":
        fs = 12000
        channels = 1
        modulator = tx.FMModulator(
            frequency=frequency,
            sample_rate=12000,
            cutoff=cutoff,
            fm_deviation=deviation,
        )
    elif mode.upper() == "WBFM":
        fs = 48000
        channels = 1
        modulator = tx.WBFMModulator(
            frequency=frequency,
            sample_rate=48000,
            cutoff=cutoff,
            fm_deviation=deviation,
        )
    elif mode.upper() == "STEREO":
        fs = 48000
        channels = 2
        modulator = tx.StereoModulator(
            frequency=frequency,
            sample_rate=48000,
            cutoff=cutoff,
            fm_deviation=deviation,
        )

    #Use sox to capture/resample input
    if source == "File":
        pipe = subprocess.Popen(
            "/usr/bin/sox %s -r %u -b 16 -t raw --channels %u -"%(
                input_file, fs, channels), 
            stdout=subprocess.PIPE, 
            shell=True
        )
    else:
        pipe = subprocess.Popen(
            "/usr/bin/rec -r %u -b 16 -t raw --channels %u -"%(
                fs, channels), 
            stdout=subprocess.PIPE, 
            shell=True
        )

    transmitter = tx.Transmitter(device, modulator)

    #run the transmitter in its own thread
    transmit_thread = threading.Thread(
        group=None, 
        target=transmitter.transmit, 
        args=(pipe.stdout,)
    )
    transmit_thread.start()
    return transmitter, transmit_thread, pipe

class CanvasPanel(wx.Panel):
    def __init__(self, parent):
        wx.Panel.__init__(self, parent)

        self.transmitter=None

        self.figure = Figure(figsize=(0.5, 0.5))
        self.axes   = self.figure.add_subplot(111, axisbg='0.1')
        self.canvas = FigureCanvas(self, -1, self.figure)
        setup_plot(self.figure, self.axes)

        self.vsizer = wx.BoxSizer(wx.VERTICAL)
        self.settings_sizer = wx.BoxSizer(wx.VERTICAL)
        self.freq_sizer = wx.BoxSizer(wx.HORIZONTAL)
        self.lpf_sizer = wx.BoxSizer(wx.HORIZONTAL)
        self.fm_deviation_sizer = wx.BoxSizer(wx.HORIZONTAL)
        self.source_sizer = wx.BoxSizer(wx.HORIZONTAL)
        self.mode_sizer = wx.BoxSizer(wx.HORIZONTAL)

        self.frequency = wx.TextCtrl(self, value="30000000")
        self.lpf       = wx.TextCtrl(self, value="3000")
        self.fm_deviation = wx.TextCtrl(self, value="5000")
        self.fm_deviation.Disable()
        self.mode      = wx.Choice(self, choices=modes)
        self.source    = wx.Choice(self, choices=sources)
        self.input_file_button = filebrowse.FileBrowseButton(self, labelText="Input File:")
        self.input_file_button.Disable()
        self.tx = wx.ToggleButton(self, label="TX")
        self.Bind(wx.EVT_TOGGLEBUTTON, self.on_transmit, self.tx)
        self.Bind(wx.EVT_CHOICE, self.on_mode, self.mode)
        self.Bind(wx.EVT_CHOICE, self.on_source, self.source)

        self.vsizer.Add(self.canvas, 1, wx.EXPAND | wx.ALL)

        self.freq_sizer.Add(wx.StaticText(self, label="Frequency (Hz): "), 0, wx.CENTER)
        self.freq_sizer.Add(self.frequency, 1)
        self.vsizer.Add(self.freq_sizer, 0, wx.EXPAND | wx.ALL, 5)

        self.lpf_sizer.Add(wx.StaticText(self, label="Audio Cutoff (Hz): "), 0, wx.CENTER)
        self.lpf_sizer.Add(self.lpf, 1)
        self.vsizer.Add(self.lpf_sizer, 0, wx.EXPAND | wx.ALL, 5)

        self.fm_deviation_sizer.Add(wx.StaticText(self, label="FM Deviation (Hz): "), 0, wx.CENTER)
        self.fm_deviation_sizer.Add(self.fm_deviation, 1)
        self.vsizer.Add(self.fm_deviation_sizer, 0, wx.EXPAND | wx.ALL, 5)

        self.mode_sizer.Add(wx.StaticText(self, label="Mode:"), 0, wx.CENTRE)
        self.mode_sizer.Add(self.mode, 1, wx.EXPAND | wx.ALL)
        self.vsizer.Add(self.mode_sizer, 0, wx.EXPAND | wx.ALL, 5)

        self.source_sizer.Add(wx.StaticText(self, label="Source:"), 0, wx.CENTRE)
        self.source_sizer.Add(self.source, 1, wx.EXPAND | wx.ALL)
        self.vsizer.Add(self.source_sizer, 0, wx.EXPAND | wx.ALL, 5)

        self.vsizer.Add(self.input_file_button, 0, wx.EXPAND | wx.ALL, 5)
        self.vsizer.Add(self.tx, 0, wx.EXPAND, 10)

        self.SetSizer(self.vsizer)
        self.Fit()

        self.line = None
        self.t1 = wx.Timer(self)
        self.t1.Start(400)
        self.Bind(wx.EVT_TIMER, self.update_plot)

    def update_plot(self, event):
        if self.transmitter is not None:
            if not self.transmitter_thread.is_alive():
                self.stop_transmit()
                return
            if not hasattr(self.transmitter.modulator, "fft"):
               return
            fft = self.transmitter.modulator.fft
            nyq = self.transmitter.modulator.nyq
            f = linspace(-nyq, nyq, len(fft))
            if self.line is None:
                setup_plot(self.figure, self.axes)
                self.axes.set_xlim([-nyq, nyq])
                self.axes.set_ylim([-100.0, 100.0])
                self.line = self.axes.plot(f, fft, linewidth='1.0', color='green')[0]
            else:
                self.line.set_xdata(f)
                self.line.set_ydata(fft)
            self.figure.canvas.draw()

    def stop_transmit(self):
        #terminate the process creating the input data
        self.transmitter.stop = True
        self.transmitter_thread.join()
        self.transmitter_pipe.terminate()
        del(self.transmitter)
        self.transmitter = None
        self.transmitter_thread = None
        self.transmitter_pipe = None
        self.line = None
        self.tx.SetValue(False)

    def on_source(self, event):
        source = sources[self.source.GetCurrentSelection()]
        if source.upper() == "FILE":
            self.input_file_button.Enable()
        elif source.upper() == "SOUNDCARD":
            self.input_file_button.Disable()

    def on_mode(self, event):
        mode = modes[self.mode.GetCurrentSelection()]
        if mode.upper() == "AM":
            self.lpf.SetValue("5000")
            self.fm_deviation.SetValue("5000")
            self.fm_deviation.Disable()
        elif mode.upper() == "LSB":
            self.lpf.SetValue("3000")
            self.fm_deviation.SetValue("5000")
            self.fm_deviation.Disable()
        elif mode.upper() == "USB":
            self.lpf.SetValue("3000")
            self.fm_deviation.SetValue("5000")
            self.fm_deviation.Disable()
        elif mode.upper() == "FM":
            self.lpf.SetValue("5000")
            self.fm_deviation.SetValue("5000")
            self.fm_deviation.Enable()
        elif mode.upper() == "WBFM":
            self.lpf.SetValue("15000")
            self.fm_deviation.SetValue("150000")
            self.fm_deviation.Enable()
        elif mode.upper() == "STEREO":
            self.lpf.SetValue("15000")
            self.fm_deviation.SetValue("150000")
            self.fm_deviation.Enable()


    def on_transmit(self, event):
        if event.IsChecked():
            frequency = float(self.frequency.GetValue())
            cutoff = float(self.lpf.GetValue())
            deviation = float(self.fm_deviation.GetValue())
            mode = modes[self.mode.GetCurrentSelection()]
            source = sources[self.source.GetCurrentSelection()]
            input_file = self.input_file_button.GetValue()
            (
                self.transmitter, 
                self.transmitter_thread, 
                self.transmitter_pipe
            )=transmit(
                frequency, 
                mode, 
                source, 
                input_file,
                cutoff,
                deviation,
            )
        else:
            if self.transmitter is not None:
                self.stop_transmit()

app = wx.PySimpleApp()
fr = wx.Frame(None, title='wxtx')
panel = CanvasPanel(fr)
fr.Show()
app.MainLoop()
