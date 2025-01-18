require("substitute").setup({
	highlight_substituted_text = {
		enabled = false,
	},
})
vim.keymap.set("n", "<leader>s", require("substitute").operator, { noremap = true })
vim.keymap.set("n", "<leader>S", require("substitute").eol, { noremap = true })
vim.keymap.set("n", "<leader>ss", require("substitute").line, { noremap = true })
vim.keymap.set("x", "<leader>s", require("substitute").visual, { noremap = true })
