if not vim.g.vscode then
	-- local function fixed_mode()
	-- 	local mode_map = {
	-- 		n = "NORMAL",
	-- 		i = "INSERT",
	-- 		v = "VISUAL",
	-- 		V = "V-LINE",
	-- 		[""] = "V-BLOCK",
	-- 		c = "COMMAND",
	-- 		R = "REPLACE",
	-- 		t = "TERMINAL",
	-- 	}
	-- 	local mode = vim.api.nvim_get_mode().mode
	-- 	local mode_name = mode_map[mode] or "NORMAL"
	-- 	return string.format("%-8s", mode_name)
	-- end

	-- local function git()
	-- 	local gitsigns = vim.b.gitsigns_status_dict
	-- 	if gitsigns and (gitsigns.added ~= 0 or gitsigns.changed ~= 0 or gitsigns.removed ~= 0) then
	-- 		return "✦"
	-- 	end
	-- 	return " "
	-- end

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

	-- local function project()
	-- 	local dir = vim.fn.getcwd()
	-- 	dir = dir:gsub("\\", "/")
	-- 	dir = dir:match(".*/(.+)$") or ""
	-- 	return dir
	-- end

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
			lualine_x = { { "filename", path = 4, file_status = false } },
			lualine_y = {},
			lualine_z = {},
		},
	})
end
