#!/usr/bin/env bash
#<------------------------------Netspeed widget for TMUX------------------------------------>
# author : @tribhuwan-kumar
# email : freakybytes@duck.com
#<------------------------------------------------------------------------------------------>

# Check if enabled
SECTION=$(tmux show-option -gv @tokyo-night-tmux_right_append_section 2>/dev/null)

# Imports
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
source "$ROOT_DIR/src/themes.sh"

# Determine section if not set
if [[ -z $SECTION ]]; then
  OUTPUT=""
else
  OUTPUT="${RESET}░ ${SECTION} "
fi

echo -e "$OUTPUT"
