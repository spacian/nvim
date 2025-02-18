return {
	{
		"nvim-lualine/lualine.nvim",
		enabled = not vim.g.vscode,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local function telescope_smart_path()
				if BufIsSpecial() then
					return ""
				end
				local filepath = vim.fn.expand("%:p")
				local home = vim.fn.getcwd():lower():gsub("\\", "/")
				if filepath:sub(1, #home):lower():gsub("\\", "/") == home then
					filepath = "~" .. filepath:sub(#home + 1):gsub("\\", "/")
				end
				return filepath
			end
			local function parent()
				return vim.fn.getcwd():match("^.+[/\\](.+)$")
			end
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
						{ parent },
					},
					lualine_x = {
						{ telescope_smart_path },
						{ "location" },
					},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
