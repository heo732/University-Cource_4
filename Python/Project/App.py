import wpf
from System.Windows import Application, Window
from ViewModels.MainWindowViewModel import MainWindowViewModel

class MyWindow(Window):
    def __init__(self):
        wpf.LoadComponent(self, 'MainWindow.xaml')
        self.DataContext = MainWindowViewModel()

if __name__ == '__main__':
    Application().Run(MyWindow())