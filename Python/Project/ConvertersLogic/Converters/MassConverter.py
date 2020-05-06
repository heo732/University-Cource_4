from ConvertersLogic.Enums.Mass import Mass

class MassConverter:
    def convert(self, value, currentSystem, targetSystem):
        if currentSystem == targetSystem:
            return float(value)
        else:
            return float("nan")