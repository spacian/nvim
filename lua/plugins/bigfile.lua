return {
	{
		"LunarVim/bigfile.nvim",
		enabled = not vim.g.vscode,
		opts = {
			features = {
				"indent_blankline",
				"illuminate",
				"lsp",
				"treesitter",
				"syntax",
				-- "matchparen",
				"vimopts",
				"filetype",
			},
		},
		event = "BufReadPre",
	},
}
