
#                                                                             #
# .ZSHRC                                                                      #
# ------------                                                                #
# Author: @MultifokalHirn                                                     #
# Repository: https://github.com/MultifokalHirn/.dotfiles                     #
#                                                                             #

# Performance optimizations
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
export HOMEBREW_PREFIX="$(brew --prefix)"
# Init completions with cache (faster startup)
autoload -Uz compinit
compinit -C

# ANSI Colors for reference
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

LIGHTGRAY='\033[0;37m'
GRAY='\033[1;30m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# printf "\n${GRAY}---${NC}\n"
# printf "\n${BLUE}ToDo${NC}\n"
# cat ~/todo.txt
# printf "\n${GRAY}---${NC}\n"
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

# if [[ -f "~/rainbow.sh" ]]; then
#   echo "wsrtr"
#   alias say="touch /tmp/say; echo $@ >> /tmp/say && ~/rainbow.sh -f /tmp/say; rm /tmp/say;"
# else
#   alias say="cowsay"
# fi
# alias say="touch /tmp/say && echo '$@' >> /tmp/say && bash ~/rainbow.sh /tmp/say; rm /tmp/say "

# Enable Powerlevel10k instant prompt.                                        #
#-----------------------------------------------------------------------------#
# ATTENTION: This should stay close to the top of $HOME/.zshrc.               #
# Initialization code that may require console input (password prompts, [y/n] #
# confirmations, etc) must go above this block; everything else may go below  #
INSTANT_P="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
if [[ -r $INSTANT_P ]]; then 
  source $INSTANT_P; 
fi
rainbow() {
  touch /tmp/say && echo $@ >> /tmp/say && ~/rainbow.sh '/tmp/say' 
}
alias say="rainbow"
# command -v "fortune" &> /dev/null  && command -v "say" &> /dev/null && fortune | say
#                                                                             #
# Oh-My-Zsh                                                                   #
#-----------------------------------------------------------------------------#
# eval "$(/opt/homebrew/bin/brew shellenv)"
zstyle ':omz:update' frequency 7  # check for oh-my-zsh updates every 7 days
zstyle ':omz:update' mode auto  # install updates automatically without asking
HIST_STAMPS="dd.mm.yyyy"
export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.

### THEME                                   
# Standard themes can be found in $ZSH/themes/
# Custom themes may be added to $ZSH_CUSTOM/themes/

ZSH_THEME="powerlevel10k/powerlevel10k"

### MISC CONFIGS

# Commands starting from " " (whitespace) won't be saved in history:
HIST_IGNORE_SPACE="true"
# Uncomment this if you want to use spaceship-prompt
# export SPACESHIP_CONFIG="$HOME/.spaceshiprc.zsh" 

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

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


### PLUGINS                                   
# Standard plugins can be found in $ZSH/plugins/                             
# Custom plugins may be added to $ZSH_CUSTOM/plugins/                        
#                                                                             
# ATTENTION: plugins are loaded in the order they are listed here. Be careful 
# when changing the order of plugins, as they may depend on each other (e.g.  
# the completion system).                                                     
autoload -Uz compinit && compinit # initialize zsh completion system

# TODO: try out antidote
# source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
# source ~/.zsh_plugins.zsh
# plugins
source $HOMEBREW_PREFIX/Cellar/zsh-fast-syntax-highlighting/1.55/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh

plugins=(
  git
  fzf-tab
  fzf-tab-source
  # fast-syntax-highlighting
  # zsh-autosuggestions
  macos
  history
  # pre-commit
  python
  # zsh-nvm
  ohmyzsh-full-autoupdate
  # zsh-history-substring-search
  # pyenv-lazy
  zinsults
  zsh-completions
  # docker
  # docker-compose
  # github
  # pyenv
  # ssh-agent
  # tmux
  # wakatime
  # zsh-interactive-cd
  # zsh-navigation-tools
)

# export DISABLE_AUTO_TITLE="true" # for https://github.com/olets/zsh-window-title#oh-my-zsh-users

#..............................................................................

source $ZSH/oh-my-zsh.sh # initialize oh-my-zsh



