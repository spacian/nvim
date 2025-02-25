return {
	{
		"nvim-treesitter/nvim-treesitter",
        enabled = true,
        lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"csv",
					"go",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"powershell",
					"python",
					"toml",
					"regex",
					"vimdoc",
					"xml",
					"yaml",
				},
				highlight = {
					enable = not vim.g.vscode,
					additional_vim_regex_highlighting = false,
					disable = { "latex" },
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						node_incremental = "v",
						node_decremental = "V",
					},
				},
			})
		end,
	},
}
