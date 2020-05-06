from ConvertersLogic.Enums.Temperature import Temperature

class TemperatureConverter:
    def convert(self, value, currentSystem, targetSystem):
        if currentSystem == targetSystem:
            return float(value)
        elif currentSystem == Temperature.Celsius and targetSystem == Temperature.Kelvin:
            return float(value) + 273.15
        elif currentSystem == Temperature.Celsius and targetSystem == Temperature.Fahrenheit:
            return (float(value) * (9.0 / 5.0)) + 32.0
        elif currentSystem == Temperature.Kelvin and targetSystem == Temperature.Celsius:
            return float(value) - 273.15
        elif currentSystem == Temperature.Kelvin and targetSystem == Temperature.Fahrenheit:
            return self.convert(self.convert(value, Temperature.Kelvin, Temperature.Celsius), Temperature.Celsius, Temperature.Fahrenheit)
        elif currentSystem == Temperature.Fahrenheit and targetSystem == Temperature.Celsius:
            return (float(value) - 32.0) * (5.0 / 9.0)
        elif currentSystem == Temperature.Fahrenheit and targetSystem == Temperature.Kelvin:
            return self.convert(self.convert(value, Temperature.Fahrenheit, Temperature.Celsius), Temperature.Celsius, Temperature.Kelvin)
        else:
            return float("nan")