return {
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = not vim.g.vscode,
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = {
					-- char = "▏",
					-- char = "▎",
					-- char = "▍",
					-- char = "▌",
					-- char = "▋",
					-- char = "▊",
					-- char = "▉",
					-- char = "█",
					char = "│",
					-- char = "┃",
					-- char = "▕",
					-- char = "▐",
					-- char = "╎",
					-- char = "╏",
					-- char = "┆",
					-- char = "┇",
					-- char = "┊",
					-- char = "┋",
					-- char = "║",
				},
				scope = {
					enabled = false,
				},
			})
		end,
	},
}
