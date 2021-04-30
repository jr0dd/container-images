#!/usr/bin/env bash

echo "
Welcome to the discord-stock-ticker container!

To list current running bots run:
"
echo -e "\033[96mcurl -s localhost:8080/ticker | jq -r\033[0m"

echo "
* Repository: https://github.com/jr0dd/container-images/
* Repository: https://github.com/rssnyder/discord-stock-ticker
* Docs: https://github.com/jr0dd/charts/
* Docs: https://github.com/rssnyder/discord-stock-ticker
"
