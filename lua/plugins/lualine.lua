return {
	{
		"nvim-lualine/lualine.nvim",
		enabled = not vim.g.vscode,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local indicator_symbol = "●"
			local function diagnostic(level)
				if (vim.diagnostic.count(0)[level] or 0) > 0 then
					return indicator_symbol
				else
					-- return "◌"
					return "○"
				end
			end
			local function error_ind()
				return diagnostic(vim.diagnostic.severity.ERROR)
			end
			local function warn_ind()
				return diagnostic(vim.diagnostic.severity.WARN)
			end
			local function info_ind()
				return diagnostic(vim.diagnostic.severity.INFO)
			end
			local function note_ind()
				return diagnostic(vim.diagnostic.severity.HINT)
			end
			local theme = require("lualine.themes.auto")
			theme.insert.c = theme.normal.c
			theme.visual.c = theme.normal.c
			theme.replace.c = theme.normal.c
			theme.command = theme.normal
			theme.terminal = theme.command
			theme.inactive = theme.normal
			require("lualine").setup({
				options = {
					theme = theme,
					globalstatus = true,
					component_separators = "",
					always_divide_middle = false,
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{ error_ind, color = { fg = "#FF0000" } },
						{ warn_ind, color = { fg = "#FFAA00" } },
						{ info_ind, color = { fg = "#229922" } },
						{ note_ind, color = { fg = "#005599" } },
					},
					lualine_x = {
						{ "filename", path = 4, file_status = false },
						{ "location" },
					},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
