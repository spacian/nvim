if not vim.g.vscode then
	vim.keymap.set({ "n" }, "<leader>oF", function()
		require("remaps.nvim.jumplist").register(false)
		vim.cmd("Telescope file_browser")
	end)
end
