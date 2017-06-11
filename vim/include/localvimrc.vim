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

