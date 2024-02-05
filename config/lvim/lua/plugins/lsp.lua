return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lua" },
    }, 1, #opts.sources))
  end,
}
