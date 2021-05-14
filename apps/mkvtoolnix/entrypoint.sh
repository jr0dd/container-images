#!/usr/bin/env bash

source "/shim/umask.sh"

if [[ ! -d /config/bunkus.org/mkvtoolnix-gui ]]; then
    mkdir -p /config/bunkus.org/mkvtoolnix-gui
    mv -v /app/mkvtoolnix-gui.ini /config/bunkus.org/mkvtoolnix-gui/.
fi

if [[ ! -f /config/bunkus.org/mkvtoolnix-gui/mkvtoolnix-gui.ini ]]; then
    mv -v /app/mkvtoolnix-gui.ini /config/bunkus.org/mkvtoolnix-gui/.
fi

if [[ ! -f /config/QtProject.conf ]]; then
    mv -v /app/QtProject.conf /config/.
fi

echo "[INFO] Starting MKVToolNix..."
exec /app/bin/mkvtoolnix-gui -platform vnc:mode=websocket:size=1920x1080:maximize=true ${EXTRA_ARGS}