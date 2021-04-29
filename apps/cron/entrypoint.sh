#!/usr/bin/env bash

source "/shim/umask.sh"

exec sudo /usr/sbin/cron -f ${EXTRA_ARGS}
