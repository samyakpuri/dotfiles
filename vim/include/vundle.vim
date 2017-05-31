set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" [1] Theme / Pretty Stuff
Plugin 'altercation/vim-colors-solarized'
Plug 'endel/vim-github-colorscheme'
" Awesome looking meta at bottom
" Fugitive will help with git related stuff, and show branch on statusline
Plug 'tpope/vim-fugitive' | Plug 'bling/vim-airline'
""
""" Some ESSENTIAL IDE like plugins for Vim
"""
" [2] File tree viewer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" [3]
" Several plugins to help work with Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'https://github.com/christoomey/vim-tmux-runner'
Plug 'christoomey/vim-run-interactive'

" [4] search filesystem with ctrl+p
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" [5] Code highlighting and linting
Plug 'scrooloose/syntastic' "Run linters and display errors etc

" [6] Adds a ; at the end of a line by pressing <leader> ;
Plug 'lfilho/cosco.vim'

Plug 'jiangmiao/auto-pairs' "MANY features, but mostly closes ([{' etc
Plug 'vim-scripts/HTML-AutoCloseTag' "close tags after >
Plug 'vim-scripts/tComment' "Comment easily with gcc
Plug 'tpope/vim-repeat' "allow plugins to utilize . command
Plug 'tpope/vim-surround' "easily surround things...just read docs for info
Plug 'vim-scripts/matchit.zip' " % also matches HTML tags / words / etc
Plug 'duff/vim-scratch' "Open a throwaway scratch buffer
""

""" Utilities / Extras / Etc
"""
" [7] Make gists of current buffer
" View (https://github.com/mattn/gist-vim) for setup instructions
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'

" [8] Diary, notes, whatever. It's amazing
Plug 'vimwiki/vimwiki'

" Opens a browser to preview markdown files
Plug 'suan/vim-instant-markdown', {'do': 'npm install -g instant-markdown-d'}
""

" [9]
Plug 'SirVer/ultisnips' | Plug 'justinj/vim-react-snippets' | Plug 'colbycheeze/vim-snippets'

" [10]
" supertab makes tab work with autocomplete and ultisnips
Plug 'ervandew/supertab'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
