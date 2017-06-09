" {{{ Plugins and Settings

" Vundle is used to handle plugins.
" https://github.com/gmarik/Vundle.vim

" {{{ VUNDLE SETUP

set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" }}}

" <PLUGINS>

" {{{ vim-scala
"     =========

" Plugin 'derekwyatt/vim-scala'

" }}}

" {{{ vim-qml
"     =========

" Plugin 'peterhoeg/vim-qml'

" }}}

" {{{ Auto Close
"     ========

" Plugin 'townk/vim-autoclose'

" }}}


" {{{ Auto Pair
"     ========

Plugin 'jiangmiao/auto-pairs'

let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

" }}}

" {{{ ack.vim
"     =======

Plugin 'mileszs/ack.vim'

" }}}

" {{{ vim-tmux
"     ========

Plugin 'tmux-plugins/vim-tmux'

" }}}

" {{{ JS development
"     ==============

" Plugin 'mustache/vim-mustache-handlebars'
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'mtscout6/vim-cjsx'
" Plugin 'digitaltoad/vim-jade'
" 
" }}}

" {{{ vim-instant-markdown
"     ====================

Plugin 'suan/vim-instant-markdown'

" }}}

" {{{ editorconfig-vim
"     ================

Plugin 'editorconfig/editorconfig-vim'

" }}}

" {{{ vim-localvimrc: Project-specific vimrc's
"     ========================================
"
" The 'exrc' option almost achieves this, but it only checks the *current*
" directory; if you have a local .vimrc in your project root but open vim
" in a subfolder, 'exrc' will miss it.
"
" The local .vimrc will be the very last file loaded (as indicated by
" :scriptnames), so instead of setting things like filetypes using
" autocommands (which are prohibited in the sandbox anyway), you just write
" some vim script in the .lvimrc that is executed every time a buffer is
" entered in that folder hierarchy.

Plugin 'embear/vim-localvimrc'

" OPTIONS:

" This is a potential security leak, but I want local .vimrc's specifically
" to set up autocommands that do stuff with filetypes, so what can ya do.
"
" DEFAULT: 1
let g:localvimrc_sandbox=0

" Keep the default, but set it explicitly here for self-documentation.
"
" DEFAULT: '.lvimrc'
let g:localvimrc_name='.lvimrc'

" Remember when I accept local .vimrc's until they are changed.
"
" DEFAULT: 0
let g:localvimrc_persistent=2

" For some reason, if you are in a buffer whose filetype has been set by a
" local vimrc like so...
"
"   if &ft == 'html'
"       setl ft=liquid
"   endif
"
" ... the filetype will be reset to 'html' as soon as you run :Vexplore,
" so adding 'BufLeave' to the trigger list causes the plugin to source the
" .lvimrc immediately after the netrw pane is opened, re-re-setting the
" filetype to 'liquid' (or whatever).
"
" DEFAULT: ['BufWinEnter']
let g:localvimrc_event=['BufWinEnter', 'BufLeave']

" }}}

" {{{ His Home-Row-ness the Pope of Tim
"     =================================

" vim-surround: s is a text-object for delimiters; ss linewise
" ys to add surround
Plugin 'tpope/vim-surround'

" vim-commentary: gc is an operator to toggle comments; gcc linewise
Plugin 'tpope/vim-commentary'

" vim-repeat: make vim-commentary and vim-surround work with .
Plugin 'tpope/vim-repeat'

" vim-liquid: syntax stuff
Plugin 'tpope/vim-liquid'

" vim-markdown: some stuff for fenced language highlighting
Plugin 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'yaml', 'haml', 'bash=sh']

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-eunuch'

" }}}

" {{{ Autocomplete
"     ===========
Plugin 'scrooloose/snipmate-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'craigemery/vim-autotag'
Plugin 'alvan/vim-closetag'

" {{{ vim-closetag config

" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

" }}}
" {{{ YCM Config
"     ==========
let g:ycm_key_list_select_completion=["<tab>"]
let g:ycm_key_list_previous_completion=["<S-tab>"]

" }}}

" {{{ ultisnips config
"     ================
  " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsExpandTrigger="<nop>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" }}}

" }}}

" {{{ NERDTree
"     ========

Plugin 'scrooloose/nerdtree'

" OPTIONS:

" Get rid of objects in C projects
let NERDTreeIgnore=['\~$', '.o$', 'bower_components', 'node_modules', '__pycache__']
let NERDTreeWinSize=20

" }}}

" {{{ netrw: Configuration
"     ====================

let g:netrw_banner=0        " disable banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
" hide gitignore'd files
let g:netrw_list_hide=netrw_gitignore#Hide()
" hide dotfiles by default (this is the string toggled by netrw-gh)
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" }}}

" </PLUGINS>

" {{{ VUNDLE TEARDOWN

call vundle#end()
filetype plugin indent on

" }}}

" }}}

