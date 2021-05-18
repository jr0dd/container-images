#!/usr/bin/env bash

source "/shim/umask.sh"

if [[ ! -d /config/uploads ]]; then
    mkdir -p /config/uploads
fi

if [[ ! -f "/config/env" ]]; then
    cp /app/heimdall/.env.example /config/env
    ln -sf /config/env /app/heimdall/.env

    SECRET_KEY=$(date +%s | sha256sum | base64 | head -c 32)
    sed -i 's|JWT_SECRET=CHANGE_ME|JWT_SECRET='"${SECRET_KEY}"'|g' /config/env
    sed -i 's|DB_TYPE=mysql|DB_TYPE=sqlite|g' /config/env
    sed -i 's|DB_STORAGE=$|DB_STORAGE=/config/app.db|g' /config/env
    sed -i 's|UPLOAD_DIR=$|UPLOAD_DIR=/config/uploads|g' /config/env
    
    npm run db:migrate
    npm run db:seed
fi

exec npm run server ${EXTRA_ARGS}
