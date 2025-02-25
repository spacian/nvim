return {
	{
		"EdenEast/nightfox.nvim",
		-- enabled = not vim.g.vscode,
        enabled = false,
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd("colorscheme nightfox")
		end,
	},
}
