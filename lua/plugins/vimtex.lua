return {
	{
		"lervag/vimtex",
		init = function() end,
		enabled = not vim.g.vscode,
	},
	{
		"micangl/cmp-vimtex",
		enabled = not vim.g.vscode,
	},
}
