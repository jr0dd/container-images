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
  }
}
EOF

exec node index.js
