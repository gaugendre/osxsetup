#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

dockutil --remove 'Siri' --no-restart
dockutil --remove 'Safari' --no-restart
dockutil --remove 'Mail' --no-restart
dockutil --remove 'Contacts' --no-restart
dockutil --remove 'Calendar' --no-restart
dockutil --remove 'Notes' --no-restart
dockutil --remove 'Reminders' --no-restart
dockutil --remove 'Maps' --no-restart
dockutil --remove 'Photos' --no-restart
dockutil --remove 'Messages' --no-restart
dockutil --remove 'FaceTime' --no-restart
dockutil --remove 'App Store' --no-restart
dockutil --remove 'System Preferences'
