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
- [vim](#vim)
- [shell](#shell)
- [screenshots](#screens)

## Installation for the last theme
For the last [theme-miami](#screens), please, follow the procedure on the [wiki page](https://github.com/szorfein/dotfiles/wiki/theme-anonymous).  

<!--
### Gentoo (with [ninjatools](https://github.com/szorfein/ninjatools) overlay)
    sudo emerge -av app-admin/stow nerd-fonts-roboto-mono nerd-fonts-iosevka xst x11-wm/awesome x11-apps/xinit feh compton dev-vcs/git rofi
-->
## Stow
If you are blocked with `stow` or need more explanations, see the [wiki page](https://github.com/szorfein/dotfiles/wiki/stow) before post an issue.  

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

### Awesome
**Last**:`theme-morpho` **term**: xst, **vim-color**: [darkest-space](https://github.com/szorfein/darkest-space), **font**: [Iosevka Term Nerd Font](http://nerdfonts.com/#downloads).

| clean | start screen | tiling | 
| --- | --- | --- |
| ![clean](https://github.com/szorfein/unix-portfolio/raw/master/morpho/clean.png "morpho clean")| ![start\_screen](https://github.com/szorfein/unix-portfolio/raw/master/morpho/start_screen.png "morpho start screen")| ![tiling](https://github.com/szorfein/unix-portfolio/raw/master/morpho/tiling.png "morpho tiling")|

`theme-miami` **term**: xst, **vim-color**: [fromthehell](https://github.com/szorfein/fromthehell.vim), **font**: [Space Mono Nerd Font](http://nerdfonts.com/#downloads).

| start\_screen widget | terms (xst) - lightline.vim - tmux |
| --- | --- |
| ![miami screenshot](https://github.com/szorfein/unix-portfolio/raw/master/miami/start_screen.png "miami start screen")| ![terms](https://github.com/szorfein/unix-portfolio/raw/master/miami/terms.png "miami terms")|

`theme-machine` **term**:*xst*, **vim-color**: [darkest-space](https://github.com/szorfein/darkest-space), **font**: [Space Mono Nerd Font](http://nerdfonts.com/#downloads).   
![Machine screenshot](https://github.com/szorfein/unix-portfolio/raw/master/machine/monitoring.png "machine")  

`theme-anonymous` [term]: *xst* [vim-color] [darkest-space](https://github.com/szorfein/darkest-space), [font] [Nerd Font Iosevka](http://nerdfonts.com/#downloads).   
![Anonymous screenshot](https://github.com/szorfein/unix-portfolio/blob/master/anonymous/music.png "anonymous")  

`theme-connected` **term**: xst, **vim-color**: [gruvbox material](https://github.com/sainnhe/gruvbox-material), **font**: [Nerd Roboto Mono](http://nerdfonts.com/#downloads).   
![Connected screenshot](https://github.com/szorfein/unix-portfolio/blob/master/connected/ncmpcpp.png "connected")  

### Others wm
`theme-lost` [wm]:*subtle* [term]: *kitty* [vim-color] [OceanicNext](https://github.com/mhartington/oceanic-next), [font] [Nerd Roboto Mono](http://nerdfonts.com/#downloads).   
![Lost screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/lost.jpg "lost")  

`theme-sombra` [wm]:*subtle*, *i3* [term]: *kitty* [vim-color] [material.vim](https://github.com/kaicataldo/material.vim.git), [font] [Anka/Coder](https://code.google.com/archive/p/anka-coder-fonts).   
![Sombra screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/sombra.jpg "sombra")  

`theme-empire`, [wm]:*subtle* or *i3*. [term]: *termite* or *kitty*. [vim-color] [fromthehell.vim](https://github.com/szorfein/fromthehell.vim) [font] [Iosevka Term](https://github.com/be5invis/Iosevka).  
![Empire screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/empire.jpg "empire")

`theme-madness`, [wm]: *i3* or *subtle*. [term]: *termite* or *kitty*. [vim-color] [darkest-space](https://github.com/szorfein/darkest-space) [font] [dina](http://www.donationcoder.com/Software/Jibz/Dina/index.html).  
![Madness screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/madness.jpg "madness")

`theme-city`, [wm]: *i3* or *subtle*. [term]: *termite* or *kitty*. [vim-color] [darkest-space](https://github.com/szorfein/darkest-space)
![City screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/city.jpg "city")