###############################################################################
# USER CONFIG ----------------------------------------------------------------#
###############################################################################


has_cmd() {
  # Helper function to check if a command exists. 
  # Example usage: `has_cmd some_command && echo yay || echo no`
	for cmd in "$@"; do
		command -v "$cmd" >/dev/null || printf "Command ${RED}$cmd${NC} is not installed.\n"
	done
}

# ENV VARS                                                                    #
#.............................................................................#

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export HOMEBREW_NO_ANALYTICS=1

# export HOMEBREW_NO_ENV_HINTS=1 

## preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  has_cmd code && export EDITOR='code' || export EDITOR='open'
fi

## 'stolen' from @garybernhardt
### ...........................................................................
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd" # colorization in ls
export WORDCHARS='*?[]$HOME&;!$%^<>'
# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words (!)


# ZSH                                                                         #
#.............................................................................#
setopt autocd nomatch
setopt no_beep
setopt complete_in_word 
# Share history across all terminal sessions
setopt SHARE_HISTORY

# Append to history file, don't overwrite
setopt APPEND_HISTORY

# Better history searching with arrow keys
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward


## PATH
export PATH="$PATH:~/.local/bin"

### GNU coreutils
GNU_BIN="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
GNU_GREP="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"
GNU_AWK="$HOMEBREW_PREFIX/opt/gawk/libexec/gnubin"
GNU_FILE="$HOMEBREW_PREFIX/opt/file-formula/bin"
GNU_FIND="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"

if [ -d "$GNU_BIN" ]; then export PATH="$GNU_BIN:$PATH"; fi
if [ -d "$GNU_GREP" ]; then export PATH="$GNU_GREP:$PATH"; fi
if [ -d "$GNU_AWK" ]; then export PATH="$GNU_AWK:$PATH"; fi
if [ -d "$GNU_FILE" ]; then export PATH="$GNU_FILE:$PATH"; fi
if [ -d "$GNU_FIND" ]; then export PATH="$GNU_FIND:$PATH"; fi

# Standard Applications                                                       #
#.............................................................................#

## TMUX
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

## LESS
export LESSOPEN="|$HOMEBREW_PREFIX/bin/lesspipe.sh %s"
# export LESSOPEN='|$HOME/.lessfilter %s'
export LESS="--RAW-CONTROL-CHARS --quit-if-one-screen --mouse"
# export LESS="-FXr"
# -F = “Causes less to automatically exit if the entire file can be displayed on the first screen.”
# -X = “Disables sending the termcap initialization and deinitialization strings to the terminal.” (stops less clearing the screen)


# Completions                                                                 #
#.............................................................................#
source <(fzf --zsh)
# mcfly (ctrl+r for searching in history)
export MCFLY_FUZZY=2
export MCFLY_INTERFACE_VIEW=BOTTOM
export MCFLY_DISABLE_MENU=TRUE
export MCFLY_RESULTS=50
export MCFLY_RESULTS_SORT=LAST_RUN
## set mcfly light theme if device in light mode
if [[ "$(defaults read -g AppleInterfaceStyle 2&>/dev/null)" != "Dark" ]]; then
    export MCFLY_LIGHT=TRUE
fi

# zsh completions
GIT_EXTRAS="$HOMEBREW_PREFIX/opt/git-extras"
if [ -d "$GIT_EXTRAS" ]; then 
  source $GIT_EXTRAS/share/git-extras/git-extras-completion.zsh
fi

zstyle ':completion::complete:*' call-command true # use the --help output of commands to generate auto-completions in all contexts
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:complete:*' use-cache true
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:eza' sort false
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:processes' command "ps -wu$USER -opid,user,comm"
zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
zstyle ':completion:*' extra-verbose true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' list-grouped false
zstyle ':completion:*' list-separator ''
zstyle ':completion:*' menu select
zstyle ':completion:*' menu yes select # search
zstyle ':completion:*' option-stacking true
zstyle ':completion:*' word true
zstyle ':completion:files' sort false
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # enable filename colorizing
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' verbose yes

