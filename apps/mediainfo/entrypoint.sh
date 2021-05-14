#!/usr/bin/env bash

source "/shim/umask.sh"

echo "[INFO] Starting MediaInfo..."

if [[ ! -f /config/QtProject.conf ]]; then
    mv -v /app/QtProject.conf /config/.
fi

exec /app/bin/mediainfo-gui -platform vnc:mode=websocket:size=1920x1080:maximize=true ${EXTRA_ARGS}