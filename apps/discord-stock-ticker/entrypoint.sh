#!/usr/bin/env bash

source "/shim/umask.sh"
source "/shim/vpn.sh"

VERSION="false"

exec /app/ticker -address 0.0.0.0:8080 "$@"
