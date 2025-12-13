#!/usr/bin/env bash

LOCK_IMAGE="$HOME/.config/niri/lock.png"
LOCK_CMD="pgrep -x swaylock || swaylock -i $LOCK_IMAGE"

exec swayidle -w \
    timeout 340 'brightnessctl -s set 10%' \
    resume 'brightnessctl -r' \
    timeout 350 "$LOCK_CMD" \
    timeout 500 'systemctl suspend' \
    before-sleep 'playerctl pause -a' \
    before-sleep "$LOCK_CMD"
