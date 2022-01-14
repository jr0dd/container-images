#!/usr/bin/env bash

version=$(curl -sX GET "https://api.github.com/repos/jr0dd/ws-staging-bot/tags" -H "Authorization: token ${TOKEN}" | jq --raw-output '.[0].name')
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
