#!/usr/bin/env bash

echo "
Welcome to the discord-stock-ticker container!
To list current running bots run:

curl -s localhost:8080/ticker | jq -r

-or-

curl -s localhost:8080/tickerboard | jq -r
"