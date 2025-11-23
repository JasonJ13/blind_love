#!/bin/sh
printf '\033c\033]0;%s\a' Blind_love
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Blind_love.x86_64" "$@"
