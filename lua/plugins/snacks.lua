return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				layout = { fullscreen = true },
			},
		},
		enabled = not vim.g.vscode,
	},
}
