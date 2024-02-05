return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {

		{ "n", "<leader>pf", require("telescope.builtin").find_files, {} },
		{ "n", "<C-p>", require("telescope.builtin").git_files, {} },
		{
			"n",
			"<leader>pws",
			function()
				local word = vim.fn.expand("<cword>")
				require("telescope.builtin").grep_string({ search = word })
			end,
		},
		{
			"n",
			"<leader>pWs",
			function()
				local word = vim.fn.expand("<cWORD>")
				require("telescope.builtin").grep_string({ search = word })
			end,
		},
		{
			"n",
			"<leader>ps",
			function()
				require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
			end,
		},
		{ "n", "<leader>vh", require("telescope.builtin").help_tags, {} },
	},
	config = true,
}
