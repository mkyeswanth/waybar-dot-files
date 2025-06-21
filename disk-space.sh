#!/bin/bash

# Mount point to monitor
MOUNT="/"
FREE=$(df -h "$MOUNT" | awk 'NR==2 {print $4}')

# Get info for sda1 and sda2
SDA1=$(df -h | grep '/dev/sda1' | awk '{print $4 " free on sda16k"}')
SDA2=$(df -h | grep '/dev/sda2' | awk '{print $4 " free on XNotts"}')

TOOLTIP="Root ($MOUNT): $FREE\n$SDA1\n$SDA2"

# JSON output
echo "{\"text\": \"$FREE\", \"tooltip\": \"$TOOLTIP\"}"
