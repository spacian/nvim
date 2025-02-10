return {
	{
		"lukas-reineke/indent-blankline.nvim",
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
		enabled = not vim.g.vscode,
	},
}
