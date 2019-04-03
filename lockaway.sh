#!/usr/bin/env bash

available="setstatus?status=available"
offline="setstatus?status=offline"

dbus-monitor --session "type='signal',interface='com.ubuntu.Upstart0_6'" | \
(
  while true; do
    read -r X
    if echo "$X" | grep "desktop-lock" &> /dev/null; then
      purple-remote "$offline"
    elif echo "$X" | grep "desktop-unlock" &> /dev/null; then
      echo "unlock"
      purple-remote "$available"
    fi
  done
)
