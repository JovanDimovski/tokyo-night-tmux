# Check if enabled
ENABLED=$(tmux show-option -gv @tokyo-night-tmux_show_vpn 2>/dev/null)
[[ ${ENABLED} -ne 1 ]] && exit 0

# Imports
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
source "$ROOT_DIR/src/themes.sh"
source "$ROOT_DIR/lib/netspeed.sh"

# Get network interface
INTERFACE=$(tmux show-option -gv @tokyo-night-tmux_vpn_iface 2>/dev/null)

# Determine interface if not set
if [[ -z $INTERFACE ]]; then
  echo -e "$OUTPUT"
  exit 0
fi

NET_ICONS[vpn]="#[fg=${THEME[foreground]}]\U000f0a60"

# Detect interface IPv4 and state
if IPV4_ADDR=$(interface_ipv4 "$INTERFACE"); then
  IFACE_STATUS="up"
  OUTPUT="${RESET}░ ${NET_ICONS[vpn]} $INTERFACE $IFACE_STATUS"
else
  IFACE_STATUS="down"
  OUTPUT=""
fi

# OUTPUT="${RESET}░ ${NET_ICONS[vpn]} $INTERFACE $IFACE_STATUS"

# Print the result
echo -e "$OUTPUT"