### FZF-TAB
FZF_TAB_GROUP_COLORS=(
  $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[38;5;27m' $'\033[36m'
  $'\033[38;5;100m' $'\033[38;5;98m' $'\033[91m' $'\033[38;5;80m' $'\033[92m'
  $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)
export FZF_DEFAULT_OPTS='--info=hidden --margin 1% --pointer="►" --height 100% --min-height=12 --color border:237 --border=sharp --preview-window=70%,' # --reverse 
# export FZF_DEFAULT_OPTS='--color=16,bg:-1,bg+:15,hl:4,hl+:4,fg:-1,fg+:-1,gutter:-1,pointer:-1,marker:-1,prompt:1 --height 60% --reverse --color border:46 --border=sharp --prompt="➤  " --pointer="➤ " --marker="➤ "'
# export FZF_DEFAULT_OPTS='--reverse --color border:46 --border=sharp --prompt="➤  " --pointer="➤ " --marker="➤ "'

export FZF_TMUX_OPTS='-p' # https://gitlab.com/gnachman/iterm2/-/wikis/tmux-Integration-Best-Practices
# export FZF_CTRL_R_OPTS="--reverse --preview 'printf {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# export FZF_PREVIEW_COLUMNS=80
# export FZF_PREVIEW_LINES=12
# zstyle ':fzf-tab:*' accept-line enter
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# apply to all command
zstyle ':fzf-tab:*' popup-min-size 50 8
zstyle ':fzf-tab:*' popup-pad 30 0

zstyle ':fzf-tab:*.*' switch-group ',' '.' # switch group using `,` and `.`
zstyle ':fzf-tab:complete:*' fzf-min-height 16
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags --color=bg+:23
zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 -l --color=always --icons $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:*' fzf-min-height 10
# apply to all command
zstyle ':fzf-tab:*' popup-min-size 50 10
# only apply to 'diff'
zstyle ':fzf-tab:complete:diff:*' popup-min-size 80 12
zstyle ':fzf-tab:*' show-group none
# zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*.*' switch-group ',' '.'
# show options in as popup - tmux must be installed
zstyle ':fzf-tab:*.*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
# systemd - not relevant for mac
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
# previews
# preview() {
#   if file --mime-type {} | grep -qF image/; then
#     kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {} | sed \$d
#   else
#     less ${(Q)realpath}
#     # bat --color=always {}
# fi
# }
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
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*' fzf-preview 'less ${(Q)realpath}'  # zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 -l --color=always --icons $realpath' # preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ':fzf-tab:complete:*:builtin' fzf-preview 'man $word'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
# zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ":fzf-tab:*" fzf-flags --color=bg+:23
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:eza' sort false
zstyle ':completion:files' sort false
zstyle ':completion:*:complete:*' use-cache true
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

# source ~/auto-sized-fzf.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

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
#.........................................................
export FORCE_COLOR=1
export BETTER_EXCEPTIONS=1
export POETRY_VIRTUALENVS_IN_PROJECT=1

### pyenv
PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT ]]; then
  export PYENV_ROOT=$PYENV_ROOT
  export PATH="$PYENV_ROOT/bin:$PATH"
  ## ATTENTION: pyenv-lazy plugin is required to be installed and enabled for 
  ## pyenv to work without the following line being uncommented
  eval "$(pyenv init -)"
fi
eval "$(register-python-argcomplete pipx)"
### tk-inter
# TK_INTER="$HOMEBREW_PREFIX/opt/tcl-tk"
# if [ -d $TK_INTER ]; then
#   export PATH="$TK_INTER/bin:$PATH"
#   export LDFLAGS="-L$TK_INTER/lib"
#   export CPPFLAGS="-I$TK_INTER/include"
#   export PKG_CONFIG_PATH="$TK_INTER/lib/pkgconfig"
# fi

## NODE 
#.........................................................
### nvm (Node Version Manager)
NVM_DIR="$HOME/.nvm"
if [ -d $NVM_DIR ]; then
  export NVM_DIR=$NVM_DIR
  export NVM_LAZY_LOAD=true
  export NVM_COMPLETION=true
fi

