# .dotfiles

MultifokalHirn's `.dotfiles` repository, managed using the

## Overview

My setup is based on macOS, so some of the files and instructions are specific
to that operating system. However, most of the files are platform agnostic and
can be used on any Unix-like system.

## How-To

### Using this Repository

I follow the approach of [Drew DeVault](https://drewdevault.com/)'s blog post
[*Managing my dotfiles as a git repository*](https://drewdevault.com/2019/12/30/dotfiles.html).

```bash
cd ~
git init
git remote add origin https://github.com/MultifokalHirn/.dotfiles.git
git fetch --all

#### Attention!
# If you are not on a fresh system, make a backup before proceeding! 
# Or at least go through the repo's contents, and for all files that you 
# probably do not want to get overwritten, rename them to <name>.bak or so.

# will already work if your home folder doesnt conflict with the repo
git checkout main 

# if you have made backups and are **sure** any force-overwrite will be fine
git checkout --force main
```

### brew packages

`brew` is a package manager for macOS similar to `apt-get` and `yum`. You can
install it like so:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

In [`Brewfile-MultifokalHirn`](./Brewfile-MultifokalHirn) I have collected a
set of packages and applications that I would want to have on any new system -
to learn more, just check out the Brewfile.

You can install the packages contained within like so:

```bash
brew bundle --file=~/Brewfile-MultifokalHirn
```

### zsh

I use `zsh` in combination with the config framework
[`ohmyzsh`](https://github.com/ohmyzsh/ohmyzsh) (mostly out of habit, I have
not looked at other alternatives to plain `bash` so far). `zsh` will be
installed if you used my Brewfile, otherwise you can install it like so:

```bash
brew install zsh  # consider setting it as you default shell
```

You can install `ohmyzsh` like so (please refer to the
[official documentation](https://github.com/ohmyzsh/ohmyzsh/wiki) for more
information):

```bash
`sh -c "$(curl -fsSL https://install.ohmyz.sh/)"`
```

#### Configuring zsh

Please refer to my [.zshrc](.zshrc) to check out the configuration I use.

#### Extending ohmyzsh

To install custom themes or plugins, you have to be in the respective
directory in the folder assigned to `$ZSH_CUSTOM` (which is usually
`~/.oh-my-zsh/custom/`).

##### Themes

```bash
cd $ZSH_CUSTOM/themes/ 
```

| Theme              | Command                                                              |
| :----------------- | :------------------------------------------------------------------- |
| `spaceship-prompt` | `git clone https://github.com/spaceship-prompt/spaceship-prompt.git` |

##### Plugins

```bash
cd $ZSH_CUSTOM/plugins/ 
```

| Plugin                    | Command                                                            |
| :------------------------ | :----------------------------------------------------------------- |
| `zsh-autosuggestions`     | `git clone https://github.com/zsh-users/zsh-autosuggestions.git`   |
| `zsh-completions`         | `git clone https://github.com/zsh-users/zsh-completions.git`       |
| `zsh-nvm`                 | `git clone https://github.com/lukechilds/zsh-nvm.git`              |
| `OhMyZsh-full-autoupdate` | `git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git` |
  
### Setups for specific languages

#### python

I *always* advise to use `pyenv` when developing software with Python.
It allows you to install and switch between different versions of Python and
decouples your development environment from the system Python which Apple
will update from time to time, potentially breaking your development setup.

```bash
brew install pyenv
pyenv install 3.12.0 # example version
pyenv global 3.12.0
```

##### pipx

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

macOS has a built-in version of `ruby`. However, I highly advise installing
*separate* `ruby` versions and *only* using those in when developing. On a
fresh system, you will see the following behavior:

```bash
which ruby
# /usr/bin/ruby

/usr/bin/ruby -v
# ruby 2.6.10p210 (2022-04-12 revision 67958) [universal.x86_64-darwin21]

/usr/bin/ruby -e 'puts Gem.user_dir'
# /Users/my_user/.gem/ruby/2.6.0
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

You can install `rustup` like so:

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
