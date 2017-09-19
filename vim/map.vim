" Key Mappings

" Run shell command
" ... and print output
nnoremap <C-h> :.w !bash<CR>
" ... and append output
nnoremap <C-l> yyp!!bash<CR>

" Easy quickfix navigation
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

" Newlines
nnoremap <C-j> o<ESC>k
nnoremap <C-k> O<ESC>j

" Easy header/source swap
nnoremap [f :call SourceHeaderSwap()<CR>

" Usual ^^ behavior re-adds to the buffer list; this leaves it hidden
nnoremap <C-^> :b#<CR>

" Yank all top-level Python methods into register m
nnoremap ,m let @m="" \| g/def /exe "normal 0f l\"Myt(" \| let @m.=","

" Select the stuff I just pasted
nnoremap gV `[V`]

" Easy saving
inoremap <C-u> <ESC>:w<CR>

" Sane pasting
command! Paste call SmartPaste()

" De-fuckify whitespace
nnoremap <F4> :retab<CR>:%s/\s\+$//e<CR><C-o>

" De-fuckify syntax hilighting
nnoremap <F3> :syn sync fromstart<CR>

" Editing vimrc
nnoremap ,v :source $MYVIMRC<CR>
nnoremap ,e :edit $MYVIMRC<CR>

" Quickly change search hilighting
nnoremap <silent> ; :set invhlsearch<CR>

" Change indent continuously
vmap < <gv
vmap > >gv

" Tabs
if exists( '*tabpagenr' ) && tabpagenr('$') != 1
    nnoremap ,V :tabdo source $MYVIMRC<CR>
else
    nnoremap ,V :bufdo source $MYVIMRC<CR>
endif

" camelCase => camel_case
vnoremap ,case :s/\v\C(([a-z]+)([A-Z]))/\2_\l\3/g<CR>

" Session mappings
nnoremap ,s :mksession! Session.vim<CR>

" Diff Mode
nnoremap <silent> ,j :if &diff \| exec 'normal ]czz' \| endif<CR>
nnoremap <silent> ,k :if &diff \| exec 'normal [czz' \| endif<CR>
nnoremap <silent> ,p :if &diff \| exec 'normal dp' \| endif<CR>
nnoremap <silent> ,o :if &diff \| exec 'normal do' \| endif<CR>
nnoremap <silent> ZD :if &diff \| exec ':qall' \| endif<CR>

" Clean up Sass source
vnoremap ,S :call CleanupSassSource()<CR>

" Movement between tabs OR buffers
"
nnoremap <silent> L :call MyNext()<CR>
nnoremap <silent> H :call MyPrev()<CR>

" Resizing split windows
nnoremap ,w :call SwapSplitResizeShortcuts()<CR>

" RST headers
nnoremap <silent> <C-_> :let chr=nr2char(getchar()) \| call RSTHeader(chr)<CR>
inoremap <silent> <C-_>1 <ESC>:call RSTHeader("=")<CR>o
inoremap <silent> <C-_>2 <ESC>:call RSTHeader("-")<CR>o
inoremap <silent> <C-_>3 <ESC>:call RSTHeader("^")<CR>o

" Swap tab/space mode
nnoremap ,<TAB> :set et! list!<CR>

" Quick Ruby execute wrapper
nnoremap \rex oif __FILE__ == $0end<ESC>O

" Insert timestamp
nnoremap <C-d> "=strftime("%-l:%M%p")<CR>P
inoremap <C-d> <C-r>=strftime("%-l:%M%p")<CR>

" set Terminal exit to esc
if has('nvim')
    tnoremap <ESC> <C-\><C-n>
endif

" Toggle NERDTree
nnoremap <leader>f :NERDTreeToggle<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" fzf
" inoremap <leader>o <ESC>:Files<CR>
nnoremap <leader>o <ESC>:Files<CR>
" inoremap <leader>b <ESC>:Buffers<CR>
nnoremap <leader>b <ESC>:Buffers<CR>

" Force saving files that require root permission 
cnoremap w!! w !sudo tee > /dev/null 
