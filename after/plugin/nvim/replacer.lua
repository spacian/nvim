if not vim.g.vscode then
	vim.keymap.set("n", "<leader>m", function()
		if vim.bo.buftype == "quickfix" then
			require("replacer").run()
		else
			print("replacer: Not a quickfix buffer.")
		end
	end, { silent = true })
end
