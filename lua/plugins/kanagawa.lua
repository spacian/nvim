return {
	{
		"rebelot/kanagawa.nvim",
		-- enabled = not vim.g.vscode,
		enabled = false,
		priority = 1000,
		lazy = false,
		config = function()
			local kanagawa = require("kanagawa")
			kanagawa.setup({
				compile = true,
				commentStyle = {},
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = {},
				typeStyle = {},
				transparent = false,
				dimInactive = false,
				terminalColors = true,
				colors = {
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function(colors)
					return {
						["@variable.builtin"] = { italic = false },
						Visual = { bg = colors.palette.winterGreen },
						String = { italic = true },
						Boolean = { italic = true },
					}
				end,
				theme = "wave",
				background = {
					dark = "wave",
					light = "lotus",
				},
			})
			vim.cmd("colorscheme kanagawa")
			vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = "#43243B" }) -- kanagawa:winterRed
			vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#49443C" }) -- kanagawa:winterYellow
		end,
	},
}
