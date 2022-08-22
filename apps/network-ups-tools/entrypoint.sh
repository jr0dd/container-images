#!/usr/bin/env bash
set -e

/sbin/upsdrvctl -u root start
exec /sbin/upsd -u root -D
