return {
	{
		"chrisgrieser/nvim-spider",
		config = function()
			require("spider").setup({ skipInsignificantPunctuation = true, subwordMovement = false })
			vim.keymap.set({ "n", "v" }, "w", "<cmd>lua require('spider').motion('w')<enter>")
			vim.keymap.set({ "n", "v" }, "e", "<cmd>lua require('spider').motion('e')<enter>")
			vim.keymap.set({ "n", "v" }, "b", "<cmd>lua require('spider').motion('b')<enter>")
			vim.keymap.set({ "n", "v" }, "ge", "<cmd>lua require('spider').motion('ge')<enter>")
		end,
	},
}
