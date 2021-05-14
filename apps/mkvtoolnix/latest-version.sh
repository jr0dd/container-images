#!/usr/bin/env bash

version=$(curl -sX GET "https://gitlab.com/api/v4/projects/mbunkus/mkvtoolnix/tags" | jq --raw-output '.[0].name')
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"