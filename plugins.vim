"     ____  __    __  _____________   _______
"    / __ \/ /   / / / / ____/  _/ | / / ___/
"   / /_/ / /   / / / / / __ / //  |/ /\__ \
"  / ____/ /___/ /_/ / /_/ // // /|  /___/ /
" /_/   /_____/\____/\____/___/_/ |_//____/
"

" Automatic installation of vim-plug
let s:data=$XDG_DATA_HOME
if has ('nvim')
    let s:plug=expand(s:data.'/nvim/site/autoload/plug.vim')
else
    let s:plug=expand(s:data.'/vim/autoload/plug.vim')
    set rtp=$XDG_DATA_HOME/vim,/usr/share/vim/vimfiles,$VIMRUNTIME,/usr/share/vim/vimfiles/after
endif
if empty(glob(s:plug))
    exec "!curl -fLo " . s:plug . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

unlet s:plug

call plug#begin('$XDG_DATA_HOME/vim/plugged')

" Syntax Highlighting {{{

    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    Plug 'octol/vim-cpp-enhanced-highlight' " Syntax highlighting C++11/14/17
    Plug 'hdima/python-syntax'              " Python syntax highlighting
    Plug 'vim-pandoc/vim-pandoc-syntax'     " pandoc syntax module

" }}}

" Autocomplete/Programming/LSP {{{

    Plug 'majutsushi/tagbar'            " displays tags in a window
    Plug 'ludovicchabant/vim-gutentags' " Tags management
    " Plug 'veegee/vim-pic'               " 8, 16, and 32 bit PIC microcontroller assembler support
    " Plug 'jvirtanen/vim-octave'         " Octave syntax
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}

" }}}

" File Management/Git {{{
" ===================

    Plug 'junegunn/fzf.vim'               " Fuzzy file finder
    Plug 'jreybert/vimagit'               " Ease your git workflow
    Plug 'airblade/vim-gitgutter'         " shows a git diff in the 'gutter' (sign column)

" }}}

" New text objects {{{
" ================

    " Plug 'kana/vim-textobj-user'     " Needed by vim-textobj-function
    " Plug 'kana/vim-textobj-function' " f F text objects
    " Plug 'kana/vim-operator-user'    " User defed operators/actions
    " Plug 'michaeljsmith/vim-indent-object'

"}}}

" tpope awesome plugins {{{
" =====================

    Plug 'tpope/vim-fugitive'     " A Git wrapper so awesome, it should be illegal
    Plug 'tpope/vim-surround'     " surround items (){}[]<>
    Plug 'tpope/vim-rsi'          " Readline style insertion
    Plug 'tpope/vim-commentary'   " Comment stuff out
    Plug 'tpope/vim-repeat'       " Make . usable by plugins
    if has ('nvim')
    else
        Plug 'tpope/vim-sensible' " Sensible vim defaults
    endif

" }}}

" Color and status {{{
" ================

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tomasiser/vim-code-dark'

"}}}

" Language {{{
" ========

    Plug 'ron89/thesaurus_query.vim' " For English, chinese, french, russian, german
    Plug 'rhysd/vim-grammarous'      " Powerful grammar checker

"}}}

" Embedded / Electronics {{{
" ======================

    Plug 'glts/vim-radical'             " Convert decimal, hex, octal, binary
    Plug 'triglav/vim-visual-increment' " use inc dec num letter/ create seq
    Plug 'fidian/hexmode'               " edit binary files in a hex mode automatically


" }}}

" Misc {{{

    " Plug 'jiangmiao/auto-pairs'       " Insert or delete brackets, parens, quotes in pair.
    Plug 'junegunn/vim-easy-align'    " align text along some common character
    Plug 'dhruvasagar/vim-table-mode' " An awesome automatic table creator
    Plug 'vimwiki/vimwiki'            " Personal Wiki for Vim
    Plug 'moll/vim-bbye'              " Delete buffers without messing layout
    Plug 'easymotion/vim-easymotion'  " Vim motion on speed!
    " Plug 'kshenoy/vim-signature'   " gutter for marks

"}}}

call plug#end()

" vim: set foldmethod=marker foldlevel=0:

