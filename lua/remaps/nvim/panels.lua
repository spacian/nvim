vim.keymap.set({ "n" }, "<c-s>", ":w<enter>", { noremap = true })
vim.keymap.set({ "" }, "<c-q>", function()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == "" then
		return
	elseif bufname:match("^term://") then
		vim.cmd("bd!")
		return
	else
		vim.cmd("w|bd")
	end
end, { noremap = true })
vim.keymap.set({ "t" }, "<c-q>", [[<c-\><c-n>:bd!<enter>]], { noremap = true })
vim.keymap.set({ "t" }, "<c-n>", [[<c-\><c-n>]], { noremap = true })
vim.keymap.set({ "", "l", "t" }, "<a-h>", [[<c-\><c-n><c-w>h]], { noremap = true })
vim.keymap.set({ "", "l", "t" }, "<a-j>", [[<c-\><c-n><c-w>j]], { noremap = true })
vim.keymap.set({ "", "l", "t" }, "<a-k>", [[<c-\><c-n><c-w>k]], { noremap = true })
vim.keymap.set({ "", "l", "t" }, "<a-l>", [[<c-\><c-n><c-w>l]], { noremap = true })
vim.keymap.set({ "", "l", "t" }, "<c-a-f>", [[<c-\><c-n><c-w>T]], { noremap = true })
vim.keymap.set({ "", "l", "t" }, "<c-a-h>", [[<c-\><c-n><c-w>H]], { noremap = true })
vim.keymap.set({ "", "l", "t" }, "<c-a-j>", [[<c-\><c-n><c-w>J]], { noremap = true })
vim.keymap.set({ "", "l", "t" }, "<c-a-k>", [[<c-\><c-n><c-w>K]], { noremap = true })
vim.keymap.set({ "", "l", "t" }, "<c-a-l>", [[<c-\><c-n><c-w>L]], { noremap = true })
