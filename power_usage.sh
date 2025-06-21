#!/bin/bash

# Replace this with your actual data reading command
# Example for serial device: cat /dev/ttyUSB0 | head -n1

DATA="N/A"

# Suppose you get power info in the format: "Power: 123 W"
# power=$(echo "$DATA" | grep -oE '[0-9]+')

power="N/A" # default if unknown

echo "{\"text\":\"⚡ ${power}W\", \"tooltip\":\"Power Usage: ${power} Watts\"}"
