#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm install lts/*
