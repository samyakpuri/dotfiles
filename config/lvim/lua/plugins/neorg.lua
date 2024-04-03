return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/zen-mode.nvim",
    "lukas-reineke/headlines.nvim",
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {
          config = {
            icons = {
              code_block = {
                conceal = true,
              },
            },
          },
        }, -- Adds pretty icons to your documents
        ["core.neorgcmd"] = {},
        ["core.summary"] = {},
        ["core.journal"] = {},
        ["core.autocommands"] = {},
        ["core.export"] = { config = {} },
        ["core.export.markdown"] = { config = {} },
        ["core.integrations.treesitter"] = { config = {} },
        ["core.ui"] = {},
        ["core.ui.calendar"] = {},
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Git/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.qol.todo_items"] = {
          config = {
            create_todo_items = true,
            create_todo_parents = true,
          },
        },
      },
    })
  end,
}
