#!/usr/bin/env bash

source "/shim/umask.sh"
source "/shim/vpn.sh"

tmpfile=$(mktemp)

if [[ -z $CF_ZONE_API_TOKEN ]]; then
    echo "[ERROR] no variable set for CF_ZONE_API_TOKEN"
    exit 1
  else
    echo "CF_ZONE_API_TOKEN=$CF_ZONE_API_TOKEN" > $tmpfile
fi

if [[ -z $CF_DNS_API_TOKEN ]]; then
    echo "[ERROR] no variable set for CF_DNS_API_TOKEN"
    exit 1
  else
    echo "CF_DNS_API_TOKEN=$CF_DNS_API_TOKEN" >> $tmpfile
fi

if [[ -z $CRON ]]; then
    echo "[WARNING] no variable set for CRON"
    echo "[WARNING] using default time of 15 min"
    echo "*/15 * * * *   /app/cloudflare-ddns.sh > /dev/pts/0 2>&1" >> $tmpfile
  else
    echo "$CRON   /app/cloudflare-ddns.sh > /dev/pts/0 2>&1" >> $tmpfile
    echo "[INFO] CRON variable found"
fi

crontab $tmpfile && rm $tmpfile
echo "[INFO] crontab entry:"
crontab -l | grep ddns

echo "[INFO] Starting cron..."
exec sudo /usr/sbin/cron -f -L 15

sleep infinity &
wait $!
