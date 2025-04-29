return {
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = true,
		priority = 1000,
		enabled = not vim.g.vscode,
		config = function()
			vim.cmd("colorscheme kanagawa-paper-ink")
			local colors = require("kanagawa-paper.colors").setup().palette
			vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = colors.winterRed })
			vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = colors.winterYellow })
		end,
	},
}
