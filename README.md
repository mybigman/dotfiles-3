## Setup

```txt                              
bar               > polybar,lemonbar
compositor        > compton
extra background  > pscircle
fonts             > iosevka,roboto mono,noto,liberation mono,material-icons,dina
image viewer      > feh
irc               > Weechat
lock screen       > i3lock
media player      > mpv
music player      > ncmpcpp
program launcher  > rofi,dmenu
PDF viewer        > zathura
terms             > kitty,termite,rxvt
web browser       > vivaldi, brave
wm                > subtle,i3-gaps,bspwm
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
    $ stow images
    $ stow theme-universe

It will create for each file a symbolic link into your `$HOME`, the first time, stow will show you files you have to backup (or delete).    
To switch on an other theme, you have to delete the older:

    $ stow -D theme-universe
    $ stow theme-darkest-space

If you install my dots in an other directory than `home/username`, each commands should have `-t ~` in addition, e.g:

    $ stow -D theme-universe -t ~
    $ stow theme-darkest-space -t ~

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

Colorscheme for vim are not include into this repo, you have to download and install them manually, the link is on the description of each screens bellow.  

## zsh

I use the plugin [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with the theme [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt).

## Screens

**Last**:`theme-fantasy`, [wm]:*subtle* [term]: *kitty*. [vim-color] [fantasy.vim](https://github.com/szorfein/fantasy.vim).

![Last screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/fantasy.jpg "fantasy")

`theme-universe`, [wm]:*subtle* or *i3* [term]: *kitty*. [vim-color] [darkest-space](https://github.com/szorfein/darkest-space)

![Universe screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/universe.jpg "universe")

`theme-darkest-space`, [wm]:*subtle* or *i3*. [term]: *kitty* or *termite*. [vim-color] [darkest-space](https://github.com/szorfein/darkest-space)

![Darkest-space screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/darkest-space.jpg "darkest-space")

`theme-empire`, [wm]:*subtle* or *i3*. [term]: *termite* or *kitty*

![Empire screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/empire.jpg "empire")

`theme-madness`, [wm]: *i3* or *subtle*. [term]: *termite* or *kitty*

![Madness screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/madness.jpg "madness")

`theme-city`, [wm]: *i3* or *subtle*. [term]: *termite* or *kitty*

![City screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/city.jpg "city")

`theme-gruvbox`, [wm]:*subtle*. [term]: *termite*. [vim colorscheme] [gruvbox](https://github.com/morhetz/gruvbox)

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
