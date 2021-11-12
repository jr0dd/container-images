#!/usr/bin/env bash

set -eu

cat << EOF > /app/config.json
{
    "token": "${TOKEN}",
    "clientId": "904197696158572596",
	"guildId": "779557077089124363" 
}
EOF

exec node index.js
