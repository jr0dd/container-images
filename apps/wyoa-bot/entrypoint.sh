#!/usr/bin/env bash

set -eu

cat << EOF > /app/config.json
{
  "token": "${DISCORD_TOKEN}",
  "clientId": "904197696158572596",
  "ownerID": "712785334903242834",
  "apiKeys": {
    "whalestream": {
      "staging": "${WHALESTREAM_STAGING}",
      "production": "${WHALESTREAM_PRODUCTION}"
    },
    "express": "${EXPRESS_JWT}",
    "youtube": "${YOUTUBE_API}",
    "finnhub": "${FINNHUB_API}",
    "iex": "${IEX_API}",
    "twitter": "${TWITTER_API}"
  },
  "webhooks": {
    "whalestream": "779557077235400711"
  }
}
EOF

exec node index.js
