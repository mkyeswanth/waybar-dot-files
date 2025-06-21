#!/bin/bash

# Interface to monitor
INTERFACE="eno1"

# Get initial byte counts
RX1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

# Wait for 1 second
sleep 1

# Get new byte counts
RX2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

# Calculate speeds in bytes per second
RX_BYTES=$((RX2 - RX1))
TX_BYTES=$((TX2 - TX1))

# Convert to KB/s (bytes / 1024)
RX_KB=$((RX_BYTES / 1024))
TX_KB=$((TX_BYTES / 1024))

# Convert to MB/s with 2 decimal places using bc
RX_MB=$(bc <<< "scale=2; $RX_BYTES / 1048576")
TX_MB=$(bc <<< "scale=2; $TX_BYTES / 1048576")

# Determine units based on speed (threshold: 1 MB/s = 1024 KB/s)
if [ $RX_KB -ge 1024 ]; then
  RX_TEXT="${RX_MB}M"
  RX_TOOLTIP="${RX_MB} MB/s"
else
  RX_TEXT="${RX_KB}K"
  RX_TOOLTIP="${RX_KB} KB/s"
fi

if [ $TX_KB -ge 1024 ]; then
  TX_TEXT="${TX_MB}M"
  TX_TOOLTIP="${TX_MB} MB/s"
else
  TX_TEXT="${TX_KB}K"
  TX_TOOLTIP="${TX_KB} KB/s"
fi

# Format output as JSON for Waybar
echo "{\"text\": \" ${RX_TEXT}  ${TX_TEXT}\", \"tooltip\": \"Download: ${RX_TOOLTIP}\\nUpload: ${TX_TOOLTIP}\"}"
