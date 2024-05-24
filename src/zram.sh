# # Check if enabled
ENABLED=$(tmux show-option -gv @tokyo-night-tmux_show_memory 2>/dev/null)
[[ ${ENABLED} -ne 1 ]] && exit 0

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

# Define color codes
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
B='\033[0;34m'
BLACK='\033[0;30m'
DARK_GREY='\033[0;90m'

BB='\033[44m'

NC='\033[0m' # No Color


formatted_output="${RESET}░ ${free_memory_gb}G/${total_memory_gb}G ${DARK_GREY}${size2}/${size1}${NC}"
# Print the result
echo -e $formatted_output