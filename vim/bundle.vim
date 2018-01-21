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

" ruby highlighting
Plug 'vim-ruby/vim-ruby'

" Ruby on Rails development environment inside Vim.
Plug 'smolnar/vim-rails-bundle'

" ruby syntax
" Plug 'joker1007/vim-ruby-heredoc-syntax'

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

" i3 syntax highlighting for vim
Plug 'PotatoesMaster/i3-vim-syntax'

" }}}

" JS development {{{
" ==============


" Mustach support
" Plug 'mustache/vim-mustache-handlebars'

" CoffeeScript support for vim
" Plug 'kchmck/vim-coffee-script'

" CoffeeScript with React JSX
" Plug 'mtscout6/vim-cjsx'

" pug / jade support
" Plug 'digitaltoad/vim-pug'

" Yet Another JavaScript Syntax
" Plug 'othree/yajs.vim'


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

" implements some of TextMate's snippets features
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" Plug 'garbas/vim-snipmate'

" code completion engine
" Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer --tern-completer'}

" Code completion using deoplete
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

" C/C++/Objective-C/Objective-C++ source for deoplete.nvim
Plug 'zchee/deoplete-clang'

" Tern plugin for Vim
" Plug 'ternjs/tern_for_vim', {'do': 'npm install'}

" Refactoring tool for Ruby in vim!Refactoring tool for Ruby in vim!
" Plug 'ecomba/vim-ruby-refactoring'

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
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' 


" fuzzy file finder and so much more
Plug 'junegunn/fzf', { 'dir': '~/.vim/plugged/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Dark powered asynchronous unite all interfaces for Neovim/Vim8
" Plug 'Shougo/denite.nvim'
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

" Delete buffers and close files in Vim without closing your windows or messing up your layout
Plug 'moll/vim-bbye'

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
