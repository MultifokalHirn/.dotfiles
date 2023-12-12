# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#                                 ZSH CONFIG                                  #
#-----------------------------------------------------------------------------#
# Author: @MultifokalHirn

###################################################################
#----------------------- OH MY ZSH CONFIG ------------------------#
###################################################################

export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.
# ZSH_THEME="spaceship"
ZSH_THEME="powerlevel10k/powerlevel10k"

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

plugins=(git fzf-tab fzf-tab-source zsh-completions fast-syntax-highlighting zsh-autosuggestions macos history  pre-commit python github zsh-nvm ohmyzsh-full-autoupdate pyenv-lazy zinsults)

# Disabled plugins:
# tmux pyenv docker-compose zsh-navigation-tools zsh-interactive-cd docker zsh-syntax-highlighting ssh-agent

source $ZSH/oh-my-zsh.sh

###################################################################
#-------------------------- USER CONFIG --------------------------#
###################################################################
## PATH
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

## ZSH

setopt no_beep
setopt complete_in_word
source /usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

### fzf-tab
FZF_TAB_GROUP_COLORS=(
  $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[38;5;27m' $'\033[36m'
  $'\033[38;5;100m' $'\033[38;5;98m' $'\033[91m' $'\033[38;5;80m' $'\033[92m'
  $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)
zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# show options in as popup - tmux must be installed
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
# systemd - not relevant for mac
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
# previews
preview() {
  if file --mime-type {} | grep -qF image/; then
    kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {} | sed \$d
  else
    less ${(Q)realpath}
    # bat --color=always {}
fi
}
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
# zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview'

# zstyle ':fzf-tab:complete:*:*' fzf-preview \
# 'if file --mime-type {} | grep -qF image/; then
#     kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {} | sed \$d
#   else
#     less ${(Q)realpath}
#     # bat --color=always {}
# fi'
export LESSOPEN='|~/.lessfilter %s'
export LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
# preview env vars
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
  fzf-preview 'echo ${(P)word}'
# preview git
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
  'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
  'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
  'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
  'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'
# preview brew
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
# zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ":fzf-tab:*" fzf-flags --color=bg+:23
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle ':completion:files' sort false
# zstyle ':completion:*:complete:*' use-cache true
zstyle ':completion:*' menu yes select # search
zstyle ':completion:*' list-grouped false
zstyle ':completion:*' list-separator ''
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' verbose yes
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

source ~/auto-sized-fzf.sh


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
### python-better-expections
export FORCE_COLOR=1
export BETTER_EXCEPTIONS=1

### pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

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
# FZF_DEFAULT_OPTS="--border --no-height $(fzf_sizer_preview_window_settings)"
# resize window and fzf preview sizing/location will resize with you
precmd() {
  FZF_DEFAULT_OPTS="--border --no-height $(fzf_sizer_preview_window_settings)"
}

#                             ALIASES                             #
#-----------------------------------------------------------------#

alias p="change-project" # defined in custom functions

alias cat="bat -P --style 'plain,changes' --color=always"
alias cdd="br -s"
alias dfh='df -x"squashfs" -x"overlay" -h'
alias du="dust"
alias htop='btm'
alias la="exa -la --icons"
alias lzd='lazydocker'
alias update="brew update; brew upgrade" # update brew apps/libs
alias rm='safe-rm'                       # https://github.com/kaelzhang/shell-safe-rm

# TODO: consider using this instead:
# Remove all items safely, to Trash (`brew install trash`).
# [[ -z "$commands[trash]" ]] || alias rm='trash' 2>&1 > /dev/null

alias stats='sort | uniq -c | sort -r'
# Lists the ten most used commands.
alias history-stats="history 0 | awk '{print \$2}' | stats | head"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
