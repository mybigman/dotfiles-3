let g:lightline = {
  \ 'colorscheme': 'Battleship',
  \ 'active': {
  \   'left': [ ['linter'],
  \             [ 'gitbranch' ] ],
  \   'right': [ [ 'percent', 'lineinfo', 'fileformat' ],
  \             [ 'filencode', 'filetype' ] ],
  \ },
  \ 'inactive': {
  \   'left': [['linter'], ['filename_active']],
  \   'right':[['lineinfo']],
  \ },
  \ 'component_function': {
  \   'filename': 'FileName',
  \   'gitbranch': 'GitBranch',
  \   'filencode': 'FileEncoding',
  \   'readonly': 'LightLineReadonly',
  \   'filename_active': 'LightlineFilenameActive',
  \   'filetype': 'LightLineFiletype',
  \   'fileformat': 'LightLineFileformat',
  \ },
  \ 'component_expand': {
  \   'linter': 'WizErrors',
  \   'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_type': {
  \   'readonly': 'error',
  \   'linter': 'error',
  \   'buffers': 'tabsel'
  \ },
  \ 'tabline': {'left': [['buffers']], 'right': [['close']] },
  \ 'component': {
  \   'close': 'ﴔ ',
  \ },
  \ 'separator': { 'left': '▊▌▎', 'right': '▎▌▊' },
  \ }

" lighline functions
function! FileName()
  let l:fn = expand("%:t")
  let l:ro = &ft !~? 'help' && &readonly ? " RO" : ""
  let l:mo = &modifiable && &modified ? " +" : ""
  return l:fn . l:ro . l:mo
endfunction

function! GitBranch()abort
  return !IsTree() ? exists('*fugitive#head') ? fugitive#head() : '' : ''
endfunction

function FileEncoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
endfunction

function LightLineFiletype()
  "return winwidth(0) > 70 ? (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : '') : ''
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! WizErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  " ×   
  return l:counts.total == 0 ? '' : printf(' %d', l:counts.total)
endfunction

function! IsTree()
  let l:name = expand('%:t')
  return l:name =~ 'NetrwTreeListing\|undotree\|NERD' ? 1 : 0
endfunction

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#number_map = {
  \ 0: '⓿ ', 1: '❶ ', 2: '❷ ', 3: '❸ ', 4: '❹ ',
  \ 5: '❺ ', 6: '❻ ', 7: '❼ ', 8: '❽ ', 9: '❾ '}

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
