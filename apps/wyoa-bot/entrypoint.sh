#!/usr/bin/env bash

set -eu

source "/shim/umask.sh"
source "/shim/vpn.sh"

SOPS_AGE_KEY=${SOPS_AGE_KEY}
NODE_ENV=${NODE_ENV}

cd /app/config
rm *local*
for i in *.yaml; do
    sops -d -i $i
    mv $i ${i/.sops.yaml/.yaml}
done

exec node /app/index.js
