return {
	{
		"davidmh/cspell.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
		},
		enabled = not vim.g.vscode,
	},
}
