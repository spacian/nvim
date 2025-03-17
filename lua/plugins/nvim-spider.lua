return {
	{
		"chrisgrieser/nvim-spider",
		enabled = true,
		lazy = false,
		config = function()
			require("spider").setup({
				customPatterns = { patterns = { "[%w_]+" }, overrideDefault = true },
			})
			vim.keymap.set({ "n", "v" }, "w", "<cmd>lua require('spider').motion('w')<enter>")
			vim.keymap.set({ "n", "v" }, "e", "<cmd>lua require('spider').motion('e')<enter>")
			vim.keymap.set({ "n", "v" }, "b", "<cmd>lua require('spider').motion('b')<enter>")
			vim.keymap.set({ "n", "v" }, "ge", "<cmd>lua require('spider').motion('ge')<enter>")
		end,
	},
}
