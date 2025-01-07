return {
  "voldikss/vim-floaterm",
  keys = {
    { "<F1>", ":FloatermToggle scratch<CR>", desc = "Toggle Floaterm" },
    { "<F1>", "<C-\\><C-n>:FloatermToggle scratch<CR>", mode = "t", desc = "Toggle Floaterm" },
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
