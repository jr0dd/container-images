#!/usr/bin/env bash

set -eu

source "/shim/umask.sh"

SOPS_AGE_KEY=${SOPS_AGE_KEY}
NODE_ENV=${NODE_ENV}

cd /app
for i in config/*.yaml; do
    sops -d -i "$i"
    mv "$i" "${i/.sops.yaml/.yaml}"
done

exec node --loader esm-module-alias/loader --no-warnings ./index.js "$@"
