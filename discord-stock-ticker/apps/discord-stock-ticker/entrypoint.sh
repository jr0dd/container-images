#!/usr/bin/env bash

set -eux

source "/shim/umask.sh"
source "/shim/vpn.sh"

exec /bin/ticker

sleep infinity &
wait $!
