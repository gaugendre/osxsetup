#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SOURCE="."

# REPO=${REPO:-gaugendre/osxsetup}
# BRANCH=${BRANCH:-master}
# SOURCE=${SOURCE:-https://raw.githubusercontent.com/$REPO/$BRANCH}

# https://serverfault.com/questions/144939/multi-select-menu-in-bash-script
CHECKED="✔"

msg=""

options=(
  "APPs"
  "Medias"
  "Games"
  "CLI Tools"
  "Virtualization"
  "Dev Tools"
)

choices=(
  $CHECKED
  ""
  ""
  ""
  ""
  ""
)

menu() {
  echo "Avaliable bundles:"
  for i in ${!options[@]}; do 
    printf "   [%s] %3d) %s\n" "${choices[i]:- }" $((i+1)) "${options[i]}"
  done
  if [[ "$msg" ]]; then echo "$msg"; fi
}

prompt="Check an option (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
  [[ "$num" != *[![:digit:]]* ]] &&
  (( num > 0 && num <= ${#options[@]} )) ||
  { msg="Invalid option: $num"; continue; }
  ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
  [[ "${choices[num]}" ]] && choices[num]="" || choices[num]=$CHECKED
done

printf "You selected"; msg=" nothing"
for i in ${!options[@]}; do
  [[ "${choices[i]}" ]] && { printf " %s" "${options[i]}"; msg=""; }
done
echo "$msg"

msg=""

options2=(
  "Cleanup the Dock"
  "Oh My ZSH!"
  "RVM: Ruby Version Manager"
  "nvm: Node Version Manager"
)

choices2=(
  ""
  ""
  ""
  ""
)

menu2() {
  echo "Avaliable options:"
  for i in ${!options2[@]}; do 
    printf "   [%s] %3d) %s\n" "${choices2[i]:- }" $((i+1)) "${options2[i]}"
  done
  if [[ "$msg" ]]; then echo "$msg"; fi
}

prompt="Check an option (again to uncheck, ENTER when done): "
while menu2 && read -rp "$prompt" num && [[ "$num" ]]; do
  [[ "$num" != *[![:digit:]]* ]] &&
  (( num > 0 && num <= ${#options2[@]} )) ||
  { msg="Invalid option: $num"; continue; }
  ((num--)); msg="${options2[num]} was ${choices2[num]:+un}checked"
  [[ "${choices2[num]}" ]] && choices2[num]="" || choices2[num]=$CHECKED
done

printf "You selected"; msg=" nothing"
for i in ${!options2[@]}; do
  [[ "${choices2[i]}" ]] && { printf " %s" "${options2[i]}"; msg=""; }
done
echo "$msg"

bold=$(tput bold)
normal=$(tput sgr0)

ask_for_sudo() {
  # Ask for the administrator password upfront
  sudo -v

  # Update existing `sudo` time stamp until this script has finished
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &
}

echo "${bold}Enter your sudo password for later use${normal}"
ask_for_sudo

# homebrew
[ -x "$(command -v brew)" ] || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew tap homebrew/bundle

echo "${bold}===> Install bundle $SOURCE/brewfiles/base.rb${normal}"
brew bundle --file $SOURCE/brewfiles/base.rb

for i in ${!options[@]}; do
  BUNDLE=$(echo ${options[i]//[[:blank:]]/} | tr '[:upper:]' '[:lower:]')
  FILE="$SOURCE/brewfiles/$BUNDLE.rb"
  if [[ "${choices[i]}" ]]; then
    echo "${bold}===> Install bundle $FILE${normal}"
    brew bundle --file $FILE
  fi
done


[[ "${choices2[0]}" ]] && bash $SOURCE/cleanup-dock.sh

# oh-my-zsh
[[ "${choices2[1]}" ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

[[ "${choices2[2]}" ]] && bash $SOURCE/install-rvm.sh
[[ "${choices2[3]}" ]] && bash $SOURCE/install-nvm.sh
