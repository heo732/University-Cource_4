import os, sys
sys.path.append(os.path.join(os.path.dirname(__file__), "..\\..\\Project"))

import telebot
from telebot.types import ReplyKeyboardMarkup, ReplyKeyboardRemove
from ConvertersLogic.Enums.Temperature import Temperature
from ConvertersLogic.Converters.TemperatureConverter import TemperatureConverter
from ConvertersLogic.Enums.Mass import Mass
from ConvertersLogic.Converters.MassConverter import MassConverter
from forex_python.converter import CurrencyRates

token = open("token.txt").read()
bot = telebot.TeleBot(token)

currentConverter = TemperatureConverter()
currentTemperatureInputUnit = Temperature.Fahrenheit
currentTemperatureOutputUnit = Temperature.Celsius
currentMassInputUnit = Mass.Pound
currentMassOutputUnit = Mass.Kilogram
currentCurrencyInputUnit = "USD"
currentCurrencyOutputUnit = "UAH"

str_SomethingWrong = "Something wrong."
str_InputUnitPrefix = "in_"
str_OutputUnitPrefix = "out_"

str_Temperature = "Temperature"
str_Mass = "Mass"
str_Currency = "Currency"

str_Celsius = "Celsius"
str_Fahrenheit = "Fahrenheit"
str_Kelvin = "Kelvin"

def isNumber(s):
    try:
        float(s)
        return True
    except Exception:
        return False

def getConverterChangedString(converter):
    return "Converter changed to: " + converter

def getInputUnitChangedString(unit, converter):
    return "Input unit of " + converter + " converter changed to: " + unit

def getOutputUnitChangedString(unit, converter):
    return "Output unit of " + converter + " converter changed to: " + unit

def getKeyboardMarkup_Converters():
    markup = ReplyKeyboardMarkup()
    markup.row(str_Temperature, str_Mass, str_Currency)
    return markup

def getKeyboardMarkup_TemperatureUnits(prefix):
    markup = ReplyKeyboardMarkup()
    markup.row(prefix + str_Celsius, prefix + str_Fahrenheit, prefix + str_Kelvin)
    return markup

@bot.message_handler(commands=["converter"])
def selectConverterType(message):
    try:
        bot.send_message(message.chat.id, "Select converter type:", reply_markup=getKeyboardMarkup_Converters())
    except Exception as e:
        bot.send_message(message.chat.id, e)

@bot.message_handler(commands=["input_unit"])
def selectInputUnit(message):
    try:
        markup = None

        if type(currentConverter) is TemperatureConverter:
            markup = getKeyboardMarkup_TemperatureUnits(str_InputUnitPrefix)
        elif type(currentConverter) is MassConverter:
            #markup = getKeyboardMarkup_MassUnits(str_InputUnitPrefix)
            pass
        elif type(currentConverter) is CurrencyRates:
            #markup = getKeyboardMarkup_CurrencyUnits(str_InputUnitPrefix)
            pass
        else:
            bot.send_message(message.chat.id, str_SomethingWrong)

        bot.send_message(message.chat.id, "Select input unit:", reply_markup=markup)
    except Exception as e:
        bot.send_message(message.chat.id, e)

@bot.message_handler(commands=["output_unit"])
def selectOutputUnit(message):
    try:
        markup = None

        if type(currentConverter) is TemperatureConverter:
            markup = getKeyboardMarkup_TemperatureUnits(str_OutputUnitPrefix)
        elif type(currentConverter) is MassConverter:
            #markup = getKeyboardMarkup_MassUnits(str_OutputUnitPrefix)
            pass
        elif type(currentConverter) is CurrencyRates:
            #markup = getKeyboardMarkup_CurrencyUnits(str_OutputUnitPrefix)
            pass
        else:
            bot.send_message(message.chat.id, str_SomethingWrong)

        bot.send_message(message.chat.id, "Select input unit:", reply_markup=markup)
    except Exception as e:
        bot.send_message(message.chat.id, e)

@bot.message_handler(content_types=["text"])
def sendAnswer(message):
    try:
        global currentConverter, currentTemperatureInputUnit, currentTemperatureOutputUnit, currentMassInputUnit, currentMassOutputUnit, currentCurrencyInputUnit, currentCurrencyOutputUnit
        converter = ""
        inputUnit = ""
        outputUnit = ""
        outputValue = ""
        m = message.text
        is_number = isNumber(m)

        if is_number:
            if type(currentConverter) is TemperatureConverter:
                outputValue = str(currentConverter.convert(float(m), currentTemperatureInputUnit, currentTemperatureOutputUnit))
                converter = str_Temperature
                inputUnit = str(currentTemperatureInputUnit)
                outputUnit = str(currentTemperatureOutputUnit)
            elif type(currentConverter) is MassConverter:
                outputValue = str(currentConverter.convert(float(m), currentMassInputUnit, currentMassOutputUnit))
                converter = str_Mass
                inputUnit = str(currentMassInputUnit)
                outputUnit = str(currentMassOutputUnit)
            elif type(currentConverter) is CurrencyRates:
                outputValue = str(currentConverter.convert(currentCurrencyInputUnit, currentCurrencyOutputUnit, float(m)))
                converter = str_Currency
                inputUnit = str(currentCurrencyInputUnit)
                outputUnit = str(currentCurrencyOutputUnit)
            else:
                bot.send_message(message.chat.id, str_SomethingWrong)
                return

            bot.send_message(message.chat.id, "Converter: " + converter + "\n" + "Input unit: " + inputUnit + "\n" + "Output unit: " + outputUnit + "\n" + "Input value: " + m + "\n" + "Output value: " + outputValue, reply_markup=ReplyKeyboardRemove())
        else:
            what_changed_str = ""

            if m == str_Temperature:
                currentConverter = TemperatureConverter()
                what_changed_str = getConverterChangedString(str_Temperature)
            elif m == str_Mass:
                currentConverter = MassConverter()
                what_changed_str = getConverterChangedString(str_Mass)
            elif m == str_Currency:
                currentConverter = CurrencyRates()
                what_changed_str = getConverterChangedString(str_Currency)

            elif m == str_InputUnitPrefix + str_Celsius:
                currentTemperatureInputUnit = Temperature.Celsius
                what_changed_str = getInputUnitChangedString(str_Celsius, str_Temperature)
            elif m == str_InputUnitPrefix + str_Fahrenheit:
                currentTemperatureInputUnit = Temperature.Fahrenheit
                what_changed_str = getInputUnitChangedString(str_Fahrenheit, str_Temperature)
            elif m == str_InputUnitPrefix + str_Kelvin:
                currentTemperatureInputUnit = Temperature.Kelvin
                what_changed_str = getInputUnitChangedString(str_Kelvin, str_Temperature)

            elif m == str_OutputUnitPrefix + str_Celsius:
                currentTemperatureOutputUnit = Temperature.Celsius
                what_changed_str = getOutputUnitChangedString(str_Celsius, str_Temperature)
            elif m == str_OutputUnitPrefix + str_Fahrenheit:
                currentTemperatureOutputUnit = Temperature.Fahrenheit
                what_changed_str = getOutputUnitChangedString(str_Fahrenheit, str_Temperature)
            elif m == str_OutputUnitPrefix + str_Kelvin:
                currentTemperatureOutputUnit = Temperature.Kelvin
                what_changed_str = getOutputUnitChangedString(str_Kelvin, str_Temperature)
            else:
                return

            bot.send_message(message.chat.id, what_changed_str, reply_markup=ReplyKeyboardRemove())
    except Exception as e:
        bot.send_message(message.chat.id, e)

bot.polling(none_stop=True)