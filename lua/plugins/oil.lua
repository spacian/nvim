return {
	{
		"stevearc/oil.nvim",
		enabled = not vim.g.vscode,
		opts = {
			keymaps = {
				["<enter>"] = "actions.select",
				["<c-p>"] = "actions.preview",
				["-"] = "actions.parent",
				["<leader>r"] = "actions.refresh",
				["<esc>"] = { "actions.close", mode = "n" },
				["q"] = { "actions.close", mode = "n" },
			},
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
			},
		},
	},
}
