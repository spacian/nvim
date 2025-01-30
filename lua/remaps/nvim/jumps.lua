local jumplist = require("remaps.nvim.jumplist")
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		vim.schedule(function()
			local bufname = vim.api.nvim_buf_get_name(0)
			if BufIsSpecial(bufname) then
				return
			end
			jumplist.register(2)
		end)
	end,
})

vim.keymap.set({ "n" }, "<leader>jd", jumplist.delete)
