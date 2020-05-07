import os, sys
sys.path.append(os.path.join(os.path.dirname(__file__), "..\\..\\Project"))

import telebot
from telebot.types import InlineKeyboardMarkup, InlineKeyboardButton
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

#-----------------------------------------
callback_converterTemperature = "cb_c_t"
callback_converterMass = "cb_c_m"
callback_converterCurrency = "cb_c_c"
#-----------------------------------------
callback_inputUnitCelsius = "cb_iu_c"
callback_outputUnitCelsius = "cb_ou_c"
callback_inputUnitFahrenheit = "cb_iu_f"
callback_outputUnitFahrenheit = "cb_ou_f"
callback_inputUnitKelvin = "cb_iu_k"
callback_outputUnitKelvin = "cb_ou_k"
#-----------------------------------------
#-----------------------------------------

def getKeyboardMarkup_Converters():
    markup = InlineKeyboardMarkup()
    markup.row_width = 3
    markup.add(InlineKeyboardButton("Temperature", callback_data=callback_converterTemperature), InlineKeyboardButton("Mass", callback_data=callback_converterMass), InlineKeyboardButton("Currency", callback_data=callback_converterCurrency))
    return markup

@bot.message_handler(commands=["selectConverterType"])
def selectConverterType(message):
    try:
        bot.send_message(message.chat.id, "Select converter type", reply_markup=getKeyboardMarkup_Converters())
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
        answer = "Converter: "

        if type(currentConverter) is TemperatureConverter:
            #bot.send_message(message.chat.id, str(currentConverter.convert(float(message.text), currentInputUnit, currentOutputUnit)))
            answer += "Temperature\n"
        elif type(currentConverter) is MassConverter:
            #bot.send_message(message.chat.id, str(currentConverter.convert(float(message.text), currentInputUnit, currentOutputUnit)))
            answer += "Mass\n"
        elif type(currentConverter) is CurrencyRates:
            #bot.send_message(message.chat.id, str(currentConverter.convert(float(message.text), currentInputUnit, currentOutputUnit)))
            answer += "Currency\n"
        else:
            bot.send_message(message.chat.id, "Something wrong.")

        bot.send_message(message.chat.id, answer)
    except Exception as e:
        bot.send_message(message.chat.id, e)

@bot.callback_query_handler(func=lambda call: True)
def callback_query(call):
    global currentConverter

    if call.data == callback_converterTemperature:
        currentConverter = TemperatureConverter()
    elif call.data == callback_converterMass:
        currentConverter = MassConverter()
    elif call.data == callback_converterCurrency:
        currentConverter = CurrencyRates()
    else:
        bot.send_message(call.chat.id, "Something wrong")
        
    bot.answer_callback_query(call.id, str(type(currentConverter)))

bot.polling(none_stop=True)