return {
	{
		"olimorris/persisted.nvim",
		lazy = false,
		enabled = not vim.g.vscode,
		config = function()
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
					if vim.api.nvim_buf_get_name(0) == "" then
						vim.cmd("Telescope persisted")
					end
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistedTelescopeLoadPre",
				callback = function(_)
					persisted.save({ session = vim.g.persisted_loaded_session })
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if not vim.bo[bufnr] == "terminal" then
							vim.cmd("silent bd " .. bufnr)
						end
					end
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
		end,
	},
}
