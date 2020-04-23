#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if [[ ${0##*/} == "bash" ]]; then
  REPO=${REPO:-gaugendre/osxsetup}
  BRANCH=${BRANCH:-master}
  SOURCE=${SOURCE:-https://raw.githubusercontent.com/$REPO/$BRANCH}
else
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  SOURCE=${SOURCE:-$DIR}
fi

# string formatters
if [[ -t 1 ]]; then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_blue="$(tty_mkbold 34)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
  local arg
  printf "%s" "$1"
  shift
  for arg in "$@"; do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}

print_bold() {
  printf "${tty_bold}%s${tty_reset}\n" "$(shell_join "$@")"
}

print_step() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

execute_bash() {
  print_step "Execute $1"

  if [ -t 0 ]; then
    /bin/bash $1
  else
    /bin/bash -c "$(curl -fsSL $1)"
  fi
}

homebrew_bundle() {
  print_step "Install bundle $1"

  if [ -t 0 ]; then
    brew bundle --file $1
  else
    curl -fsSL $1 | brew bundle --file=-
  fi
}

ask_for_sudo() {
  print_bold "You may enter your sudo password for later use"

  # Ask for the administrator password upfronts
  sudo -v

  # Update existing `sudo` time stamp until this script has finished
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &
}

get_homebrew() {
  [ -x "$(command -v brew)" ] ||
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

get_ohmyzsh() {
  [[ -d "$ZSH" ]] ||
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

# https://serverfault.com/questions/144939/multi-select-menu-in-bash-script
str_split() {
  local IFS=$1
  local arr=()
  shift
  for str in "$@"; do
    read -ra arr <<< "$str"
  done
  for i in "${arr[@]}"; do
    echo "$i"
  done
}

ask_for_options() {
  local retval=$1
  shift

  local options_and_choices=($(str_split ";" $@))

  local options=()
  local choices=()
  local selected_options=()
  local msg=""

  for i in ${!options_and_choices[@]}; do
    arr=($(str_split "/" ${options_and_choices[i]}))
    options[$i]=${arr[0]}
    choices[$i]=${arr[1]:-}
  done

  menu() {
    echo "Avaliable options:"
    for i in ${!options[@]}; do 
      if [[ ${choices[i]} ]]; then
        printf "   ${tty_bold}[✔] %3d) %s${tty_reset}\n" $((i+1)) "${options[i]}"
      else
        printf "   [ ] %3d) %s\n" $((i+1)) "${options[i]}"
      fi
    done
    if [[ "$msg" ]]; then echo "$msg"; fi
  }

  local prompt="Check an option (again to uncheck, ENTER when done): "
  while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] &&
      (( num > 0 && num <= ${#options[@]} )) ||
      { msg="Invalid option: $num"; continue; }
    
    ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
    
    [[ "${choices[num]}" ]] &&
      choices[num]="" ||
      choices[num]=true
  done

  printf "You selected"; msg=" nothing"
  for i in ${!options[@]}; do
    [[ "${choices[i]}" ]] && { printf " %s" "${options[i]}"; msg=""; }
  done
  echo "$msg"

  local z=0
  for i in ${!options[@]}; do
    if [[ "${choices[i]}" ]]; then
      selected_options[$i]=${options[i]}
      ((z++))
    fi
  done

  if [ ${#selected_options[@]} != 0 ]; then
    eval $retval='("${selected_options[@]}")'
  fi
}

bundles=()
print_step "Select your homebrew bundles"
ask_for_options bundles "APPs/true;Medias;Games;CLI Tools;Virtualization;Dev Tools"

scripts=()
print_step "Select your scripts"
ask_for_options scripts "Cleanup the Dock;Setup some macOS defaults;Oh My ZSH!;RVM: Ruby Version Manager;nvm: Node Version Manager"

# some fomulas may need sudo password
ask_for_sudo

get_homebrew

# get basic tools to continue
brew tap homebrew/bundle
homebrew_bundle $SOURCE/brewfiles/base.rb

normalize_string() {
  echo ${1//[[:blank:]]/} | tr '[:upper:]' '[:lower:]'
}

if [ ${#bundles[@]} != 0 ]; then
  for bundle in ${bundles[@]}; do
    homebrew_bundle "$SOURCE/brewfiles/$(normalize_string $bundle).rb"
  done
fi

if [ ${#scripts[@]} != 0 ]; then
  for script in ${scripts[@]}; do
    option=$(normalize_string $script)

    [[ $option == cleanup* ]] &&
      execute_bash $SOURCE/cleanup-dock.sh

    [[ $option == setup* ]] &&
      execute_bash $SOURCE/setup-defaults.sh

    [[ $option == ohmyzsh* ]] && get_ohmyzsh

    [[ $option == rvm* ]] &&
      execute_bash $SOURCE/install-rvm.sh

    [[ $option == nvm* ]] &&
      execute_bash $SOURCE/install-nvm.sh
  done
fi
