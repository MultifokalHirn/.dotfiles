
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
