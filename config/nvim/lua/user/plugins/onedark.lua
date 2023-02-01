vim.cmd('colorscheme onedark')

-- Hide the characters in FloatBorder
vim.api.nvim_set_hl(0, 'FloatBorder', {
  fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
  bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
})

-- Make the StatusLineNonText background the same as StatusLine
vim.api.nvim_set_hl(0, 'StatusLineNonText', {
  fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
  bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
})

-- Hide the characters in CursorLineBg
vim.api.nvim_set_hl(0, 'CursorLineBg', {
  fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
  bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
})

vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })
vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
