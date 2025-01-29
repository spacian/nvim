if not vim.g.vscode then
	local persisted = require("persisted")
	persisted.setup({
		autosave = false,
		silent = true,
		ignored_dirs = { "oil://", "replacer://" },
	})
	vim.keymap.set({ "n" }, "<leader>oP", function()
		local buffer_name = vim.api.nvim_buf_get_name(0)
		if not buffer_name == "" and BufIsSpecial() then
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
			require("persisted").save({ session = vim.g.persisted_loaded_session })
			vim.cmd("silent %bd!")
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "PersistedStart",
		callback = function(_)
			require("remaps.nvim.jumplist").reset()
			vim.cmd("clearjumps")
		end,
	})
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			vim.cmd("set nohls")
			if not BufIsSpecial() then
				vim.schedule(function()
					persisted.save({ force = true })
				end)
			end
		end,
	})
end
