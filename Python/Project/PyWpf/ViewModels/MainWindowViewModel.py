from ViewModels.ViewModelBase import ViewModelBase
from Command import Command

class MainWindowViewModel(ViewModelBase):
    def __init__(self):
        ViewModelBase.__init__(self)
        self.WindowTitle = ""
        self.ChangeWindowTitleCommand = Command(self.setWindowTitle)
    
    def setWindowTitle(self):
        self.WindowTitle = "HELLO"
        self.RaisePropertyChanged("WindowTitle")