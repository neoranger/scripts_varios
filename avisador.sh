!#/bin/bash
USERID=$1 #your chat_id
KEY="keybot" #key del bot

TIMEOUT="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT=$2  #mensaje de aviso
PM="HTML"
curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=$TEXT&parse_mode=$PM" $URL > /dev/null
