from ConvertersLogic.Enums.Temperature import Temperature

class TemperatureConverter:
    def convert(self, value, currentUnit, targetUnit):
        if currentUnit == targetUnit:
            return float(value)
        elif currentUnit == Temperature.Celsius and targetUnit == Temperature.Kelvin:
            return float(value) + 273.15
        elif currentUnit == Temperature.Celsius and targetUnit == Temperature.Fahrenheit:
            return (float(value) * (9.0 / 5.0)) + 32.0
        elif currentUnit == Temperature.Kelvin and targetUnit == Temperature.Celsius:
            return float(value) - 273.15
        elif currentUnit == Temperature.Kelvin and targetUnit == Temperature.Fahrenheit:
            return self.convert(self.convert(value, Temperature.Kelvin, Temperature.Celsius), Temperature.Celsius, Temperature.Fahrenheit)
        elif currentUnit == Temperature.Fahrenheit and targetUnit == Temperature.Celsius:
            return (float(value) - 32.0) * (5.0 / 9.0)
        elif currentUnit == Temperature.Fahrenheit and targetUnit == Temperature.Kelvin:
            return self.convert(self.convert(value, Temperature.Fahrenheit, Temperature.Celsius), Temperature.Celsius, Temperature.Kelvin)
        else:
            return float("nan")