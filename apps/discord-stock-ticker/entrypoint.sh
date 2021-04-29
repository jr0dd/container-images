#!/usr/bin/env bash

source "/shim/umask.sh"

exec /app/ticker ${EXTRA_ARGS}

