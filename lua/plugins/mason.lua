return {
	{
		enabled = not vim.g.vscode,
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		enabled = not vim.g.vscode,
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
}
