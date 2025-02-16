return {
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = not vim.g.vscode,
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
			},
			scope = {
				enabled = false,
				show_end = true,
				show_start = false,
			},
		},
	},
}
