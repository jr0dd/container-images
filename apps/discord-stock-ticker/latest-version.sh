#!/usr/bin/env bash

version=$(curl -sX GET "https://api.github.com/repos/rssnyder/discord-stock-ticker/releases/latest" | jq --raw-output '.tag_name' 2>/dev/null)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
