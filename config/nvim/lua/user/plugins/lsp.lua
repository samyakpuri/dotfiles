local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  "sumneko_lua",
  "rust_analyzer"
})

-- Configure lua lsp for neovim
lsp.nvim_workspace()


local luasnip = require('luasnip')
local cmp = require('cmp')
local lspkind = require('lspkind')


local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  preselect = 'none',
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  mapping = cmp_mappings,
  formatting = {
	  format = lspkind.cmp_format({
		  with_text = true,
		  menu = {
			  nvim_lsp = '[LSP]',
			  nvim_lua = '[Lua]',
			  buffer = '[BUF]',
		  },
	  }),
  sources = {
	  { name = 'nvim_lsp' },
	  { name = 'nvim_lsp_signature_help' },
	  { name = 'nvim_lua' },
	  { name = 'luasnip' },
	  { name = 'path' },
	  { name = 'buffer' },
  }
  },
})


lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>gr", ":Telescope lsp_references<CR>", opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

