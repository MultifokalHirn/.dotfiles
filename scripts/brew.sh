#!/usr/bin/env bash

function brew_install_or_upgrade {
    # this function was copied from Stefan Judis' dotfiles
    #   Source: https://github.com/stefanjudis/dotfiles/blob/01216e98ad4ccf83ea276edbc67c789cbcb9f2bc/commands/__util.sh#L35C1-L41C2
    if brew ls --versions "$1" >/dev/null; then
        HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1"
    else
        HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
    fi
}

# Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

brew update

brew_install_or_upgrade bash
echo $BREW_PREFIX/bin/bash | sudo tee -a /etc/shells

brew_install_or_upgrade zsh
brew_install_or_upgrade zsh-completions
sudo sh -c 'echo $BREW_PREFIX/bin/zsh >> /etc/shells'
chsh -s $BREW_PREFIX/bin/zsh

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
# brew install coreutils
# ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

brew bundle --file=~/Brewfile-MultifokalHirn

brew_install_or_upgrade betterzip   # QuickLook plugin for .zip files
brew_install_or_upgrade qlstephen   # QuickLook plugin for plain text files etc
brew_install_or_upgrade tag         # file tagging in terminal
brew_install_or_upgrade only-switch # quick settings in menubar
brew_install_or_upgrade mcfly       # alternative ctrl-r
brew_install_or_upgrade grex        # generate regex from examples
brew_install_or_upgrade shellcheck  # shell script linter

# borders around active windows
brew tap FelixKratz/formulae
brew_install_or_upgrade borders

# visit the following projects (manual installation)
# https://github.com/zenangst/KeyboardCowboy

brew tap homebrew/cask-fonts # You only need to do this once for cask-fonts
brew install --cask font-fantasque-sans-mono
brew install --cask --no-quarantine syntax-highlight # syntax highlighting for QuickLook
brew install --cask iina                             # video player
brew install --cask sloth                            # shows all open files, directories, sockets, pipes, and devices
brew install --cask eul                              # system monitoring in menu bar
brew install --cask devtoys                          # mac port of microsoft devtoys
