#!/usr/bin/env bash

set -eu

cat << EOF > /app/config.json
{
  "token": "${TOKEN}",
  "clientId": "927621519859929148",
  "ownerID": "712785334903242834",
  "apiKeys": {
    "express": "${EXPRESS_JWT}",
    "finnhub": "${FINNHUB_API}"
  }
}
EOF

exec node index.js
