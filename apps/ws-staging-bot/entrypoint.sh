#!/usr/bin/env bash

set -eu

cat << EOF > /app/config.json
{
  "token": "${DISCORD_TOKEN}",
  "clientId": "931366584394584164",
  "ownerID": "712785334903242834",
  "apiKeys": {
    "whalestream": {
      "staging": "${WHALESTREAM_STAGING}",
      "production": "${WHALESTREAM_PRODUCTION}"
    },
    "express": "${EXPRESS_JWT}",
    "finnhub": "${FINNHUB_API}"
  },
  "webhooks": {
    "premium": {
      "highlyUnusual": "931282876870307883",
      "unusual": "931282876870307884"
    },
    "free": {
      "highlyUnusual": "931307834535206983",
      "unusual": "931307650795315291"
    }
  }
}
EOF

exec node index.js
