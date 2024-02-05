return {
	{
		"folke/trouble.nvim",
		keys = {

			{ "n", "<leader>tt", require("trouble").toggle(), desc = "Toggle trouble" },
			{
				"n",
				"[t",
				require("trouble").next({ skip_groups = true, jump = true }),
				desc = "Trouble next",
			},
			{
				"n",
				"]t",
				require("trouble").previous({ skip_groups = true, jump = true }),
				desc = "Trouble previous",
			},
		},
		opts = {
			icons = true,
		},
	},
}
