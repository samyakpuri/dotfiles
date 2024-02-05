-- Rename in a popup window
return {
  "hood/popui.nvim",
  dependencies = "RishabhRD/popfix",
  config = function()
    vim.ui.select = require("popui.ui-overrider")
    vim.ui.input = require("popui.input-overrider")
  end,
}
