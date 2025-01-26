#!/usr/bin/env bash

if hyprctl activeworkspace | awk '/windows:/ {print $2}' | grep -q "^1$"; then
  echo '{"text": "", "tooltip": "Windows are present", "class": "opaque"}'
else
  echo '{"text": "", "tooltip": "No windows", "class": "transparent"}'
fi

