#!/usr/bin/env bash

set -eu

source "/shim/umask.sh"
source "/shim/vpn.sh"

exec node /app/server.js
