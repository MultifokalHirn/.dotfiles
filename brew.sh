#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

brew install bash &&
    echo $(brew --prefix)/bin/bash | sudo tee -a /etc/shells
# chsh -s $(brew --prefix)/bin/bash
brew install zsh &&
    sudo sh -c 'echo $(brew --prefix)/bin/zsh >> /etc/shells' &&
    chsh -s $(brew --prefix)/bin/zsh

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
# brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# List All Apps Downloaded from App Store
# Via find
find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print | \sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'

brew bundle --file=~/Brewfile-MultifokalHirn
brew tap homebrew/cask-fonts #You only need to do this once for cask-fonts
brew install --cask font-fantasque-sans-mono
brew install --cask --no-quarantine syntax-highlight
brew install --cask iina
brew install betterzip
brew install qlstephen
brew install tag
brew install only-switch

# Sloth is a native Mac app that shows all open files, directories, sockets, pipes, and devices in use by all running processes on your system. This makes it easy to inspect which apps are using which files, etc.
brew install --cask sloth

# borders around active windows
brew tap FelixKratz/formulae
brew install borders

# system onitoring in menu bar
brew install --cask eul

brew install --cask devtoys

# visit the following projects (manual installation)
# https://github.com/zenangst/KeyboardCowboy

# Uninstall Google Update
~/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/ksinstall --nuke

# Exclude Files from time machine backup
# sudo tmutil addexclusion /path/to/file/or/folder

#Recursively Delete .DS_Store Files
find . -type f -name '.DS_Store' -ls -delete

# Compare Two Folders
diff -qr /path/to/folder1 /path/to/folder2

# Rings the terminal bell (if enabled) and puts a badge on it.
# tput bel

# Show Full Path in Finder Title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Show Path Bar  in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Disable Creation of Metadata Files on Network Volumes and USB drives.
# Avoids creation of .DS_Store and AppleDouble files.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable Auto-Correct
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Auto-Play Videos in QuickTime Player
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen 1

# macOS Dock behavior
# Set Auto Show/Hide Delay The float number defines the show/hide delay in ms.
# Hair Trigger Setting
defaults write com.apple.dock autohide-time-modifier -float 0.4 &&
    defaults write com.apple.dock autohide-delay -float 0 &&
    killall Dock
# Restore Default
# defaults delete com.apple.dock autohide-time-modifier &&
#     defaults delete com.apple.dock autohide-delay &&
#     killall Dock

# helpful links
# https://git.herrbischoff.com/awesome-macos-command-line/about/#switch-to-legacy-horizontal-layout
