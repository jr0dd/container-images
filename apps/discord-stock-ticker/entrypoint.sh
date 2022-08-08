#!/usr/bin/env bash
set -u

source "/shim/umask.sh"
source "/shim/vpn.sh"

EXTRA_ARGS=${EXTRA_ARGS}

exec /app/ticker -address 0.0.0.0:8080 ${EXTRA_ARGS}
