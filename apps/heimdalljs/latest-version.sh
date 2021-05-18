#!/usr/bin/env bash

version=$(curl -sSX GET "https://api.github.com/repos/linuxserver/heimdalljs/commits/master" | awk '/sha/{print $4;exit}' FS='[""]')
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
