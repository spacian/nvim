local letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #letters do
	vim.keymap.set({ "n" }, "M" .. letters:sub(i, i):upper(), "m" .. letters:sub(i, i), { noremap = true })
	vim.keymap.set({ "n" }, "m" .. letters:sub(i, i):upper(), "`" .. letters:sub(i, i), { noremap = true })
	vim.keymap.set({ "n" }, "M" .. letters:sub(i, i), "m" .. letters:sub(i, i):upper(), { noremap = true })
	vim.keymap.set({ "n" }, "m" .. letters:sub(i, i), "`" .. letters:sub(i, i):upper(), { noremap = true })
end
