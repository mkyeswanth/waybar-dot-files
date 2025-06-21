#!/bin/bash

DEVICE="nvme0n1"  # Use sda for HDD/SSD or nvme0n1 for NVMe
INTERVAL=1

read_io() {
  cat /sys/block/"$DEVICE"/stat | awk '{read=$3; write=$7; print read, write}'
}

# Initial values
read1=0
write1=0
IFS=' ' read -r read1 write1 < <(read_io)
sleep $INTERVAL
IFS=' ' read -r read2 write2 < <(read_io)

# Calculate sectors/sec
read_diff=$((read2 - read1))
write_diff=$((write2 - write1))

# Convert to MB/s (512 bytes per sector)
read_mb=$(awk "BEGIN { printf \"%.1f\", $read_diff * 512 / 1024 / 1024 }")
write_mb=$(awk "BEGIN { printf \"%.1f\", $write_diff * 512 / 1024 / 1024 }")

echo "{\"text\":\" ${read_mb}M  ${write_mb}M\", \"tooltip\":\"Read: ${read_mb} MB/s | Write: ${write_mb} MB/s\"}"
