#!/usr/bin/env bash

set -eu

cat << EOF > /app/config.json
{
    "token": "${TOKEN}",
    "clientId": "904197696158572596",
    "ownerId": "712785334903242834"
}
EOF

exec node index.js
