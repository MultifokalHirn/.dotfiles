#!/usr/bin/env sh

# MAC SETTINGS

# references
# - https://git.herrbischoff.com/awesome-macos-command-line/about/#switch-to-legacy-horizontal-layout
# - https://github.com/stefanjudis/dotfiles/blob/01216e98ad4ccf83ea276edbc67c789cbcb9f2bc/scripts/mac.sh

# echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# echo "show hidden files by default"
defaults write com.apple.Finder AppleShowAllFiles -bool true

# echo "only use UTF-8 in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4

# echo "show the ~/Library folder in Finder"
chflags nohidden ~/Library

# echo "Show Full Path in Finder Title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# echo "Show Path Bar  in Finder"
defaults write com.apple.finder ShowPathbar -bool true

# echo "Disable Creation of Metadata Files on Network Volumes and USB drives."
# echo "Avoids creation of .DS_Store and AppleDouble files."
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# echo "Disable Auto-Correct"
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# echo "Auto-Play Videos in QuickTime Player"
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen 1

# echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# echo "Use current directory as default search scope in Finder"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# echo "Disable the “Are you sure you want to open this application?” dialog"
# defaults write com.apple.LaunchServices LSQuarantine -bool false

# echo "Hide 'recent applications' from dock"
defaults write com.apple.dock show-recents -bool false

# echo "Only show active apps in dock"
defaults write com.apple.dock static-only -bool true
killall Dock

# echo "Enable automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

# echo "Speed up dock show/hide"
defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.4
killall Dock

# Run the following to restore Defaults:
# defaults delete com.apple.dock autohide-time-modifier
# defaults delete com.apple.dock autohide-delay
# killall Dock
