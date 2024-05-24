# # Check if enabled
ENABLED=$(tmux show-option -gv @tokyo-night-tmux_show_memory 2>/dev/null)
[[ ${ENABLED} -ne 1 ]] && exit 0

# Imports
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
source "$ROOT_DIR/src/themes.sh"

# Input string
INPUT=$(zramctl -n)

# Use awk to extract the specific columns and sed to replace commas with dots
size1=$(echo $INPUT | awk '{print $3}' | sed 's/,/./')
size2=$(echo $INPUT | awk '{print $4}' | sed 's/,/./')
size3=$(echo $INPUT | awk '{print $5}' | sed 's/,/./')

# Extract the memory usage line
memory_line=$(free -btw | grep Mem:)

# Extract the used and total memory values in bytes
avail_memory_bytes=$(echo $memory_line | awk '{print $8}')
total_memory_bytes=$(echo $memory_line | awk '{print $2}')

# Convert bytes to gigabytes with decimal precision
avail_memory_gb=$(echo "scale=1; $avail_memory_bytes / 1024 / 1024 / 1024" | bc)
total_memory_gb=$(echo "scale=1; $total_memory_bytes / 1024 / 1024 / 1024" | bc)

free_memory_gb=$(echo "$total_memory_gb - $avail_memory_gb" | bc)

# Format the output
# formatted_output="RAM:${free_memory_gb}G/${total_memory_gb}G Z:${size3}(${size2})/${size1}"

formatted_output="${RESET}░ ${free_memory_gb}G/${total_memory_gb}G #[fg=${THEME[white]}]${size2}/${size1}"
# Print the result
echo -e "$formatted_output"