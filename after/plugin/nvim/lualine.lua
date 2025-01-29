if not vim.g.vscode then
	local function fixed_mode()
		local mode_map = {
			n = "NORMAL",
			i = "INSERT",
			v = "VISUAL",
			V = "V-LINE",
			[""] = "V-BLOCK",
			c = "COMMAND",
			R = "REPLACE",
			t = "TERMINAL",
		}
		local mode = vim.api.nvim_get_mode().mode
		local mode_name = mode_map[mode] or "NORMAL"
		return string.format("%-8s", mode_name)
	end

	local function project()
		local dir = vim.fn.getcwd()
		dir = dir:gsub("\\", "/")
		dir = dir:match(".*/(.+)$") or ""
		return dir
	end

	local theme = require("lualine.themes.auto")
	theme.insert.c = theme.normal.c
	theme.visual.c = theme.normal.c
	theme.replace.c = theme.normal.c
	theme.command.c = theme.normal.c
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
			lualine_a = { fixed_mode },
			lualine_b = { project },
			lualine_c = { { "diff", colored = false }, { "filename", path = 1 } },
			lualine_x = { { "diagnostics" } },
			lualine_y = {},
			lualine_z = { {} },
		},
	})
end
