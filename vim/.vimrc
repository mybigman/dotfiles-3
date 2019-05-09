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
let NERDTreeWinSize = 30
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <F3> :NERDTreeToggle<CR>

" update colors with F8 with darkest-space colorscheme
"map <F8> :update<CR>:colorscheme darkest-space<CR>
map <F8> :update<CR>:colorscheme skull<CR>
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
let g:lightline = {
  \ 'colorscheme': 'Blackout',
  \ 'separator': { 'left': '', 'right': '' },
  \ }

" Color
syntax enable

" for vim 8
if (has("termguicolors"))
  set termguicolors
  " This is only necessary if you use "set termguicolors".
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" for vim 7
set t_Co=256

" Colorscheme
source ~/.vim/colorscheme

" vim-tmux-navigator
let g:tmux_navigator_no_mappings=1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
nnoremap <silent> <C-BS> :TmuxNavigatePrevious<CR>

" gitbutter
let g:gitgutter_realtime = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = ':'
