let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'yaml', 'haml', 'bash=sh']

" {{{ MarkDown

  noremap <leader>TM :TableModeToggle<CR>
  let g:table_mode_corner="|"

  let g:neomake_markdown_proselint_maker = {
      \ 'errorformat': '%W%f:%l:%c: %m',
      \ 'postprocess': function('neomake#postprocess#GenericLengthPostprocess'),
      \}
  let g:neomake_markdown_enabled_makers = ['alex', 'proselint']

" }}}

