"" Gruvbox colorscheme
let g:gruvbox_contrast_dark = 'soft'
set background=dark

"" NERDTree Configuration, https://github.com/scrooloose/nerdtree
let NERDTreeChDirMode = 2
let NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.sqlite$', '__pycache__']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$','\.bak$', '\~$']
let NERDTreeShowBookmarks = 1
let NERDTree_tabs_focus_on_files=1
let NERDTreeMapOpenInTabSilent = '<RightMouse>'
let NERDTreeWinSize = 25
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <F3> :NERDTreeToggle<CR>

"" gnupg.vim, http://www.vim.org/scripts/script.php?script_id=3645
"" wiki here http://pig-monkey.com/2013/04/password-management-vim-gnupg/
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

"" Lightline.vim, http://git.io/lightline
set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'Connected',
  \ 'separator': { 'left': '', 'right': '' },
  \ }

" show lightline-bufferline
set showtabline=2

" if there are a custom lightline setting for a theme
let x = "~/.vim/lightline-theme.vim"
if filereadable(expand(x))
  execute 'source' x
endif

" vim-tmux-navigator, https://github.com/christoomey/vim-tmux-navigator#vim-1
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

" linting
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = ' '
let g:ale_sign_warning = ' '
let g:ale_open_list = 1
let g:ale_list_window_size = 3
let g:ale_lint_on_text_changed = 'never'
highlight ALEErrorSign ctermbg=0 ctermfg=magenta

