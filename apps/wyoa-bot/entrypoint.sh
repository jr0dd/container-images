#!/usr/bin/env bash

set -eu

source "/shim/umask.sh"

SOPS_AGE_KEY=${SOPS_AGE_KEY}
NODE_ENV=${NODE_ENV}

exec npm run docker
