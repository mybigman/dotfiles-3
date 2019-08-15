let g:lightline = {
  \ 'colorscheme': 'Connected',
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
  \ 'separator': { 'left': '', 'right': '' },
  \ }
