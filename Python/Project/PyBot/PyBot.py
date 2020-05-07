import os, sys
sys.path.append(os.path.join(os.path.dirname(__file__), "..\\..\\Project"))

import telebot
from ConvertersLogic.Enums.Temperature import Temperature
from ConvertersLogic.Converters.TemperatureConverter import TemperatureConverter
from ConvertersLogic.Enums.Mass import Mass
from ConvertersLogic.Converters.MassConverter import MassConverter
from forex_python.converter import CurrencyRates

token = open("token.txt").read()
bot = telebot.TeleBot(token)

currentConverter = TemperatureConverter()
currentInputUnit = Temperature.Celsius
currentOutputUnit = Temperature.Kelvin

@bot.message_handler(commands=["selectConverterType"])
def selectConverterType(message):
    try:
        pass
    except Exception as e:
        bot.send_message(message.chat.id, e)

@bot.message_handler(commands=["selectInputUnit"])
def selectInputUnit(message):
    try:
        pass
    except Exception as e:
        bot.send_message(message.chat.id, e)

@bot.message_handler(commands=["selectOutputUnit"])
def selectOutputUnit(message):
    try:
        pass
    except Exception as e:
        bot.send_message(message.chat.id, e)

@bot.message_handler(content_types=["text"])
def sendAnswer(message):
    try:
        if type(currentConverter) is TemperatureConverter:
            bot.send_message(message.chat.id, str(currentConverter.convert(float(message.text), currentInputUnit, currentOutputUnit)))
    except Exception as e:
        bot.send_message(message.chat.id, e)

bot.polling(none_stop=True)