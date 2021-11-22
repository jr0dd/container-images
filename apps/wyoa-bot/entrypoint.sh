#!/usr/bin/env bash

set -eu

cat << EOF > /app/config.json
{
  "token": "${TOKEN}",
  "clientId": "900047624781037598",
  "ownerID": "712785334903242834",
  "apiKeys": {
	  "youtube": "${YOUTUBE_API}",
    "finnhub": "${FINNHUB_API}",
    "iex": "${IEX_API}",
    "twitter": "${TWITTER_API}"
  }
}
EOF

node index.js
