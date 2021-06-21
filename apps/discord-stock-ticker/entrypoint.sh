#!/usr/bin/env bash

source "/shim/umask.sh"

exec /app/ticker -address 0.0.0.0:8080 ${EXTRA_ARGS}
