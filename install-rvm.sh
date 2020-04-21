#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
. ~/.rvm/scripts/rvm
rvm rvmrc warning ignore allGemfiles
