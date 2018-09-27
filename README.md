## Setup

```txt                              
bar               > polybar,lemonbar
compositor        > compton
extra background  > pscircle
fonts             > iosevka,roboto,noto,liberation mono,material-icons
image viewer      > feh
irc               > Weechat
lock screen       > i3lock
media player      > mpv
music player      > ncmpcpp
program launcher  > rofi,dmenu
PDF viewer        > zathura
terms             > kitty,termite,rxvt
web browser       > vivaldi, brave
wm                > subtle,i3,bspwm
```
A list of dependendies can be found [here](https://raw.githubusercontent.com/szorfein/dotfiles/master/dependencies-list.txt) if need.

## Installation

I've switch to [GNU stow](http://www.gnu.org/software/stow/) recently in order to keep 4-5 different themes.  
Start going into your home:

    $ cd ~

Clone this repository:

    $ git clone https://github.com/szorfein/dotfiles
    $ cd dotfiles

The last theme is installable with:

    $ stow config
    $ stow theme-universe

It will create for each file a symbolic link into your `$HOME`. 
To switch on an other theme, you have to delete the older:

    $ stow -D theme-universe
    $ stow theme-darkest-space

## vim

Vim use my own colorscheme [darkest-space](https://github.com/szorfein/darkest-space), i use vim with:
+ [pathogen](https://github.com/tpope/vim-pathogen) to load vim plugins.
+ [nerdtree](https://github.com/scrooloose/nerdtree)
+ [vim-gpg](https://github.com/jamessan/vim-gnupg) to encrypt my password.

## zsh

I use the plugin [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with the theme [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt).

## Screens

**Last**:`theme-universe`, [wm]:*subtle*. [term]: *kitty*.

![Last screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/universe.jpg "universe")

`theme-darkest-space`, [wm]:*subtle* or *i3*. [term]: *kitty* or *termite*.

![Previous screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/darkest-space.jpg "darkest-space")

`theme-empire`, [wm]:*subtle*. [term]: *termite* or *kitty*

![Empire screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/empire.jpg "empire")

`theme-gruvbox`, [wm]:*subtle*. [term]: *termite*

![Gruvbox screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/gruvbox.jpg "gruvbox")

You can found other screens on:
+ [dotshare.it](http://dotshare.it/~szorfein/dots/)
+ [Reddit](https://www.reddit.com/user/szorfein/posts/)
+ [Imgur](https://imgur.com/user/Szorfein/submitted)
+ [Google+](https://plus.google.com/103351806729237673609)
+ [twitter](https://twitter.com/szorfein)
+ [Blog](https://szorfein.github.io/)

## Old wallpapers

If you search an wallpaper that i've use, search into the list [here](https://raw.githubusercontent.com/szorfein/dotfiles/master/wallpapers-list.txt).

### Troubleshooting

To install:  
+ bspwm: [wiki](https://github.com/szorfein/dotfiles/wiki/Install-BSPWM)  
+ i3-gaps: [wiki](https://github.com/szorfein/dotfiles/wiki/i3-gaps)
+ subtle: [wiki](https://github.com/szorfein/dotfiles/wiki/subtle)
