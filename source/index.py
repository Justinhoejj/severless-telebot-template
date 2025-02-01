import json
import telebot
import os

# Get bot token from AWS Lambda environment variables
TOKEN = os.environ['TELEGRAM_BOT_TOKEN']
bot = telebot.TeleBot(TOKEN)

def lambda_handler(event, context):
    try:
        # Parse incoming message
        body = json.loads(event['body'])
        
        if "message" in body:
            chat_id = body['message']['chat']['id']
            text = body['message']['text']
            
            # Echo the received text
            bot.send_message(chat_id, f"You said: {text}")
        
        return {"statusCode": 200, "body": json.dumps("Message Processed")}
    
    except Exception as e:
        print(f"Error: {e}")
        return {"statusCode": 500, "body": json.dumps("Internal Server Error")}