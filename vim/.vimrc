" Use spaces instead of tabs
set expandtab

" Number of spaces per indentation level
set tabstop=4

" Number of spaces for automatic indentation
set shiftwidth=4

" Number of spaces inserted when pressing Tab
set softtabstop=4

" Enable automatic indentation
set autoindent

" Enable syntax highlighting
syntax on

" Enable filetype detection, load any filetype-specific plugins, indentation, etc.
filetype plugin indent on

" Show line numbers
set number

" Highlight the current line
set cursorline

" Enable incremental search
set incsearch

" Enable highlighting all the matches in incsearch mode
" But don't enable hlsearch always
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter [/\?] :set hlsearch
  autocmd CmdlineLeave [/\?] :set nohlsearch
augroup END

colorscheme catppuccin_mocha
