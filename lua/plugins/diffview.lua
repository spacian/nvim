return {
	{
		"sindrets/diffview.nvim",
		enabled = not vim.g.vscode,
        lazy = false,
		config = function()
			require("diffview").setup({})
			vim.keymap.set({ "n" }, "<leader>gG", function()
				vim.cmd("DiffviewOpen")
			end, { silent = true })
			vim.keymap.set({ "n" }, "<leader>gd", function()
				vim.cmd("DiffviewOpen")
				vim.cmd("DiffviewToggleFiles")
			end, { silent = true })
			vim.keymap.set({ "n" }, "<leader>ge", function()
				vim.cmd("DiffviewToggleFiles")
			end, { silent = true })
			vim.keymap.set({ "n" }, "<leader>go", function()
				vim.cmd("DiffviewFocusFiles")
			end, { silent = true })
			vim.keymap.set({ "n" }, "<leader>gq", function()
				vim.cmd("DiffviewClose")
			end, { silent = true })
			vim.keymap.set({ "n" }, "<leader>gh", function()
				vim.cmd("DiffviewFileHistory")
			end, { silent = true })
		end,
	},
}
