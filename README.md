## Setup

```txt                              
bar               > awesome,polybar,lemonbar
compositor        > compton
extra background  > pscircle
fonts             > iosevka,roboto mono,liberation mono,material-icons,dina,ttf-anka-coder,NERD fonts
image viewer      > feh
irc               > weechat
multimedia        > mpv,ncmpcpp,mpc,alsa
program launcher  > rofi,dmenu
PDF viewer        > zathura
terms             > xst
wm                > awesome,subtle,i3-gaps
mails             > offlineimap,msmtp and neomutt
```
A list of dependendies can be found [here](https://raw.githubusercontent.com/szorfein/dotfiles/master/hidden-stuff/dependencies-list.txt) if need. For an old wallpaper, search [here](https://raw.githubusercontent.com/szorfein/dotfiles/master/hidden-stuff/wallpapers-list.txt).

## Table of contents
- [installation](#installation-for-the-last-theme)
- [use stow](#howto-stow)
- [tips with stow](#some-tips-for-stow)
- [vim](#vim)
- [shell](#shell)
- [screenshots](#screens)

## Installation for the last theme
For the last [theme-anonymous](#screens), 
you will have to install some packages, like [GNU stow](http://www.gnu.org/software/stow/).

### Archlinux
Official packages:

    sudo pacman -S stow awesome xorg-xinit git rofi compton feh

From [AUR](https://aur.archlinux.org/), you need:
        
    nerd-fonts-iosevka nerd-fonts-roboto-mono xst-git 

### Gentoo (with [ninjatools](https://github.com/szorfein/ninjatools) overlay)

    sudo emerge -av app-admin/stow nerd-fonts-roboto-mono nerd-fonts-iosevka xst x11-wm/awesome x11-apps/xinit feh compton dev-vcs/git rofi

### Clone this repository

    cd
    git clone https://github.com/szorfein/dotfiles
    cd dotfiles

## Howto stow
`stow` will create a symbolic link of each files in a given directory as argument in your `$HOME` and you need 4 directories:

    stow config
    stow images
    stow awesomewm
    stow theme-anonymous

If this repository is cloned into a different directory than `/home/username/`, each commands of `stow` should have `-t ~` in addition, e.g:

    stow config -t ~
    stow images -t ~

If a file alrealy exist, `stow` will show you what you have to move, example:

```
stow config
WARNING! stowing config would cause conflicts:
* existing target is neither a link nor a directory: .Xresources
* existing target is neither a link nor a directory: .xinitrc
All operations aborted.
```
Here, you have to backup the files `.Xresources` and `.xinitrc`

    mv ~/.Xresources ~/.Xresources-BACKUP
    mv ~/.xinitrc ~/.xinitrc-BACKUP

And relaunch stow to see if it's right now.

    stow config

## Environment
Unless you use my `zsh`, a variable should be set in your `~/.bashrc` or `~/.zshrc`, the terminal you are using, `xst` for me:

    vim ~/.zshrc
    export TERMINAL=/usr/bin/xst

It will be used by all wm used in this repository.

### Restart X

    pkill X
    startx

The installation of the last theme is complete.

## Some tips for stow

#### To change the theme
You have to delete the older:

    stow -D theme-universe
    stow theme-creation

And restart X

#### After an update
When you update this repository with `git pull`, it's nice to reinstall all directories than you use in order to have all the latest files in your home:

    git pull
    stow -D image -t ~
    stow images -t ~
    stow -D theme-universe -t ~
    stow theme-universe -t ~

## Vim
If you want the same vim setup, you need:

> [ale](https://github.com/w0rp/ale), 
[colorizer](https://github.com/lilydjwg/colorizer), 
[indentLine](https://github.com/Yggdroot/indentLine), 
[lightline](https://github.com/itchyny/lightline.vim), 
[lightline-bufferline](https://github.com/mengelbrecht/lightline-bufferline), 
[nerdtree](https://github.com/scrooloose/nerdtree), 
[pathogen](https://github.com/tpope/vim-pathogen) to load vim plugins, 
[vim-devicons](https://github.com/ryanoasis/vim-devicons), 
[vim-gitgutter](https://github.com/airblade/vim-gitgutter),  
[vim-gpg](https://github.com/jamessan/vim-gnupg) to encrypt password,  
[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator).  

#### On gentoo (with [ninjatools](https://github.com/szorfein/ninjatools)):
    sudo emerge -av app-vim/gnupg app-vim/lightline gitgutter nerdtree pathogen app-vim/ale vim-devicons app-vim/colorizer vim-tmux-navigator indentline lightline-bufferline

#### And for all the vim colorscheme i use, with pathogen
    ./install --vim

## Shell
For the shell, i use `zsh` with plugins [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt).  
You can install theses repos with:

    ./install --zsh

It's all for the setup :)

## Screens
**Last**:`theme-anonymous` [wm]:*awesome* [term]: *xst* [vim-color] [darkest-space](https://github.com/szorfein/darkest-space), [font] [Nerd Font Iosevka](http://nerdfonts.com/#downloads).   
![Last screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/anonymous.jpg "anonymous")  

`theme-connected` [wm]:*awesome* [term]: *kitty* [vim-color] [darkness.vim](https://github.com/szorfein/darkness.vim), [font] [Nerd Roboto Mono](http://nerdfonts.com/#downloads).   
![Connected screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/connected.jpg "connected")  

`theme-lost` [wm]:*subtle* [term]: *kitty* [vim-color] [OceanicNext](https://github.com/mhartington/oceanic-next), [font] [Nerd Roboto Mono](http://nerdfonts.com/#downloads).   
![Lost screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/lost.jpg "lost")  

`theme-termtor` [wm]:*subtle* [term]: *kitty* [vim-color] [darkest-space](https://github.com/szorfein/darkest-space), [font] [Anka/Coder](https://code.google.com/archive/p/anka-coder-fonts).   
![termtor screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/termtor.jpg "termtor")  

`theme-sombra` [wm]:*subtle*, *i3* [term]: *kitty* [vim-color] [material.vim](https://github.com/kaicataldo/material.vim.git), [font] [Anka/Coder](https://code.google.com/archive/p/anka-coder-fonts).   
![Sombra screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/sombra.jpg "sombra")  

`theme-universe`, [wm]:*subtle* or *i3* [term]: *kitty*, *termite*. [vim-color] [darkest-space](https://github.com/szorfein/darkest-space)
![Universe screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/universe.jpg "universe")

`theme-empire`, [wm]:*subtle* or *i3*. [term]: *termite* or *kitty*. [vim-color] [fromthehell.vim](https://github.com/szorfein/fromthehell.vim) [font] [Iosevka Term](https://github.com/be5invis/Iosevka).  
![Empire screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/empire.jpg "empire")

`theme-madness`, [wm]: *i3* or *subtle*. [term]: *termite* or *kitty*. [vim-color] [darkest-space](https://github.com/szorfein/darkest-space) [font] [dina](http://www.donationcoder.com/Software/Jibz/Dina/index.html).  
![Madness screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/madness.jpg "madness")

`theme-city`, [wm]: *i3* or *subtle*. [term]: *termite* or *kitty*. [vim-color] [darkest-space](https://github.com/szorfein/darkest-space)
![City screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/city.jpg "city")
