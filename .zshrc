
#                                                                             #
# .ZSHRC                                                                      #
# ------------                                                                #
# Author: @MultifokalHirn                                                     #
# Repository: https://github.com/MultifokalHirn/.dotfiles                     #
#                                                                             #


#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#


# Enable Powerlevel10k instant prompt.                                        #
#-----------------------------------------------------------------------------#
# ATTENTION: This should stay close to the top of $HOME/.zshrc.               #
# Initialization code that may require console input (password prompts, [y/n] #
# confirmations, etc) must go above this block; everything else may go below  #
INSTANT_P="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
if [[ -r $INSTANT_P ]]; then source $INSTANT_P; fi 

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
plugins=(
  git
  fzf-tab
  fzf-tab-source
  fast-syntax-highlighting
  zsh-autosuggestions
  macos
  history
  pre-commit
  python
  # zsh-nvm
  ohmyzsh-full-autoupdate
  pyenv-lazy
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

#..............................................................................

source $ZSH/oh-my-zsh.sh # initialize oh-my-zsh



###############################################################################
# USER CONFIG ----------------------------------------------------------------#
###############################################################################

has_cmd() {
  # Helper function to check if a command exists. 
  # Example usage: `has_cmd some_command && echo yay || echo no`
	for cmd in "$@"; do
		command -v "$cmd" >/dev/null
	done
}

# ENV VARS                                                                    #
#.............................................................................#

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_PREFIX="/usr/local"  # $(brew --prefix)
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
export GREP_OPTIONS="--color"            # colorization in grep results
export WORDCHARS='*?[]$HOME&;!$%^<>'
# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words (!)


# ZSH                                                                         #
#.............................................................................#

setopt no_beep
setopt complete_in_word

## PATH

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
zstyle ':completion:*:exa' sort false
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
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 -l --color=always --icons $realpath'
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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 -l --color=always --icons $realpath' # preview directory's content with exa when completing cd
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
zstyle ':completion:*:exa' sort false
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
if [ -d $PYENV_ROOT ]; then
  export PYENV_ROOT=$PYENV_ROOT
  export PATH="$PYENV_ROOT/bin:$PATH"
  ## ATTENTION: pyenv-lazy plugin is required to be installed and enabled for 
  ## pyenv to work without the following line being uncommented
  # eval "$(pyenv init -)"
fi
eval "$(register-python-argcomplete pipx)"
### tk-inter
TK_INTER="$HOMEBREW_PREFIX/opt/tcl-tk"
if [ -d $TK_INTER ]; then
  export PATH="$TK_INTER/bin:$PATH"
  export LDFLAGS="-L$TK_INTER/lib"
  export CPPFLAGS="-I$TK_INTER/include"
  export PKG_CONFIG_PATH="$TK_INTER/lib/pkgconfig"
fi

## NODE 
#.........................................................
### nvm (Node Version Manager)
NVM_DIR="$HOME/.nvm"
if [ -d $NVM_DIR ]; then
  export NVM_DIR=$NVM_DIR
  export NVM_LAZY_LOAD=true
  export NVM_COMPLETION=true
fi

## RUBY
#.........................................................
HOMEBREW_RUBY="$HOMEBREW_PREFIX/opt/ruby/bin"
if [ -d $HOMEBREW_RUBY ]; then
  export PATH="$HOMEBREW_RUBY:$PATH"
  export PATH="$(gem environment gemdir)/bin:$PATH"
fi

## RUST
#.........................................................
RUST_BINARIES="$HOME/.cargo/bin"
. "$HOME/.cargo/env"
if [ -d $RUST_BINARIES ]; then
  export PATH="$RUST_BINARIES:$PATH"
  if [ -f "$RUST_BINARIES/sccache" ]; then export RUSTC_WRAPPER=sccache; fi
fi


#  Misc                                                                       #
#-----------------------------------------------------------------------------#

## GOOGLE CLOUD

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# # The next line enables shell command completion for gcloud.
# if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

KUBECTL_PATH="$HOMEBREW_PREFIX/bin/kubectl"
if [ -f "$KUBECTL_PATH" ]; then alias kubectl="$KUBECTL_PATH"; fi


#                             CUSTOM FUNCTIONS                                #
#-----------------------------------------------------------------------------#
export PROJECTS_ROOT="$HOME/Documents/GitHub"
change-project() {
  # Used via: alias p="change-project"
  cd $(find -L $PROJECTS_ROOT -maxdepth 1 -type d | selecta) && clear
}

# show-file() {
#   cat $(ls | selecta)
# }

# from-clipboard() {
#   echo $(pbpaste) && pbpaste
# }

auto-retry() {
  false
  while [ $? -ne 0 ]; do
    "$@" || (
      sleep 1
      false
    )
  done
}


#  ALIASES                                                                    #
#-----------------------------------------------------------------------------#
# if you alias an existing command, for example 'ls' then you can run '\ls'
# to run the unaliased version

# From Dan Ryan's blog - http://danryan.co/using-antigen-for-zsh.html
man () {
  # Shows pretty `man` page.
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

# Sorts directories in top, colors, and prints `/` at directories:
# alias ls="gls --color -h --group-directories-first -F"

alias bat="\bat --theme=GitHub"

alias dfh='df -x"squashfs" -x"overlay" -h'
alias history='history -E 1' # show timestamps and ignore duplicates in history
alias p='change-project' # change-project is defined in custom functions
alias d='cd ~/Downloads/'
alias mv='mv -iv'
alias cp='cp -iv'
alias mkdir='mkdir -v'
alias hn='clx --nerdfonts --categories="top,best,ask,show,new"'
# "Run" the file to look at its content (https://www.stefanjudis.com/today-i-learned/suffix-aliases-in-zsh/)
# $ ./readme.md
# -> cat ./readme.md
alias -s {js,json,env,md,html,css,toml}=cat

has_cmd bat && alias cat='bat -P --style "plain,changes" --color=always'
has_cmd brew && alias update='brew update && brew upgrade'
has_cmd broot && alias cdd='broot -s'
has_cmd /usr/local/bin/htop && alias top='/usr/local/bin/htop'
has_cmd btm && alias top='btm'
has_cmd dust && alias du='dust'
has_cmd exa && alias la='exa -la --icons --color=always' || alias la='ls -lah'
has_cmd eza && alias la='eza --sort=type --long --all --icons --color=always' || alias la='ls -lah'
has_cmd lazydocker && alias lzd='lazydocker'

# alias clipboard='pbcopy'
# alias clippy='pbcopy'
# alias copied='pbpaste'
# alias copied='echo $pbpaste && $pbpaste' # usage example: `copied | echo`
# alias copied='from-clipboard' # usage example: `copied | echo`

# Lists the ten most used commands.
alias stats='sort | uniq -c | sort -r'
alias history-stats='\history 0 | awk "{print \$2}" | stats | head'

has_cmd safe-rm && alias rm='safe-rm' 
# https://github.com/kaelzhang/shell-safe-rm
# To install: npm install -g safe-rm
# TODO: consider using this instead:
#   Remove all items safely, to Trash (`brew install trash`).
#   [[ -z "$commands[trash]" ]] || alias rm='trash' 2>&1 > /dev/null


# Load External Configs                                                       #
#-----------------------------------------------------------------------------#
has_cmd mcfly && eval "$(mcfly init zsh)"
[[ ! -f $HOME/.zshrc-confidentials ]] || source $HOME/.zshrc-confidentials  # Load additional/secret configurations
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh # Load powerlevel10k config

#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#


#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#  ARCHIVE                                                                    #
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#

# find -L $PROJECTS_ROOT -maxdepth 1 -type d | fzf --reverse --pointer="►" --height 100% --min-height=12 --color border:237 --border=sharp --preview-window=30%, --preview 'cd $@; git status ; exa -1 -l --color=always --icons ${(Q)realpath}'
# export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
# export PYTHONHOME=$PYENV_ROOT/versions/"$(python -V | cut -d' ' -f 2)"
# [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
# source $HOME/.config/broot/launcher/bash/br
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/opt/postgresql@16/bin:$PATH"