[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" || echo "could not init nvm" # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  || echo could not init nvm bash_completion  # This loads nvm bash_completion

CONSOLE_NINJA_BIN="$HOME/.console-ninja/.bin"
[[ -d $CONSOLE_NINJA_BIN ]] && PATH="$CONSOLE_NINJA_BIN:$PATH" || echo "could not find console-ninja bin directory"

## RUBY
#.........................................................
# HOMEBREW_RUBY="$HOMEBREW_PREFIX/opt/ruby/bin"
# if [ -d $HOMEBREW_RUBY ]; then
#   export PATH="$HOMEBREW_RUBY:$PATH"
#   export PATH="$(gem environment gemdir)/bin:$PATH"
# fi

## RUST
#.........................................................
# RUST_BINARIES="$HOME/.cargo/bin"
# if [ -f "$HOME/.cargo/env" ]; then . "$HOME/.cargo/env"; fi
# if [ -d $RUST_BINARIES ]; then
#   export PATH="$RUST_BINARIES:$PATH"
#   if [ -f "$RUST_BINARIES/sccache" ]; then export RUSTC_WRAPPER=sccache; fi
# fi

## GO
#.........................................................
export PATH="$HOME/go/bin:$PATH"

#  Misc                                                                       #
#-----------------------------------------------------------------------------#
## Tabby AI Autocomplete
# has_cmd tabby-agent && eval "$(tabby-agent init --shell zsh)"

## ZOXIDE: Shell extension to navigate your filesystem faster
has_cmd zoxide && eval "$(zoxide init zsh)"

## ATUIN HISTORY
# if [ -f "$HOME/.atuin/bin/env" ]; then 
#   . "$HOME/.atuin/bin/env"; 
#   eval "$(atuin init zsh)"
# fi

## MCFLY
# "Fly through your shell history"
# has_cmd mcfly && eval "$(mcfly init zsh)"


## GOOGLE CLOUD

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# # The next line enables shell command completion for gcloud.
# if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# KUBECTL_PATH="$HOMEBREW_PREFIX/bin/kubectl"
# if [ -f "$KUBECTL_PATH" ]; then alias kubectl="$KUBECTL_PATH"; fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# if command -v ngrok &>/dev/null; then
#   eval "$(ngrok completion)"
# fi

#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

# Load External Configs                                                       #
#-----------------------------------------------------------------------------#

[ -f $HOME/.config/zsh/.p10k.zsh ] && source $HOME/.config/zsh/.p10k.zsh 2> /dev/null # Load powerlevel10k config

## Source aliases and confidentials last
[ -f $HOME/.config/zsh/.zsh_aliases ] && source $HOME/.config/zsh/.zsh_aliases 2> /dev/null
[[ ! -f $HOME/.config/zsh/.zshrc-confidentials ]] || source $HOME/.config/zsh/.zshrc-confidentials 2> /dev/null # Load additional/secret configurations




#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#  ARCHIVE                                                                    #
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

# find -L $PROJECTS_ROOT -maxdepth 1 -type d | fzf --reverse --pointer="►" --height 100% --min-height=12 --color border:237 --border=sharp --preview-window=30%, --preview 'cd $@; git status ; exa -1 -l --color=always --icons ${(Q)realpath}'
# export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
# export PYTHONHOME=$PYENV_ROOT/versions/"$(python -V | cut -d' ' -f 2)"
# TmuxSessionInit()
# {
#     declare sessionName="$1";
#     shift;

#     # Check if the Tmux session exists
#     if ! tmux has-session -t="$sessionName" 2> '/dev/null';
#     then
#         # Create the Tmux session
#         TMUX='' tmux new-session -ds "$sessionName";
#     fi

#     # Switch if inside of Tmux
#     if [[ "${TMUX-}" != '' ]];
#     then
#         exec tmux switch-client -t "$sessionName";
#     fi

#     # Attach if outside of Tmux
#     exec tmux attach -t "$sessionName";
# }

# TmuxSessionInit '0';
# tmux source-file ~/.tmux.conf
# tmux -CC 
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# export PATH="/usr/local/opt/postgresql@16/bin:$PATH"


