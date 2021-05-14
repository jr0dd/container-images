#!/usr/bin/env bash

#need to fix
version=$(curl -sX GET "http://mirrors.edge.kernel.org/ubuntu/pool/main/c/cron/" | jq --raw-output '.[0].name')
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"