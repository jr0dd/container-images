#!/usr/bin/env bash

version=$(curl -s "https://registry.hub.docker.com/v2/repositories/library/ubuntu/tags?ordering=name&name=focal" | jq --raw-output --arg s "focal" '.results[] | select(.name | contains($s)) | .name'  | head -n1)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
