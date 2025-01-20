return {
	{
		"spacian/cspell.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
		},
		branch = "dev",
		enabled = not vim.g.vscode,
	},
}
