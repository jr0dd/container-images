#!/usr/bin/env bash

set -eu

cat << EOF > /app/config.json
{
  "token": "${DISCORD_TOKEN}",
  "clientId": "927621519859929148",
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
      "highlyUnusual": "904074376796835881",
      "unusual": "904080455157026917"
    },
    "free": {
      "highlyUnusual": "904071329551089745",
      "unusual": "904085056044273684"
    }
  }
}
EOF

exec node index.js
