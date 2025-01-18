if not vim.g.vscode then
	vim.keymap.set({ "n" }, "<leader>oF", function()
		vim.cmd("Telescope file_browser")
	end)
end
