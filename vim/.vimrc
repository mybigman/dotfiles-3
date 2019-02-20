"
"     ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄  
"    ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█  
"     ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄ 
"      ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"       ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"       ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"       ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒   
"         ░░   ▒ ░░      ░     ░░   ░ ░        
"          ░   ░         ░      ░     ░ ░      
"         ░                           ░        

"" exec pathogen for launch some plugins
"" found here https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" file encryption for file save of buffer contents
set cryptmethod=blowfish2 " require vim >= 7.4.399

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" If i enable it, i can't copy anything in clipboard with rxvt-unicode...
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

"" Bell
set noerrorbells
set visualbell

"" Visual Setting
set number

"" Encoding
set ttyfast
set binary

"" Searching
set nohlsearch
set incsearch
set ignorecase
set smartcase

"" Tabs, May be overwritten by autocmd rules
set shiftwidth=2
set softtabstop=0
set tabstop=2
set expandtab

"" Code Folding
set foldenable
set foldmethod=manual

"" Colors
source ~/.vim/colorscheme

"" Gruvbox colorscheme
let g:gruvbox_contrast_dark = 'soft'
set background=dark

"" NERDTree Configuration
"" Found https://github.com/scrooloose/nerdtree
"" NERDTree Configuration
let NERDTreeChDirMode = 2
let NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.sqlite$', '__pycache__']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$','\.bak$', '\~$']
let NERDTreeShowBookmarks = 1
let NERDTree_tabs_focus_on_files=1
let NERDTreeMapOpenInTabSilent = '<RightMouse>'
let NERDTreeWinSize = 18
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <F3> :NERDTreeToggle<CR>

" update colors with F8 with darkest-space colorscheme
"map <F8> :update<CR>:colorscheme darkest-space<CR>
map <F8> :update<CR>:colorscheme darkest-space<CR>
let mapleader=","

"" With vim, copy to clipboard work only if you compile vim with X support
"" Some Keymaps for GPG
imap <C-V> <ESC>"+gpa
" Copy in Normal mode
nmap <leader>y "+yE
" Copy in visual mode
vmap <leader>y "+y

"" gnupg.vim
" plugin here: http://www.vim.org/scripts/script.php?script_id=3645
" wiki here http://pig-monkey.com/2013/04/password-management-vim-gnupg/
if has("autocmd")
  let g:GPGDefaultRecipients = ["0xE2ADD2080A6B28AE"]
  let g:GPGFilePattern = '*.\(gpg\|asc\|pgp\)'

  augroup GnuPGExtra
    exe "autocmd BufReadCmd,FileReadCmd " . g:GPGFilePattern . " call SetGPGOptions()"
    exe "autocmd CursorHold " . g:GPGFilePattern . " quit"
  augroup END

  function SetGPGOptions()
    set filetype=gpgpass
    set noswapfile
    set viminfo=
  endfunction
endif

" Lightline.vim
" http://git.io/lightline
set laststatus=2
let s:base03 = [ '#151513', 233 ]
let s:base02 = [ '#303030', 0 ]
let s:base01 = [ '#4e4e43', 239 ]
let s:base00 = [ '#666656', 242  ]
let s:base0 = [ '#808070', 244 ]
let s:base1 = [ '#949484', 242 ]
let s:base2 = [ '#a8a897', 248 ]
let s:base3 = [ '#e8e8d3', 253 ]
let s:yellow = [ '#7A7A57', 11 ]
let s:orange = [ '#7A7A57', 3 ]
let s:red = [ '#5F8787', 1 ]
let s:magenta = [ '#8181A6', 13 ]
let s:cyan = [ '#87ceeb', 12 ]
let s:green = [ '#7A7A57', 3 ]
let s:none = [ 'none', 'none' ]

let s:p = {
      \ 'normal':   {},
      \ 'inactive': {},
      \ 'insert':   {},
      \ 'replace':  {},
      \ 'visual':   {},
      \ 'tabline':  {}}

let g:lightline#colorscheme#hybrid#palette = s:p

let g:lightline = {
  \ 'colorscheme': 'nord'
  \ }
