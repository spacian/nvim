return {
	{
		"rjshkhr/shadow.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			vim.opt.termguicolors = true
			vim.cmd.colorscheme("shadow")

			vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
				cterm = { underline = true },
				sp = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" })["fg"],
				underline = true,
			})

			vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
				cterm = { underline = true },
				sp = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })["fg"],
				underline = true,
			})

			vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
				cterm = { underline = true },
				sp = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })["fg"],
				underline = true,
			})

			vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
				cterm = { underline = true },
				sp = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })["fg"],
				underline = true,
			})

			vim.api.nvim_set_hl(0, "Visual", { bg = "#3A3A3A", fg = "none" })
			vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = "#5A1E1E", bold = true })
			vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#2E2A1E", bold = true })
			vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2F2F2F" })
			vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2F2F2F" })
		end,
		enabled = not vim.g.vscode,
	},
}
