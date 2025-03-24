return {
	{
		"EdenEast/nightfox.nvim",
		enabled = not vim.g.vscode,
		priority = 1000,
		lazy = true,
		config = function()
			vim.cmd("colorscheme nightfox")
		end,
	},
}
