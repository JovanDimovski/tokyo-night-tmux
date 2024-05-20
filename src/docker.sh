#!/usr/bin/env bash
#<------------------------------Netspeed widget for TMUX------------------------------------>
# author : @tribhuwan-kumar
# email : freakybytes@duck.com
#<------------------------------------------------------------------------------------------>

# Check if enabled
ENABLED=$(tmux show-option -gv @tokyo-night-tmux_show_docker 2>/dev/null)
[[ ${ENABLED} -ne 1 ]] && exit 0

# Imports
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
source "$ROOT_DIR/src/themes.sh"

# Icons
declare -A NET_ICONS
DOCKER_ICONS[box]="#[fg=${THEME[blue]}]"

OUTPUT="${RESET}░ ${DOCKER_ICONS[box]}#{docker_status} "

echo -e "$OUTPUT"
