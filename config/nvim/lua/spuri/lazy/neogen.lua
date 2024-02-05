return {
	"danymat/neogen",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"L3MON4D3/LuaSnip",
	},
	keys = {
		{ "<leader>nf", require("neogen").generate({ type = "func" }), desc = "Generate fuction annotation" },
		{ "<leader>nt", require("neogen").generate({ type = "type" }), desc = "Generate annotation" },
	},
	opts = {
		snippet_engine = "luasnip",
	},
}
