#!/usr/bin/env bash

set -eux

CF_ZONE_API_TOKEN=$(echo -n "$CF_ZONE_API_TOKEN" | base64 -d)
CF_DNS_API_TOKEN=$(echo -n "$CF_DNS_API_TOKEN" | base64 -d)

CF_API_URL="https://api.cloudflare.com/client/v4/zones"

CF_RECORD=$(curl -s -X GET \
  "$CF_API_URL/$CF_ZONE_API_TOKEN/dns_records?type=A" \
  -H "Authorization: Bearer $CF_DNS_API_TOKEN" \
  -H "Content-Type: application/json")

OLDIP=$(echo "$CF_RECORD" | jq -r '.result[].content')

IP=$(curl -s icanhazip.com)

function change_record() {
    ID=$(echo "$CF_RECORD" | jq -r '.result[].id')
    NAME=$(echo "$CF_RECORD" | jq -r '.result[].name')
    TYPE=$(echo "$CF_RECORD" | jq -r '.result[].type')
    TTL=$(echo "$CF_RECORD" | jq -r '.result[].ttl')
    PROXIED=$(echo "$CF_RECORD" | jq -r '.result[].proxied')
    curl -s -X PUT \
    "$CF_API_URL/$CF_ZONE_API_TOKEN/dns_records/$ID" \
    -H "Authorization: Bearer $CF_DNS_API_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"type\":\"${TYPE}\",\"name\":\"${NAME}\",\"content\":\"${IP}\",\"ttl\":\"${TTL}\",\"proxied\":${PROXIED}}"
}

if [[ "$IP" != "$OLDIP" ]]; then
    change_record
    echo "[INFO] Updating Cloudflare DNS from "$OLDIP" to "$IP""
  else
    echo "[INFO] No DNS update required"
fi