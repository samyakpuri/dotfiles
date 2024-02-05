return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",

		dependencies = { "rafamadriz/friendly-snippets" },
		keys = {
			--- TODO: What is expand?
			{ "<C-s>e", require("luasnip").expand(), mode = { "i" }, { silent = true } },
			{ "<C-s>;", require("luasnip").jump(1), mode = { "i", "s" }, { silent = true } },
			{ "<C-s>,", require("luasnip").jump(-1), mode = { "i", "s" }, { silent = true } },
			{
				"<C-E>",
				function()
					if require("luasnip").choice_active() then
						require("luasnip").change_choice(1)
					end
				end,
				mode = { "i", "s" },
				{ silent = true },
			},
		},
		config = function()
			local ls = require("luasnip")
			ls.filetype_extend("javascript", { "jsdoc" })
		end,
	},
}
