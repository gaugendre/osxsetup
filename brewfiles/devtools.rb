brew 'coreutils'

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
brew 'buildpack/tap/pack'
cask 'android-platform-tools'
brew 'heroku/brew/heroku'
brew 'awscli'
brew 'aws-elasticbeanstalk', link: false
brew 'node'
brew 'ruby'
brew 'python'
brew 'yarn'
brew 'rust'
brew 'compozer'
brew 'oracle-jdk'
brew 'ansible'
brew 'ansible-lint'

# devtools
brew 'lazygit'
brew 'hub'
brew 'pgcli'
brew 'jq'
brew 'imagemagick'
brew 'imageoptim'
brew 'poppler'
brew 'tidy-html5'

cask 'kdiff3'
cask 'postman'
cask 'dbeaver-community'
cask 'mjml'
cask 'wireshark'

brew 'docker-compose'
brew 'helm'

cask 'vagrant'
cask 'kubernetic'

# mas 'Xcode', id: 497799835
