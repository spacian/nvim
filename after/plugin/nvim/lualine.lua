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

	local function special()
		local filepath = vim.fn.expand("%:p")
		if BufIsSpecial(filepath) then
			filepath = filepath:match("(.*)://") or filepath:match("neo%-tree") or ""
			return filepath
		end
		return ""
	end
	local function project()
		local dir = vim.fn.getcwd()
		dir = dir:gsub("\\", "/")
		dir = dir:match(".*/(.+)$") or ""
		return dir
	end
	local function telescope_smart_path()
		local filepath = vim.fn.expand("%:p")
		if BufIsSpecial(filepath) then
			return ""
		end
		local home = vim.fn.getcwd()

		if filepath:sub(1, #home) == home then
			filepath = filepath:sub(#home + 1)
		end
		local cwd = vim.fn.getcwd()
		cwd = cwd:gsub("\\", "/")
		cwd = cwd:match(".*/(.+)$") or cwd
		filepath = cwd .. filepath

		local max_len = 50
		local tail = 30
		if #filepath > max_len then
			local start = filepath:sub(1, max_len - tail - 3)
			local mid = "..."
			local end_part = filepath:sub(-tail)
			filepath = start .. mid .. end_part
		end

		return filepath:gsub("\\", "/")
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
