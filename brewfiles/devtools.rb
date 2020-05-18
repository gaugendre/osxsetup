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

tap 'buildpack/tap'
brew 'pack'

cask 'android-platform-tools'

tap 'heroku/brew'
brew 'heroku'

brew 'awscli'
brew 'aws-elasticbeanstalk', link: false
brew 'node'
brew 'ruby'
brew 'python'
brew 'yarn'
brew 'rust'
brew 'composer'
cask 'oracle-jdk'
brew 'ansible'
brew 'ansible-lint'

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

brew 'docker-compose'
brew 'helm'

cask 'vagrant'
cask 'kubernetic'

# mas 'Xcode', id: 497799835
