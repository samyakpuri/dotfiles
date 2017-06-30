" Use vim-plug for managing plugins

" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('$HOME/.vim/plugged')

" Syntax Highlighting {{{
" ===================

" qml syntax
" Plug 'peterhoeg/vim-qml'

" ruby syntax
Plug 'joker1007/vim-ruby-heredoc-syntax'

" Vim syntax file for scss
Plug 'cakebaker/scss-syntax.vim'

" syntax for LESS (dynamic CSS)
Plug 'groenewege/vim-less'

" CSS3 syntax
Plug 'hail2u/vim-css3-syntax'

" Python syntax highlighting
Plug 'hdima/python-syntax'

" template engine for Python syntax
Plug 'mitsuhiko/vim-jinja'

" set the background of color values to the color
Plug 'gko/vim-coloresque'

" JS development {{{
" ==============


" Mustach support
Plug 'mustache/vim-mustache-handlebars'

" CoffeeScript support for vim
Plug 'kchmck/vim-coffee-script'

" CoffeeScript with React JSX
Plug 'mtscout6/vim-cjsx'

" pug / jade support
Plug 'digitaltoad/vim-pug'

" Yet Another JavaScript Syntax
Plug 'othree/yajs.vim'

" }}}

" }}}

" Code compilation/checking {{{
" =========================

" asynchronously runs programs
Plug 'neomake/neomake'

" syntax checking plugin
" Plug 'scrooloose/syntastic'

" }}}

" Autocomplete {{{
" ============

" ultimate solution for snippets
Plug 'SirVer/ultisnips'

" contains snippetsfiles for various programming languages
Plug 'honza/vim-snippets'

"" code completion engine
" Plug 'Valloric/YouCompleteMe'

" asynchronous code completion framework
Plug 'maralla/completor.vim'

" autocompletion library for python
Plug 'davidhalter/jedi-vim'

" support for expanding abbreviations similar to emmet
Plug 'mattn/emmet-vim'

" html5 support
Plug 'othree/html5.vim'

" auto pairs
Plug 'jiangmiao/auto-pairs'

" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'

" }}}

" File Manager {{{
" ============


" File Drawer
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons'


" fuzzy file finder and so much more
Plug 'junegunn/fzf', { 'dir': '~/.vim/plugged/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" }}}

" Miscelaneous {{{
" ============


" align text along some common character
Plug 'junegunn/vim-easy-align'

" use local vimrc for project specific work
Plug 'embear/vim-localvimrc'

" awesome multiple selection feature
Plug 'terryma/vim-multiple-cursors'

" Vim motion on speed!
Plug 'easymotion/vim-easymotion'

" text filtering and alignment
Plug 'godlygeek/tabular'

" A Narrow Region Plugin for vim
Plug 'chrisbra/NrrwRgn'

" Table Mode for instant table creation
Plug 'dhruvasagar/vim-table-mode'

" Text outlining and task management for Vim based on Emacs' Org-Mode
Plug 'jceb/vim-orgmode' 

" vimscript for gist
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

" }}}

" His Home-Row-ness the Pope of Tim {{{
" ==================================


" surroundings: parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'


" endings for html, xml, etc. - ehances surround
Plug 'tpope/vim-ragtag'

" Comment stuff out
Plug 'tpope/vim-commentary'

" remaps . in a way that plugins can tap into it.
Plug 'tpope/vim-repeat'

" Vim Liquid runtime files with Jekyll enhancements
Plug 'tpope/vim-liquid'

" vim-markdown: some stuff for fenced language highlighting
Plug 'tpope/vim-markdown'

" best Git wrapper of all time
Plug 'tpope/vim-fugitive'

" Git runtime files
Plug 'tpope/vim-git'

" for editing Ruby on Rails applications
Plug 'tpope/vim-rails'

" combine with netrw to create a delicious salad dressing
Plug 'tpope/vim-vinegar'

" runtime files for Haml, Sass, and SCSS
Plug 'tpope/vim-haml'

" Vim sugar for the UNIX shell commands that need it the most
Plug 'tpope/vim-eunuch'

" Readline style insertion
Plug 'tpope/vim-rsi'

" }}}

" Theme {{{
" =====


" Molokai color scheme
Plug 'tomasr/molokai'

" Gruvbox color scheme
Plug 'morhetz/gruvbox'

" Lean & mean status/tabline
Plug 'vim-airline/vim-airline'

" Airline themes
Plug 'vim-airline/vim-airline-themes'

" }}}

" Initialize plugin system
call plug#end()

filetype plugin indent on
