" Auto Commands

" Clear auto commands

au!

" Make the modification indicator [+] white on red background
au ColorScheme * hi User1 gui=bold term=bold cterm=bold guifg=white guibg=red ctermfg=white ctermbg=red

" Tweak the color of the fold display column
au ColorScheme * hi FoldColumn cterm=bold ctermbg=233 ctermfg=146

" Spaces Only
au FileType mustache,markdown,cpp,hpp,vim,sh,html,htmldjango,css,sass,scss,javascript,coffee,python setl expandtab list

" Tabs Only
au FileType c,h,make setl foldmethod=syntax noexpandtab nolist
au FileType gitconfig,sql setl noexpandtab nolist

" Folding
au FileType html,htmldjango,css,sass,javascript,coffee,python,ruby,eruby setl foldmethod=indent foldenable
au FileType json setl foldmethod=indent foldenable shiftwidth=4 softtabstop=4 tabstop=4 expandtab

" Tabstop/Shiftwidth
au FileType mustache,javascript,coffee,sass,scss setl softtabstop=2 shiftwidth=2 tabstop=2
" au FileType rst setl softtabstop=3 shiftwidth=3 tabstop=3

" Other
au FileType python let b:python_highlight_all=1
au FileType markdown setl linebreak
au FileType vim setl foldmethod=marker foldmarker={{{,}}}

" NERDTree create
" au VimEnter * call StartUP()
