#                                 ZSH CONFIG                                  #
#-----------------------------------------------------------------------------#
# Author: @MultifokalHirn

###################################################################
#----------------------- OH MY ZSH CONFIG ------------------------#
###################################################################

export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.
ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto # update automatically without asking
# zstyle ':omz:update' mode reminder  # remind to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

#-----------------------------------------------------------------#
#                             PLUGINS                             #
#-----------------------------------------------------------------#

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/

# fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

plugins=(git zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-interactive-cd zsh-navigation-tools macos ssh-agent history docker docker-compose 1password pre-commit python github zsh-nvm ohmyzsh-full-autoupdate)

# Disabled plugins:
# tmux pyenv

source $ZSH/oh-my-zsh.sh

###################################################################
#-------------------------- USER CONFIG --------------------------#
###################################################################

## ENV VARS

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SPACESHIP_CONFIG="$HOME/.spaceshiprc.zsh"
export HOMEBREW_NO_ANALYTICS=1
# export HOMEBREW_NO_ENV_HINTS=1

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='code' # VS Code
fi

## (stolen from @garybernhardt)
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd" # colorization in ls
export GREP_OPTIONS="--color"            # colorization in grep results
#   By default, zsh considers many characters part of a word (e.g., _ and -).
#   Narrow that down to allow easier skipping through words (!)
export WORDCHARS='*?[]~&;!$%^<>'

#                 LANGUAGE SPECIFIC CONFIGURATION                 #
#-----------------------------------------------------------------#

## PYTHON
export BETTER_EXCEPTIONS=1

### pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

### tk-inter
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"
export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig"

## NODE
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

## RUST
export PATH="$HOME/.cargo/bin:$PATH"
export RUSTC_WRAPPER=sccache

## RUBY
if [ -d "/usr/local/opt/ruby/bin" ]; then
  export PATH=/usr/local/opt/ruby/bin:$PATH
  export PATH=$(gem environment gemdir)/bin:$PATH
fi

#                   APP SPECIFIC CONFIGURATION                   -#
#-----------------------------------------------------------------#

## GOOGLE CLOUD

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

alias kubectl="/usr/local/bin/kubectl"

## MISC

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source $HOME/.config/broot/launcher/bash/br

#                       CUSTOM FUNCTIONS                          #
#-----------------------------------------------------------------#

change-project() {
  # Used via: alias p="change-project"
  cd $(find ~/Documents/GitHub -maxdepth 1 -type d | selecta) && clear
}

show-file() {
  cat $(ls | selecta)
}

auto-retry() {
  false
  while [ $? -ne 0 ]; do
    "$@" || (
      sleep 1
      false
    )
  done
}

#                             ALIASES                             #
#-----------------------------------------------------------------#

alias p="change-project" # defined in custom functions

alias cat="bat -P --style 'plain,changes'"
alias cdd="br -s"
alias dfh='df -x"squashfs" -x"overlay" -h'
alias du="dust"
alias htop='btm'
alias la="exa -la --icons"
alias lzd='lazydocker'
alias update="brew update; brew upgrade" # update brew apps/libs

# Colorize terminal

# alias ls='ls -G'
# alias ll='ls -lG'

###################################################################
#-------------------CONFIDENTIAL CONFIGURATIONS-------------------#
###################################################################

source $HOME/.zshrc-confidentials

###################################################################
#-----------------------------ARCHIVE-----------------------------#
###################################################################

# alias la="ls -lah"
# export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
# export PYTHONHOME=$PYENV_ROOT/versions/"$(python -V | cut -d' ' -f 2)"
