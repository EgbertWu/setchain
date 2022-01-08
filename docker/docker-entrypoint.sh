#!/bin/bash
set -eo pipefail
shopt -s nullglob

echo "./set $@" > command.txt
exec "./set" "$@"
