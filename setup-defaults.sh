# security: disable Gatekeeper
sudo spctl --global-disable

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# https://apple.stackexchange.com/questions/167245/yosemite-bluetooth-audio-is-choppy-skips
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80 
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 80 
# defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80 
# defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" 80 
# defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80 
# defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80 
# defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80
# sudo killall coreaudiod

###############################################################################
# Screen                                                                      #
###############################################################################


# Save screenshots to the desktop
# defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# defaults write com.apple.screencapture type -string "png"

# Hide all desktop icons because who need 'em'
defaults write com.apple.finder CreateDesktop -bool false

# Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool false

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" "Dock" "Finder" "SystemUIServer"; do
  killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
