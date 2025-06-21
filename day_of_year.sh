#!/bin/bash

# Get the day of the year (1-366) and the current year
day_of_year=$(date +%j)
year=$(date +%Y)

# Output in JSON format for Waybar
echo " $day_of_year,$year"
