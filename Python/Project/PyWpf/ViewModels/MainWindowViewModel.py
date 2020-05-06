import os, sys, wpf
sys.path.append(os.path.join(os.path.dirname(__file__), "..\\..\\..\\Project"))

from ViewModels.ViewModelBase import ViewModelBase
from Command import Command
from ConvertersLogic.Enums.Temperature import Temperature
from ConvertersLogic.Enums.Mass import Mass
from ConvertersLogic.Converters.TemperatureConverter import TemperatureConverter
from ConvertersLogic.Converters.MassConverter import MassConverter
from System.Windows import MessageBox

class MainWindowViewModel(ViewModelBase):
    def __init__(self):
        ViewModelBase.__init__(self)
        self.WindowTitle = ""
        self.ChangeWindowTitleCommand = Command(self.show)
    
    def setWindowTitle(self):
        self.WindowTitle = "HELLO"
        self.RaisePropertyChanged("WindowTitle")

    def show(self):
        MessageBox.Show(str(MassConverter().convert(10051, Mass.Ounce, Mass.Gram)))