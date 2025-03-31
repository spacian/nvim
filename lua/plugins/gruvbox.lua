return {
	{
		"ellisonleao/gruvbox.nvim",
		enabled = not vim.g.vscode,
		priority = 1000,
		lazy = true,
		config = function()
			vim.cmd("colorscheme gruvbox")
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {
					["@boolean"] = {
						fg = vim.api.nvim_get_hl(0, { name = "@number", link = false }).fg,
						italic = true,
					},
					["@variable.builtin.python"] = {
						fg = vim.api.nvim_get_hl(0, { name = "@keyword.import", link = false }).fg,
					},
					["@constant.builtin"] = {
						fg = vim.api.nvim_get_hl(0, { name = "@constant.builtin", link = false }).fg,
						italic = true,
					},
					["@function.builtin"] = {
						fg = vim.api.nvim_get_hl(0, { name = "@function.builtin", link = false }).fg,
						italic = true,
					},
					["@keyword.return"] = {
						fg = vim.api.nvim_get_hl(0, { name = "@keyword", link = false }).fg,
						italic = true,
					},
				},
				dim_inactive = false,
				transparent_mode = false,
			})

			vim.cmd("colorscheme gruvbox")
			vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = require("gruvbox").palette.dark_aqua })
			vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = require("gruvbox").palette.dark_red })
			vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = require("gruvbox").palette.dark2 })
			vim.api.nvim_set_hl(0, "SignColumn", { link = "Normal" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = vim.api.nvim_get_hl(0, { name = "CursorLineNr" }).fg })
		end,
	},
}
