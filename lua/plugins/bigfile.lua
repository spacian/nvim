return {
	{
		"LunarVim/bigfile.nvim",
		enabled = true,
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
