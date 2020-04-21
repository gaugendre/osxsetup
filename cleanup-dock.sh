#!/bin/bash
set -euo pipefail
IFS=$'\r\n'

apps=($(dockutil --list | grep -Ev 'Launchpad|Downloads' | awk -F '\t' '{ print $1 }'))

for i in ${!apps[@]}; do
  app=${apps[$i]}
  echo "Removing $app from dock"
  if [[ ${#apps[@]} != $((i+1)) ]]; then
    dockutil --remove $app --no-restart
  else
    dockutil --remove $app
  fi
done
