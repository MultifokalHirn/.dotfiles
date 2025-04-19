#                                                                             #
# .ZSHRC                                                                      #
# ------------                                                                #
# Author: @MultifokalHirn                                                     #
# Repository: https://github.com/MultifokalHirn/.dotfiles                     #
#                                                                             #
# source antidote
antidote_path="$(brew --prefix)/opt/antidote/share/antidote"
# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

#[[ -f ${antidote_path}/antidote.zsh ]] || source ${antidote_path}/antidote.zsh
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load
# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt

# /usr/local/Cellar/antidote/1.9.8/share/antidote/antidote.zsh
# ${ZDOTDIR:-~}/.zshrc

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || echo "Creating ${zsh_plugins}" && touch ${ZDOTDIR:-~}/${zsh_plugins}.txt

# Lazy-load antidote from its functions directory.
ZFUNCDIR=${ZDOTDIR:-$HOME}/.zfunctions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $ZFUNCDIR/*(.:t)
fpath=(${antidote_path}/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh
autoload -Uz promptinit && promptinit && prompt pure
# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh

