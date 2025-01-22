if not vim.g.vscode then
	local persisted = require("persisted")
	persisted.setup({
		autosave = false,
		silent = true,
		ignored_dirs = { "oil://", "replacer://" },
	})
	vim.keymap.set({ "n" }, "<leader>oP", function()
		local buffer_name = vim.api.nvim_buf_get_name(0)
		if not buffer_name == '' and BufIsSpecial(buffer_name) then
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
		end,
	})
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			local buffer_name = vim.api.nvim_buf_get_name(0)
			if not BufIsSpecial(buffer_name) then
				persisted.save({ force = true })
			end
		end,
	})
end
