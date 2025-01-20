if not vim.g.vscode then
	local persisted = require("persisted")
	persisted.setup({
		autosave = false,
		silent = true,
		ignored_dirs = { "oil://", "replacer://" },
	})
	vim.keymap.set({ "n" }, "<leader>so", function()
		local buffer_name = vim.api.nvim_buf_get_name(0)
		if string.find(buffer_name, "^oil://") ~= nil or string.find(buffer_name, "^replacer://") ~= nil then
			print("cannot open new session from this buffer")
			return
		end
		vim.cmd("Telescope persisted")
	end)
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = function()
			vim.cmd("Telescope persisted")
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "PersistedTelescopeLoadPre",
		callback = function(_)
			if vim.api.nvim_buf_get_name(0) ~= "" then
				vim.cmd("%bd!|e#")
			end
			require("persisted").save({ session = vim.g.persisted_loaded_session })
			vim.cmd("%bd!")
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "PersistedStart",
		callback = function(_)
			vim.cmd("clearjumps")
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_get_name(buf):match("^oil://") ~= nil then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end,
	})
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			local buffer_name = vim.api.nvim_buf_get_name(0)
			if
				not (vim.bo.buftype == "quickfix")
				and not (vim.bo.buftype == "terminal")
				and string.find(buffer_name, "^oil://") == nil
				and string.find(buffer_name, "^replacer://") == nil
			then
				persisted.save({ force = true })
			end
		end,
	})
end
