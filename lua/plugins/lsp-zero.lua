return {
	{
		"VonHeikemen/lsp-zero.nvim",
		-- enabled = not vim.g.vscode,
		enabled = false,
		lazy = false,
		branch = "v3.x",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
		},
	},
}
