return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		enabled = not vim.g.vscode,
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
					SignColumn = { bg = require("gruvbox").palette.dark0_hard },
					ColorColumn = { bg = require("gruvbox").palette.dark0_hard },
				},
				dim_inactive = false,
				transparent_mode = false,
			})

			-- vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = require("gruvbox").palette.dark_aqua_hard })
			-- vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = require("gruvbox").palette.dark_red_hard })
			-- vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = require("gruvbox").palette.dark1 })

			vim.cmd("colorscheme gruvbox")
			vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = require("gruvbox").palette.dark_aqua })
			vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = require("gruvbox").palette.dark_red })
			vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = require("gruvbox").palette.dark2 })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = require("gruvbox").palette.dark0 })
			vim.api.nvim_set_hl(0, "ColorColumn", { bg = require("gruvbox").palette.dark0 })
		end,
	},
}
