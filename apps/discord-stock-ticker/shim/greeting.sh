#!/usr/bin/env bash

echo "
Welcome to the discord-stock-ticker container!
To list current running bots run:
"
echo -e "\033[96mcurl -s localhost:8080/ticker | jq -r\033[0m"
echo "**or**"
echo -e "\033[96mcurl -s localhost:8080/tickerboard | jq -r\033[0m"
