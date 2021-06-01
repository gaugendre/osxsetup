brew 'coreutils'
brew 'pkg-config'

# editors
brew 'vim'
cask 'visual-studio-code'
cask 'sublime-text'
cask '0xed'

# services
# tap 'homebrew/services'
brew 'redis', restart_service: true
brew 'postgresql', restart_service: true

# browsers
tap 'homebrew/cask-versions'
cask 'google-chrome-canary'
cask 'firefox-developer-edition'

# platform tools
cask 'docker'
cask 'podman'
brew 'skopeo'

tap 'buildpack/tap'
brew 'pack'

cask 'android-platform-tools'

tap 'heroku/brew'
brew 'heroku'

brew 'awscli'
brew 'aws-elasticbeanstalk', link: false
brew 'ansible'
brew 'ansible-lint'

brew 'pyenv'
brew 'yarn'
brew 'rustup'
brew 'composer'

# devtools
tap 'git-friendly/git-friendly'
brew 'git-friendly'
tap 'jesseduffield/lazygit'
brew 'lazygit'
brew 'hub'

brew 'pgcli'
brew 'imagemagick'
cask 'imageoptim'
cask 'imagealpha'
brew 'tidy-html5'

cask 'postman'
cask 'dbeaver-community'
cask 'mjml'
cask 'wireshark'
cash 'ngrok'

brew 'docker-compose'
brew 'helm'

cask 'vagrant'
cask 'kubernetic'

# mas 'Xcode', id: 497799835
