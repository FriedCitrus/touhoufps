#!/bin/sh
echo -ne '\033c\033]0;TouhouFPS\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/LinMoveTest.x86_64" "$@"
