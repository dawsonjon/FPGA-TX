#!/usr/bin/env python

from numpy import arange, sin, pi
import matplotlib
matplotlib.use('WXAgg')

from matplotlib.backends.backend_wxagg import FigureCanvasWxAgg as FigureCanvas
from matplotlib.backends.backend_wx import NavigationToolbar2Wx
from matplotlib.figure import Figure

import wx
import  wx.lib.filebrowsebutton as filebrowse

class CanvasPanel(wx.Panel):
    def __init__(self, parent):
        wx.Panel.__init__(self, parent)

        self.figure = Figure(figsize=(1, 1))
        self.axes = self.figure.add_subplot(111)
        self.canvas = FigureCanvas(self, -1, self.figure)

        self.vsizer = wx.BoxSizer(wx.VERTICAL)
        self.hsizer = wx.BoxSizer(wx.HORIZONTAL)

        self.settings_sizer = wx.BoxSizer(wx.VERTICAL)
        self.freq_sizer = wx.BoxSizer(wx.HORIZONTAL)
        self.mode_sizer = wx.BoxSizer(wx.VERTICAL)

        self.frequency = wx.TextCtrl(self, value="30000000")
        self.stereo = wx.RadioButton(self, label='Stereo', style=wx.RB_GROUP)
        self.wbfm   = wx.RadioButton(self, label='WBFM')
        self.fm     = wx.RadioButton(self, label='FM')
        self.am     = wx.RadioButton(self, label='AM')
        self.lsb    = wx.RadioButton(self, label='LSB')
        self.usb    = wx.RadioButton(self, label='USB')
        self.ptt    = wx.Button(self, label="TX")
        self.sound_card = wx.RadioButton(self, label='Soundcard', style=wx.RB_GROUP)
        self.file_input = wx.RadioButton(self, label='File')
        self.input_file_button = filebrowse.FileBrowseButton(self)

        self.vsizer.Add(self.canvas, 1, wx.EXPAND | wx.ALL)
        self.vsizer.Add(self.hsizer, 0, wx.EXPAND | wx.ALL)

        self.hsizer.Add(self.mode_sizer, 1)
        self.hsizer.Add(self.settings_sizer, 2)

        self.mode_sizer.Add(wx.StaticText(self, label="Mode:"), 0)
        self.mode_sizer.Add(self.stereo, 0)
        self.mode_sizer.Add(self.wbfm, 0)
        self.mode_sizer.Add(self.fm, 0)
        self.mode_sizer.Add(self.am, 0)
        self.mode_sizer.Add(self.lsb, 0)
        self.mode_sizer.Add(self.usb, 0)

        self.freq_sizer.Add(wx.StaticText(self, label="Frequency (Hz)"), 0, wx.CENTER)
        self.freq_sizer.Add(self.frequency, 0)
        self.settings_sizer.Add(self.freq_sizer, 0, wx.LEFT)
        self.settings_sizer.Add(wx.StaticText(self, label="Source:"), 0, wx.LEFT)
        self.settings_sizer.Add(self.sound_card, 0, wx.LEFT)
        self.settings_sizer.Add(self.file_input, 0, wx.LEFT)
        self.settings_sizer.Add(self.input_file_button, 0, wx.LEFT)
        self.settings_sizer.Add(self.ptt, 0, wx.LEFT)


        self.SetSizer(self.vsizer)
        self.Fit()

    def draw(self):
        t = arange(0.0, 3.0, 0.01)
        s = sin(2 * pi * t)
        self.axes.plot(t, s)
        self.axes.grid()


if __name__ == "__main__":
    app = wx.PySimpleApp()
    fr = wx.Frame(None, title='wxtx')
    panel = CanvasPanel(fr)
    panel.draw()
    fr.Show()
    app.MainLoop()
