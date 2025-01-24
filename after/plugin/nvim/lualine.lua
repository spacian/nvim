if not vim.g.vscode then
	local function special()
		local filepath = vim.fn.expand("%:p")
		if BufIsSpecial(filepath) then
			filepath = filepath:match("(.*)://") or filepath:match("neo%-tree")
			return filepath
		end
		return ""
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
	require("lualine").setup({
		sections = {
			lualine_a = { special },
			lualine_b = { "branch", "diff" },
			lualine_c = { "diagnostics" },
			lualine_x = { "searchcount" },
			lualine_y = { telescope_smart_path },
			lualine_z = {},
		},
	})
end
