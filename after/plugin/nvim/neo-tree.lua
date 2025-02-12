if not vim.g.vscode then
	local jumplist = require("remaps.nvim.jumplist")
	vim.keymap.set({ "n" }, "<leader>oE", function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname == "" or not BufIsSpecial() then
			jumplist.register(1)
			require("neo-tree.command").execute({
				action = "focus",
				position = "current",
				source = "filesystem",
				dir = vim.fn.getcwd(),
				reveal = true,
			})
		end
	end)
end
