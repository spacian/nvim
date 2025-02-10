return {
	{
		"olimorris/persisted.nvim",
		lazy = false,
		opts = {
			autosave = false,
			silent = true,
			ignored_dirs = { "oil://", "replacer://" },
		},
		enabled = not vim.g.vscode,
	},
}
