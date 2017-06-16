" Vim functions

" MySessionSave() {{{
function! MySessionSave()
    tabdo NERDTreeClose
    mksession! .session.vim
    qall!
endfunction
" }}}

" MyStatusLine() {{{

function! MyStatusLine()
    let statusline = ""
    " Filename (F -> full, f -> relative)
    let statusline .= "%f"
    " Buffer flags
    let statusline .= "%( %h%1*%m%*%r%w%) "
    " File format and type
    let statusline .= "(%{&ff}%(\/%Y%))"
    " Left/right separator
    let statusline .= "%="
    " Line & column
    let statusline .= "(%l,%c%V) "
    " Character under cursor (decimal)
    let statusline .= "%03.3b "
    " Character under cursor (hexadecimal)
    let statusline .= "0x%02.2B "
    " File progress
    let statusline .= "| %P/%L"
    return statusline
endfunction

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
function! RSTHeader(chr)
    " inserts an RST header without clobbering any registers
    put =substitute(getline('.'), '.', a:chr, 'g')
endfunction

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

" MyNext() and MyPrev(): Movement between tabs OR buffers {{{
function! MyNext()
    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
        " Tab support && tabs open
        normal gt
    else
        " No tab support, or no tabs open
        execute ":bnext"
    endif
endfunction
function! MyPrev()
    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
        " Tab support && tabs open
        normal gT
    else
        " No tab support, or no tabs open
        execute ":bprev"
    endif
endfunction
" }}}

" Tasksheets {{{

function! UpdateTaskRemain(line_no, remain, hours_worked)
    let l:check_line = a:line_no
    let l:last_line = line('$')
    let l:already_has_summary = 0

    " echo "update " . a:line_no . " remaining: " . string(a:remain) . " with worked: " . string(a:hours_worked)

    while l:check_line <= l:last_line
        if getline(l:check_line + 1) == ""
            " last line before empty (end of task clause)
            break
        endif
        let l:check_line += 1
    endwhile

    let l:line = getline(l:check_line)

    if l:line =~ "^REMAIN" || l:line =~ "^TOTAL"
        let l:already_has_summary = 1
    endif

    let l:total = "TOTAL: " . string(a:hours_worked)

    if a:remain > 0.0
        let l:new_summary = "REMAIN: " . string(a:remain) . " (" . l:total . ")"
    else
        let l:new_summary = l:total
    endif

    if l:already_has_summary
        call setline(l:check_line, l:new_summary)
    else
        call append(l:check_line, l:new_summary)
    endif
endfunction

function! UpdateTaskDisplay()
    if &ft != 'tasksheet' | return | endif
    let l:default_project = substitute(system("python custom_calc_timesheet.py " . expand("%") . " default_project"), '\n', '', '')
    let l:tasks = split(system("python custom_calc_timesheet.py " . expand("%") . " exhaust"), '\n')

    exe "normal mz"

    syn clear taskBudgetExceeded
    syn clear taskBudgetExhausted

    for l:task in l:tasks
        let [l:task_id, l:project, l:remain, l:hours_worked] = split(l:task, " ")

        if str2float(l:remain) < 0.0
            exe "syn match taskBudgetExceeded /" . l:task_id . "/ contained"
        elseif str2float(l:remain) == 0.0
            exe "syn match taskBudgetExhausted /" . l:task_id . "/ contained"
        endif

        if l:project == l:default_project
            let l:default_project_pattern = "\\[" . l:project . "\\]"
            let l:anything_else_pattern = "[^\\[]"
            let l:project_pattern = "\\(" . l:default_project_pattern . "\\|" . l:anything_else_pattern . "\\)"
        else
            let l:project_pattern = "\\[" . l:project . "\\]"
        endif

        exe "g/^" . l:task_id . " " . l:project_pattern . "/call UpdateTaskRemain(line('.'), " . l:remain . ", " . l:hours_worked . ")"
    endfor

    exe "normal `z"
endfunction

" }}}

" {{{ Sane Pasting

function! SmartPaste()
    setl paste
    normal "+p
    setl nopaste
endfunction

" }}}

function! ExtendRight()
    let l:start=winnr()
    exe "normal \<c-w>l"
    let l:shrink=bufnr('%')
    close
    exe "normal " . l:start . "\<c-w>w"
    exe "normal \<c-w>k"
    vsplit
    exe "b " . l:shrink
endfunction
