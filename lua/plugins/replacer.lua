return {
	{
		"gabrielpoca/replacer.nvim",
		enabled = not vim.g.vscode,
		config = function()
			require("replacer").setup({ rename_files = false })
			vim.keymap.set("n", "<leader>m", function()
				if vim.bo.buftype == "quickfix" then
					require("replacer").run()
				else
					print("replacer: Not a quickfix buffer.")
				end
			end, { silent = true })
		end,
	},
}
