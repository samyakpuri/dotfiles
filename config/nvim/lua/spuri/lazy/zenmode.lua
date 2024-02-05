return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 90,
			options = {},
		},
	},
	keys = {
		{
			"<leader>zz",
			function()
				require("zen-mode").toggle()
				vim.wo.wrap = false
				vim.wo.number = true
				vim.wo.rnu = true
				ColorMyPencils()
			end,
			desc = "Zen mode start",
		},

		{
			"<leader>zZ",
			function()
				require("zen-mode").toggle()
				vim.wo.wrap = false
				vim.wo.number = false
				vim.wo.rnu = false
				vim.opt.colorcolumn = "0"
				ColorMyPencils()
			end,
			desc = "Zen mode end",
		},
	},
}
