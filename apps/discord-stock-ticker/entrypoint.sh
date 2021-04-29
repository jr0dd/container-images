#!/usr/bin/env bash

set -e

source "/shim/umask.sh"

exec /app/ticker ${EXTRA_ARGS}

