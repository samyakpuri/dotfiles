" Vim functions

" MySessionSave() {{{
" function! MySessionSave()
"     tabdo NERDTreeClose
"     mksession! .session.vim
"     qall!
" endfunction
" }}}

" MyStatusLine() {{{

" function! MyStatusLine()
"     let statusline = ""
"     " Filename (F -> full, f -> relative)
"     let statusline .= "%f"
"     " Buffer flags
"     let statusline .= "%( %h%1*%m%*%r%w%) "
"     " File format and type
"     let statusline .= "(%{&ff}%(\/%Y%))"
"     " Left/right separator
"     let statusline .= "%="
"     " Line & column
"     let statusline .= "(%l,%c%V) "
"     " Character under cursor (decimal)
"     let statusline .= "%03.3b "
"     " Character under cursor (hexadecimal)
"     let statusline .= "0x%02.2B "
"     " File progress
"     let statusline .= "| %P/%L"
"     return statusline
" endfunction

" }}}

" CleanupSassSource() {{{

function! CleanupSassSource()
  " All comma delimiters should have a following space
  silent '<,'>s/,\([^\s]\)/, \1/ge
  " All comma delimiters should have 1 and only 1 space
  silent '<,'>s/,\s\{2,\}/, /ge
endfunction

" }}}

" Miscellaneous {{{
" function! RSTHeader(chr)
"     " inserts an RST header without clobbering any registers
"     put =substitute(getline('.'), '.', a:chr, 'g')
" endfunction

function! CurrLineLength()
    return len(getline(line(".")))
endfunction

function! LineLength(row)
    return len(getline(a:row))
endfunction
" }}}

" Source/Header Swap {{{
function! SourceHeaderSwap()
    if expand('%:h') == 'content/ui'
        execute ":edit mods/base/ui/".expand('%:t:r').".py"
    elseif expand('%:h') == 'mods/base/ui'
        execute ":edit content/ui/".expand('%:t:r').".html"
    elseif expand('%:e') == 'h'
        if filereadable(expand('%:r').".cpp")
            execute ":edit ".expand('%:r').".cpp"
        else
            execute ":edit ".expand('%:r').".c"
        endif
    else
        edit %<.h
    endif
endfunction
" }}}

" {{{ Sane Pasting

function! SmartPaste()
    setl paste
    normal "+p
    setl nopaste
endfunction

" }}}

" function! ExtendRight()
"     let l:start=winnr()
"     exe "normal \<c-w>l"
"     let l:shrink=bufnr('%')
"     close
"     exe "normal " . l:start . "\<c-w>w"
"     exe "normal \<c-w>k"
"     vsplit
"     exe "b " . l:shrink
" endfunction

" " Create NERDTree on StartUP

" function! StartUP()
"     if 0 == argc()
"         execute 'NERDTree' getcwd()
"     else
"         if argv(0) == '.'
"             execute 'NERDTree' getcwd()
"         else
"             execute 'NERDTree' getcwd() . '/' . argv(0)
"         endif
"     endif
"     execute 'NERDTreeToggle'
" endfunction
