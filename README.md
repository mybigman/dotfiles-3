## Setup

```txt                              
bar               > polybar,lemonbar
compositor        > compton
extra background  > pscircle
fonts             > iosevka,roboto mono,noto,liberation mono,material-icons,dina,ttf-anka-coder,NERD fonts
image viewer      > feh
irc               > weechat
lock screen       > i3lock
media player      > mpv
music player      > ncmpcpp
program launcher  > rofi,dmenu
PDF viewer        > zathura
terms             > kitty
web browser       > brave
wm                > awesome,subtle,i3-gaps
mails             > offlineimap,msmtp and mutt (soon neomutt)
```
A list of dependendies can be found [here](https://raw.githubusercontent.com/szorfein/dotfiles/master/dependencies-list.txt) if need.

## Installation

I use [GNU stow](http://www.gnu.org/software/stow/) in order to keep 4-5 different themes.  
Start going into your home:

    $ cd ~

Clone this repository:

    $ git clone https://github.com/szorfein/dotfiles
    $ cd dotfiles

The last theme is installable with:

    $ stow config
    $ stow images
    $ stow theme-universe

It will create for each file a symbolic link into your `$HOME`, the first time, stow will show you files you have to backup (or delete).    
To switch on an other theme, you have to delete the older:

    $ stow -D theme-universe
    $ stow theme-creation

If you install my dots in an other directory than `home/username`, each commands should have `-t ~` in addition, e.g:

    $ stow -D theme-universe -t ~
    $ stow theme-creation -t ~

And last thing, when you update this repository with `git pull`, it's nice to reinstall all directories than you use in order to have all the latest files in your home:

    $ git pull
    $ stow -D image -t ~
    $ stow images -t ~
    $ stow -D theme-universe -t ~
    $ stow theme-universe -t ~

## Environment

A variable should be set in your ~/.bashrc or ~/.zshrc, the terminal you use, kitty for me:

    $ vim ~/.zshrc
    export TERMINAL=/usr/bin/kitty

It will be used by i3 and subtle.

## vim

For now, i use vim with:
+ [pathogen](https://github.com/tpope/vim-pathogen) to load vim plugins.
+ [nerdtree](https://github.com/scrooloose/nerdtree)
+ [vim-gpg](https://github.com/jamessan/vim-gnupg) to encrypt my password.
+ [lightline](https://github.com/itchyny/lightline.vim)
+ [indentLine](https://github.com/Yggdroot/indentLine)
+ [colorizer](https://github.com/lilydjwg/colorizer)  
+ [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
+ [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)  

Colorscheme for vim are not include into this repo, you have to download and install them manually, the link is on the description of each screens bellow.  

If you use pathogen, you can use my script to download and install all the vim colors that i use:

    $ ./install --vim

## zsh

I use the plugin [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with the theme [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt).

You can install theses repos with:

    $ ./install --zsh

## Screens
**Last**:`theme-connected` [wm]:*awesome* [term]: *kitty* [vim-color] [Dark](https://github.com/szorfein/dark.vim), [font] [Nerd Roboto Mono](http://nerdfonts.com/#downloads).   
![Last screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/connected.jpg "connected")  

`theme-dark` [wm]:*awesome* [term]: *kitty* [vim-color] [Dark](https://github.com/szorfein/dark.vim), [font] [Nerd Roboto Mono](http://nerdfonts.com/#downloads).   
![Dark screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/dark.jpg "dark")  

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


## Old wallpapers

If you search an wallpaper that i've use, search into the list [here](https://raw.githubusercontent.com/szorfein/dotfiles/master/wallpapers-list.txt).

### Troubleshooting

To install:  
+ bspwm: [wiki](https://github.com/szorfein/dotfiles/wiki/Install-BSPWM)  
+ i3-gaps: [wiki](https://github.com/szorfein/dotfiles/wiki/i3-gaps)
+ subtle: [wiki](https://github.com/szorfein/dotfiles/wiki/subtle)
