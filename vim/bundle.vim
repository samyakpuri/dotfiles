" Use vim-plug for managing plugins

" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('$HOME/.vim/plugged')

" Syntax Highlighting {{{
" ===================  

" Plug 'peterhoeg/vim-qml'   "qml syntax
Plug 'joker1007/vim-ruby-heredoc-syntax' " ruby syntax
Plug 'cakebaker/scss-syntax.vim' " Vim syntax file for scss 
Plug 'hdima/python-syntax' " Python syntax highlighting
Plug 'othree/yajs.vim' " Yet Another JavaScript Syntax
Plug 'mitsuhiko/vim-jinja' " template engine for Python syntax

" JS development {{{
" ==============

Plug 'mustache/vim-mustache-handlebars'
Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'
Plug 'digitaltoad/vim-jade'

" }}}

" }}}

" Code compilation/checking {{{
" =========================

Plug 'neomake/neomake' " asynchronously runs programs
Plug 'scrooloose/syntastic' "  syntax checking plugin

" }}}

" Autocomplete {{{
" ============ 

Plug 'SirVer/ultisnips'  " ultimate solution for snippets
Plug 'honza/vim-snippets' " contains snippetsfiles for various programming languages
Plug 'Valloric/YouCompleteMe' " code completion engine 
Plug 'davidhalter/jedi-vim' " autocompletion library for python
Plug 'mattn/emmet-vim' " support for expanding abbreviations similar to emmet

" }}}

" File Manager {{{
" ============

Plug 'scrooloose/nerdtree' " A tree explorer

" }}}

" Miscelaneous {{{
" ============ 

Plug 'junegunn/vim-easy-align' " align text along some common character
Plug 'embear/vim-localvimrc' " use local vimrc for project specific work
Plug 'terryma/vim-multiple-cursors' " awesome multiple selection feature
Plug 'easymotion/vim-easymotion' " Vim motion on speed!
" Plug 'godlygeek/tabular' " text filtering and alignment

" }}}

" His Home-Row-ness the Pope of Tim {{{
" ==================================

Plug 'tpope/vim-surround' " "surroundings": parentheses, brackets, quotes, XML tags, and more 
Plug 'tpope/vim-commentary' " Comment stuff out
Plug 'tpope/vim-repeat' " remaps . in a way that plugins can tap into it.
Plug 'tpope/vim-liquid' " Vim Liquid runtime files with Jekyll enhancements
Plug 'tpope/vim-markdown' " vim-markdown: some stuff for fenced language highlighting
Plug 'tpope/vim-fugitive' " best Git wrapper of all time
Plug 'tpope/vim-git' " Git runtime files
Plug 'tpope/vim-rails' " for editing Ruby on Rails applications
Plug 'tpope/vim-vinegar' " combine with netrw to create a delicious salad dressing
Plug 'tpope/vim-haml' " runtime files for Haml, Sass, and SCSS
Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands that need it the most
Plug 'tpope/vim-rsi' " Readline style insertion

" }}}

" Theme {{{
" =====  

Plug 'tomasr/molokai' " Molokai color scheme
Plug 'morhetz/gruvbox' " Gruvbox color scheme

" }}}

" Initialize plugin system
call plug#end()

filetype plugin indent on
