# .dotfiles

MultifokalHirn's `.dotfiles` repository, managed using the technique describe by
[Drew DeVault](https://drewdevault.com/) in his blog post
[*Managing my dotfiles as a git repository*](https://drewdevault.com/2019/12/30/dotfiles.html).

## Overview

My setup is based on macOS, so some of the files and instructions are specific
to that operating system. However, most of the files are platform agnostic and
can be used on any Unix-like system.

## How-To

## brew

`brew` is a package manager for macOS. It is used to install and update
software packages. It is similar to `apt-get` and `yum`.

### Installation

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install MultifokalHirn's brew packages

```bash
brew bundle --file=~/Brewfile-MultifokalHirn
```

## zsh

`zsh` is the shell I use on macOS. It is an extended version of `bash` with
many useful features.

### oh-my-zsh

> This is just quick supmmary of how to get and run the interactive install
> script for `oh-my-zsh`. For more, please please refer to the
> [official documentation](https://github.com/ohmyzsh/ohmyzsh/wiki).

| Method   | Command                                           |
| :------- | :------------------------------------------------ |
| **curl** | `sh -c "$(curl -fsSL https://install.ohmyz.sh/)"` |
| **wget** | `sh -c "$(wget -O- https://install.ohmyz.sh/)"`   |

#### .zshrc

Please refer to my [.zshrc](.zshrc) for the configuration I use.

#### Extending oh-my-zsh

To install custom plugins and themes, you have to be in the respective
directory in the folder assigned to `$ZSH_CUSTOM` (which is usually `~/.oh-my-zsh/custom/`).

##### Custom Themes

```bash
cd $ZSH_CUSTOM/themes/ 
```

| Theme              | Command                                                              |
| :----------------- | :------------------------------------------------------------------- |
| `spaceship-prompt` | `git clone https://github.com/spaceship-prompt/spaceship-prompt.git` |

##### Custom Plugins

```bash
cd $ZSH_CUSTOM/plugins/ 
```

| Plugin                    | Command                                                            |
| :------------------------ | :----------------------------------------------------------------- |
| `zsh-autosuggestions`     | `git clone https://github.com/zsh-users/zsh-autosuggestions.git`   |
| `zsh-completions`         | `git clone https://github.com/zsh-users/zsh-completions.git`       |
| `zsh-nvm`                 | `git clone https://github.com/lukechilds/zsh-nvm.git`              | `` |
| `OhMyZsh-full-autoupdate` | `git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git` | `` |
  
## Setups for specific languages

### python

#### Installation

I *always* advise to use `pyenv` when developing software with Python.
It allows you to install and switch between different versions of Python and
decouples your development environment from the system Python which Apple
will update from time to time, potentially breaking your development setup.

```bash
brew install pyenv
pyenv install 3.12.0 # example version
pyenv global 3.12.0
```

#### pipx

`pipx` is a tool to install and run Python packages globally.
It installs `pipx` itself into a separate virtual environment from your
default Python interpreter, and makes sure that when you run `pipx` command,
it uses the `pipx` virtual environment.

```bash
pip install --upgrade pip pipx

pipx ensurepath
pipx install pdm ruff pre-commit virtualenvwrapper
```

### ruby

macOS has a built-in version of `ruby`. However, it is highly advised to install
a separate version for your own development using `brew`.

System ruby:

```bash
which ruby
# /usr/bin/ruby

/usr/bin/ruby -v
# ruby 2.6.10p210 (2022-04-12 revision 67958) [universal.x86_64-darwin21]

/usr/bin/ruby -e 'puts Gem.user_dir'
# /Users/lennardwolf/.gem/ruby/2.6.0
```

#### Setup

```bash
brew install rbenv ruby

source ~/.zshrc
```

Your `ruby` version should now be the one installed by `brew` and behave
similar to the following:

``` bash
which ruby
# /usr/local/opt/ruby/bin/ruby

ruby -v
# ruby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-darwin21]

ruby -e 'puts Gem.user_dir'
# /Users/my_user/.gem/ruby/3.2.0
```

### rust

#### Installation

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#### sccache

`sccache` is a compiler cache. It speeds up compilation by caching previous compilations and detecting when the same compilation is being done again.

```bash
cargo install sccache
```

<!-- 
#### fonts & icons

```bash
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
brew install --cask font-sf-mono-nerd-font-ligaturized
brew install hicolor-icon-theme
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip ~/Downloads/Hack.zip
```
brew install orbstack
``` -->
<!-- ```diff
   - plugins=(...)
   + plugins=(... evalcache)
``` -->
