#!/usr/bin/env bash
set -eu

source "/shim/umask.sh"
source "/shim/vpn.sh"

NODE_ENV=production

exec node /app/server.js
