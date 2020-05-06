import os, sys
sys.path.append(os.path.join(os.path.dirname(__file__), "..\\..\\Project"))

import telebot
from ConvertersLogic.Enums.Temperature import Temperature
from ConvertersLogic.Converters.TemperatureConverter import TemperatureConverter

token = open("token.txt").read()
bot = telebot.TeleBot(token)

@bot.message_handler(content_types=["text"])
def lalala(message):
    try:
        bot.send_message(message.chat.id, str(TemperatureConverter().convert(message.text, Temperature.Celsius, Temperature.Kelvin)))
    except ValueError:
        bot.send_message(message.chat.id, "Please, type a number.")

bot.polling(none_stop=True)