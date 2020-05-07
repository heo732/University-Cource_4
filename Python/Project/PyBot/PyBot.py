import os, sys
sys.path.append(os.path.join(os.path.dirname(__file__), "..\\..\\Project"))

import telebot
from ConvertersLogic.Enums.Temperature import Temperature
from ConvertersLogic.Converters.TemperatureConverter import TemperatureConverter
from forex_python.converter import CurrencyRates

token = open("token.txt").read()
bot = telebot.TeleBot(token)
converter = CurrencyRates()

@bot.message_handler(content_types=["text"])
def lalala(message):
    try:
        bot.send_message(message.chat.id, str(converter.convert("USD", "EUR", float(message.text))))
    except Exception as e:
        bot.send_message(message.chat.id, e)

bot.polling(none_stop=True)