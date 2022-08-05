#!/usr/bin/env bash

set -eu

source "/shim/umask.sh"
source "/shim/vpn.sh"

SOPS_AGE_KEY=${SOPS_AGE_KEY}
NODE_ENV=${NODE_ENV}

rm /app/config/*local*
npm run decrypt

exec npm run start
