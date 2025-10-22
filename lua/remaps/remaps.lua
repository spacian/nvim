vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<leader><leader>", "", { noremap = true })
vim.keymap.set({ "v" }, "p", '"_dP', { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y$', { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-t>", "", { noremap = true })
vim.keymap.set({ "n" }, "J", function()
	local pos = vim.fn.getpos(".")
	vim.fn.feedkeys("J", "n")
	vim.schedule(function()
		vim.fn.setpos(".", pos)
	end)
end, { noremap = true })
vim.keymap.set({ "n", "v" }, "H", "^", { noremap = true })
vim.keymap.set({ "n", "v" }, "L", "$", { noremap = true })
vim.keymap.set({ "n" }, "yall", ":%y<enter>", { noremap = true })
vim.keymap.set({ "n" }, "<leader>yall", ":%y+<enter>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-d>", "10j", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-u>", "10k", { noremap = true })
vim.keymap.set({ "n" }, "<leader>o", "", { noremap = true })
vim.keymap.set({ "n" }, "gwip", function()
	vim.o.textwidth = 88
	vim.api.nvim_feedkeys("gwip0", "n", false)
	vim.o.textwidth = 0
end, { noremap = true })
vim.keymap.set({ "n" }, "gwl", function()
	vim.o.textwidth = 88
	vim.api.nvim_feedkeys("gwl0", "n", false)
	vim.o.textwidth = 0
end, { noremap = true })
vim.keymap.set({ "x" }, "gw", function()
	vim.o.textwidth = 88
	vim.api.nvim_feedkeys("gw0", "n", false)
	vim.o.textwidth = 0
end, { noremap = true })
