# This setup only needs to be ran once.

# Set keys to start repeating after 100ms
defaults write -g InitialKeyRepeat -int 10 

# Makes keys start repeating sooner
defaults write -g KeyRepeat -int 1 

# Allow every key to be repeated
defaults write -g ApplePressAndHoldEnabled -bool false
