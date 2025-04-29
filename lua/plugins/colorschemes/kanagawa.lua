return {
	{
		"rebelot/kanagawa.nvim",
		enabled = not vim.g.vscode,
		priority = 1000,
		lazy = true,
		config = function()
			local kanagawa = require("kanagawa")
			kanagawa.setup({
				commentStyle = {},
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = {},
				typeStyle = {},
				transparent = false,
				dimInactive = false,
				terminalColors = false,
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
			require("kanagawa").load("dragon")
			vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = "#43243B" }) -- kanagawa:winterRed
			vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#49443C" }) -- kanagawa:winterYellow
		end,
	},
}
