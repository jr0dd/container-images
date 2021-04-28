#!/usr/bin/env bash

set -eu

source "/shim/umask.sh"

exec /app/ticker

sleep 10

exec bash /app/config.sh
