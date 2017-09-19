" Ruby Syntax {{{
" ===========

let g:ruby_heredoc_syntax_filetypes = {
    \ "haml" : {
    \   "start" : "HAML",
    \},
    \ "sass" : {
    \   "start" : "SASS",
    \},
    \ "yaml" : {
    \   "start" : "YAML",
    \},
    \ "eruby" : {
    \   "start" : "ERB",
    \}
\}

" }}} 

" Local Vimrc {{{
" ===========

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

" NERDTree {{{
" ========

" Get rid of objects in C projects
let NERDTreeIgnore=['\~$', '.o$', 'bower_components', 'node_modules', '__pycache__']
let NERDTreeWinSize=20

" }}}

" netrw: Configuration {{{
" ==================== 

let g:netrw_banner=0        " disable banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
" hide gitignore'd files
let g:netrw_list_hide=netrw_gitignore#Hide()
" hide dotfiles by default (this is the string toggled by netrw-gh)
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" }}}


" Neomake {{{
" =======

let g:neomake_javascript_maker=['jshint', 'jscs']
let g:neomake_json_maker=['jsonlint', 'jsonval']
let g:neomake_ruby_maker=['rubocop','mri']
let g:neomake_perl_maker=['perl','perlcritic','podchecker']
let g:neomake_python_maker=['pylint','pep8','python']
let g:neomake_cpp_maker=['gcc','cppcheck','cpplint','ycm','clang_tidy','clang_check']
let g:neomake_c_maker=['gcc','make','cppcheck','clang_tidy','clang_check']
let g:neomake_haml_maker=['haml_lint', 'haml']
let g:neomake_html_maker=['jshint']
let g:neomake_yaml_maker=['jsyaml']
let g:neomake_sh_maker=['sh','shellcheck','checkbashisms']
let g:neomake_vim_maker=['vimlint']
let g:neomake_css_maker=['csslint','stylelint']

" }}}

" Airline {{{
" =======

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
  let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme = 'molokai'

" }}}

" Vim Table Mode {{{
" ==============

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" }}}

" Ultisnips {{{
" =========

let g:UltiSnipsExpandTrigger = "<C-Space>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" }}}

" Auto Pair {{{
" =========

let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`','<':'>'}

" }}}

" SuperTab {{{
" ========

let g:SuperTabDefaultCompletionType = "<tab>"

" }}}
