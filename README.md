<!-- markdownlint-disable -->

<p align="center">
  <!-- github-banner-start -->
    <h1><code>.dotfiles</code></h1>
  <!-- github-banner-end -->
</p>

<!-- markdownlint-restore -->
<h2> Contents </h2>

- [Overview](#overview)
- [My Setup](#my-setup)
  - [iTerm2](#iterm2)
  - [`brew` packages](#brew-packages)
  - [`zsh`](#zsh)
    - [Configuring `zsh`](#configuring-zsh)
    - [Extending `ohmyzsh`](#extending-ohmyzsh)
  - [Language specific setups](#language-specific-setups)
    - [`python`](#python)
    - [`ruby`](#ruby)
    - [`rust`](#rust)
- [Using this Repository](#using-this-repository)

## Overview

```txt
.dotfiles/
├── .zshrc                    Configuration file for zsh
├── .p10k.zsh                 Configuration file for powerlevel10k theme
|
├── Brewfile-MultifokalHirn   Collection of packages and applications for Homebrew
|
├── .gitconfig                Configuration file for Git
├── .gitignore                File specifying patterns to ignore in Git
├── .gitmessage               Template for Git commit messages
|
├── .gemrc                    Configuration file for RubyGems
|
└── .config/
   └── bat                    Configuration directory for bat 
```

I mainly use devices running  macOS, so some of the topics here may be specific
to that operating system. However, most of the config files are platform
agnostic and can be used anywhere you can use the thing that it configures.
<!--more-->

## My Setup

### iTerm2

I use [iTerm2](https://iterm2.com) as a replacement for *Terminal*, which comes
shipped with macOS. Please refer to the iterm2 homepage to learn more about its features and how to install it.

**Note:** Whether you use iTerm2, Terminal, or some other terminal emulator has no effect on the rest described herein.

### `brew` packages

[`brew`](https://brew.sh) is a package manager for macOS similar to `apt-get` and `yum`, meaing it can be used to install a wide range of stuff - anything from fundamental (CLI) tools like `ssh` or `git` to GUI apps like Handbrake or Firefox.

You can install `brew` like so:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

In [`Brewfile-MultifokalHirn`](./Brewfile-MultifokalHirn) I have collected a
set of packages and applications that are essential to how I work and use my computer. I added a short explanation for each, so please have a look at the `Brewfile` to learn more.

You can install the packages contained within like so:

```bash
brew bundle --file=~/Brewfile-MultifokalHirn
```

### `zsh`

I use `zsh` in combination with the config framework
[`ohmyzsh`](https://github.com/ohmyzsh/ohmyzsh) (mostly out of habit, I have
not looked at other alternatives to plain `bash` so far).

`zsh` will be installed if you used my `Brewfile`, otherwise you can install it like so:

```bash
brew install zsh  # consider setting it as you default shell
```

You can install `ohmyzsh` like so (please refer to the
[official documentation](https://github.com/ohmyzsh/ohmyzsh/wiki) for more
information):

```bash
`sh -c "$(curl -fsSL https://install.ohmyz.sh/)"`
```

#### Configuring `zsh`

Please refer to my [`.zshrc`](.zshrc) to check out the configuration I use. For me, the config results in shell that extremely fun and quick to use, while also being aesthetically pleasing (at least to me).

#### Extending `ohmyzsh`

To install custom themes or plugins, you have to clone them into the respective directory in the folder assigned to `$ZSH_CUSTOM` (which is usually `~/.oh-my-zsh/custom/`).

##### Themes

To activate a theme, you have to set the `ZSH_THEME` variable in your `.zshrc` to the name of the theme you want to use.
I use the [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme, which is a very powerful and customizable theme. I highly recommend it. See my [`.p10k.zsh`](./.p10k.zsh) for my configuration.

![Screenshot 2023-12-13 at 23 31 23 copy](https://github.com/MultifokalHirn/.dotfiles/assets/7870758/ec67770f-d335-44cc-b44a-1743c77e1bcf)

```bash
cd $ZSH_CUSTOM/themes/ 

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git 
p10k configure

# spaceship-prompt        - I do not use this anymore, but it is a great theme
git clone https://github.com/spaceship-prompt/spaceship-prompt.git
```

##### Plugins

To install plugins, you have to clone them into the `$ZSH_CUSTOM/plugins/` directory and add them to the `plugins` array in your `.zshrc`.

```bash
cd $ZSH_CUSTOM/plugins/

# zinsults
#  throws funny insults at you when you mistyped a command
git clone https://github.com/ahmubashshir/zinsults.git

# OhMyZsh-full-autoupdate
#  keep plugins and themes up to date automatically
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git

# zsh-autosuggestions
#  suggests commands as you type based on history and completions
git clone https://github.com/zsh-users/zsh-autosuggestions.git

# fzf-tab
#  fzf-based completion selection menu
fzf --version || brew install fzf
git clone https://github.com/Aloxaf/fzf-tab.git

# fzf-tab-source
#  collection of option sources for fzf-tab
git clone https://github.com/Freed-Wu/fzf-tab-source.git

# zsh-completions
#  additional completion definitions
git clone https://github.com/zsh-users/zsh-completions.git

# fast-syntax-highlighting
#  fast syntax highlighting 🙃
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git

# zsh-nvm
#  auto-switch between node versions depending on the current directory
git clone https://github.com/lukechilds/zsh-nvm.git

# zsh-pyenv-lazy            
#  lazy loading of pyenv; eval "$(pyenv init -)" is executed the first time pyenv is called
git clone https://github.com/davidparsson/zsh-pyenv-lazy.git

# wakatime
#  time tracking for developers 
git clone https://github.com/sobolevn/wakatime-zsh-plugin.git wakatime;
```

### Language specific setups

#### `python`

I *always* recommend to use `pyenv` when developing software using `python`.
It allows you to install and switch between different versions of `python` and
decouples your development environment from the system `python` which Apple
will update from time to time, potentially breaking your development setup.

```bash
brew install pyenv

pyenv install 3.12.0 # example version
pyenv global 3.12.0 # set global python version to 3.12.0 (default is system python) 
```

##### `pipx`

`pipx` is a tool to install and use packages 'globally'.
It installs `pipx` itself into a separate virtual environment from your
default `python` interpreter, and makes sure that when you run `pipx` command,
it uses the `pipx` virtual environment.

```bash
python -V # check whether you are using the intended python version
pip install --upgrade pipx
pipx ensurepath

pipx install ruff virtualenvwrapper bpython # example packages
```

#### `ruby`

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

To install a `ruby` version can run the following:

> `TODO` - rewrite using `rbenv`

```bash
brew install ruby
```

Your `ruby` version should - at least once you reload the shell - be the one installed by `brew` and behave
similar to the following:

``` bash
which ruby
# /usr/local/opt/ruby/bin/ruby

ruby -v
# ruby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-darwin21]

ruby -e 'puts Gem.user_dir'
# /Users/my_user/.gem/ruby/3.2.0
```

#### `rust`

You can install `rustup` like so:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

##### `sccache`

`sccache` is a compiler cache. It speeds up compilation by caching previous compilations and detecting when the same compilation is being done again.

```bash
cargo install sccache
```

## Using this Repository

I follow the approach described in [Drew DeVault](https://drewdevault.com/)'s
blog [post](https://drewdevault.com/2019/12/30/dotfiles.html) "*Managing my
dotfiles as a git repository*".

```bash
cd ~
git init
git remote add origin https://github.com/MultifokalHirn/.dotfiles.git
git fetch --all
```

The next step will be to merge the repository contents with your current
setup. **Please be very careful here!**

> **Attention!**
If you are not on a fresh system, make a backup before proceeding!
Or at least go through the repo's contents, and for all files that you
probably do not want to get overwritten, rename them to `<name>.bak` or somesuch.

I recommend you first run the following, which will already work, if your home folder does not conflict with the repo

``` bash
git checkout main  # 'main' is this repo's main branch 
```

If that *did* produce an error, you *can* force the `checkout` as per below.

Again, ***please* make backups and make sure that you will not be able to overwrite anything that cannot be restored**.

``` bash
git checkout --force main
```

<!-- ## Misc

```bash
npm i -g safe-rm
``` -->

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
