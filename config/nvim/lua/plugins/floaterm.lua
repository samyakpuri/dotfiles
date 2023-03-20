return {
  "voldikss/vim-floaterm",
  keys = {
    vim.keymap.set("n", "<F1>", ":FloatermToggle scratch<CR>"),
    vim.keymap.set("t", "<F1>", "<C-\\><C-n>:FloatermToggle scratch<CR>"),
  },
  config = function()
    vim.g.floaterm_gitcommit = "floaterm"
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_wintitle = 0
  end,
  opts = {},
}
