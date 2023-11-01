#!/bin/bash

HDMI="HDMI-1-0"
eDP="eDP-1"

# Check if monitors are active/connected
HDMIActive=$(xrandr --listmonitors | grep "$HDMI" -q && echo true || echo false)
HDMIConnected=$(xrandr | grep "^$HDMI" | grep disconnected -q && echo false || echo true)
eDPActive=$(xrandr --listmonitors | grep "$eDP" -q && echo true || echo false)

# Enable eDP if it's not already
if ! $eDPActive; then
    if $HDMIActive; then
        xrandr --output "$eDP" --auto --left-of "$HDMI"
    else
        xrandr --output "$eDP" --auto
    fi
    eDPActive=true
fi

# Connect/disconnect HDMI
if $HDMIConnected && $eDPActive && ! $HDMIActive; then
    xrandr --output "$HDMI" --auto --right-of "$eDP"
    xrandr --output "$HDMI" --primary
    openbox --restart # prevent combining 2 monitors
elif $HDMIActive && ! $HDMIConnected; then
    xrandr --output "$HDMI" --off
fi
