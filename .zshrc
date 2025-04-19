# Source zinit
_direnv_hook() {
  trap -- '' SIGINT
  eval "$("/usr/local/bin/direnv" export zsh)"
  trap - SIGINT
}
typeset -ag precmd_functions
if (( ! ${precmd_functions[(I)_direnv_hook]} )); then
  precmd_functions=(_direnv_hook $precmd_functions)
fi
typeset -ag chpwd_functions
if (( ! ${chpwd_functions[(I)_direnv_hook]} )); then
  chpwd_functions=(_direnv_hook $chpwd_functions)
fi
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
export bin_path=/usr/local/bin/
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# source $bin_path/zinit.zsh

### Theme (Powerlevel10k, lazy loaded)
zinit ice depth=1; zinit light romkatv/powerlevel10k

### Core Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light Aloxaf/fzf-tab

### Git plugin from Oh My Zsh (only the git plugin, not the whole framework)
zinit snippet OMZ::plugins/git/git.plugin.zsh

### FZF stuff (assuming you have fzf installed via brew or similar)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Optional: zsh-async (for fancy prompt info)
zinit light mafredri/zsh-async

### Optional: Direnv support
zinit light direnv/direnv
eval "$(direnv hook zsh)"

### AI Autocomplete: Tabby (optional)
# tabby start in background (or via launchd/systemd)
# zinit snippet https://raw.githubusercontent.com/TabbyML/tabby/main/plugins/zsh/tabby.plugin.zsh

### Aliases (keep your old ones)
source ~/.zsh_aliases 2>/dev/null

### FZF Preview alias (example)
fbat() {
  local file
  file=$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}') && code "$file"
}

# ZSH options
setopt autocd nomatch
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
