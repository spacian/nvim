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
		local mode_name = mode_map[mode] or "NORMAL  "
		return string.format("%-7s", mode_name)
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
		dir = dir:match(".*/(.+)$") or special()
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

	local colors = require("gruvbox").palette
	local config = {
		a = { bg = colors.dark_red_hard, fg = colors.black, gui = "bold" },
		b = { bg = colors.dark2, fg = colors.white },
		c = { bg = colors.dark1, fg = colors.gray },
	}
	local theme = {
		normal = config,
		insert = config,
		visual = config,
		replace = config,
		command = config,
		inactive = config,
	}
	require("lualine").setup({
		options = {
			theme = theme,
			globalstatus = true,
			component_separators = "",
			always_divide_middle = false,
		},
		sections = {
			lualine_a = { fixed_mode },
			lualine_b = { { "diagnostics", sections = { "error" } } },
			lualine_c = { { "diagnostics", sections = { "warn", "info", "hint" } } },
			lualine_x = { project },
			lualine_y = { "filename" },
			lualine_z = {},
		},
	})
end
