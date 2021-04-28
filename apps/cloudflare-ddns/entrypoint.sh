#!/usr/bin/env bash

set -eu

source "/shim/umask.sh"

TMPFILE=$(mktemp)

echo "CF_ZONE_API_TOKEN=$CF_ZONE_API_TOKEN" > $TMPFILE
echo "CF_DNS_API_TOKEN=$CF_DNS_API_TOKEN" >> $TMPFILE

set +u

if [[ -z $CRON ]]; then
    echo "[WARNING] no variable set for CRON"
    echo "[WARNING] using default time of 15 min"
    echo "*/15 * * * * /app/cloudflare-ddns.sh >> /proc/1/fd/1 2>&1" >> $TMPFILE
  else
    echo "$CRON /app/cloudflare-ddns.sh >> /proc/1/fd/1 2>&1" >> $TMPFILE
    echo "[INFO] CRON variable found"
fi

crontab $TMPFILE && rm $TMPFILE
echo "[INFO] crontab entry:"
crontab -l | grep ddns

echo "[INFO] Starting cron..."
exec sudo /usr/sbin/cron -f

sleep infinity &
wait $!
