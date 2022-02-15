#!/usr/bin/env bash

source "/shim/umask.sh"
source "/shim/vpn.sh"

exec node /app/server.js
