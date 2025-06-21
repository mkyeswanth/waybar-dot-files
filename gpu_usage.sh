#!/bin/bash

json=$(amdgpu_top -n 1 -J)

# Extract current and max GPU clock
current_clock=$(echo "$json" | jq '.devices[0].gpu_metrics.current_gfxclk')
max_clock=$(echo "$json" | jq '.devices[0].Info["GPU Clock"].max')

# Extract VRAM usage and total
vram_used=$(echo "$json" | jq '.devices[0].VRAM["Total VRAM Usage"].value')
vram_total=$(echo "$json" | jq '.devices[0].VRAM["Total VRAM"].value')

# Calculate percentage (avoid div-by-zero)
if [[ $max_clock -gt 0 ]]; then
    percent=$(( 100 * current_clock / max_clock ))
else
    percent=0
fi

# Format output
text=" ${percent}%"
tooltip="GPU Clock: ${current_clock} MHz / ${max_clock} MHz\nVRAM Usage: ${vram_used} MiB / ${vram_total} MiB"

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
