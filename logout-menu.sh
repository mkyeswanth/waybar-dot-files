#!/usr/bin/env bash

config="$HOME/.config/rofi/logout-menu.rasi"

actions=$(echo -e "   Lock\n   Shutdown\n   Reboot\n $(printf '\u200A')  Suspend\n   Hibernate\n   Logout")

# Display logout menu
selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}")

# Perform actions based on the selected option
case "$selected_option" in
*Lock)
  swaylock -f --image /home/xyris-brain/Pictures/wp.jpg --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --ring-color 88c0d0 --key-hl-color bf616a --line-color 00000000 --separator-color 00000000 --inside-color 00000088 --ring-ver-color a3be8c --ring-wrong-color bf616a
  ;;
*Shutdown)
  systemctl poweroff
  ;;
*Reboot)
  systemctl reboot
  ;;
*Suspend)
  systemctl suspend
  ;;
*Hibernate)
  systemctl hibernate
  ;;
*Logout)
  hyprctl dispatch exit 0
  ;;
esac
