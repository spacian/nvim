vim.api.nvim_create_user_command("CleanupBuffers", function()
	if BufIsSpecial() then
		print("cannot cleanup buffers from special buffer")
	else
		local view = vim.fn.winsaveview()
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			vim.diagnostic.reset(nil, bufnr)
		end
		vim.cmd("%bd!|e#")
		vim.fn.winrestview(view)
	end
end, {})

vim.keymap.set({ "n" }, "<c-s>", ":w<enter>", { noremap = true })

vim.keymap.set({ "t" }, "<c-n>", [[<c-\><c-n>]], { noremap = true })

vim.keymap.set({ "", "l", "t" }, "<a-h>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>h]], true, false, true), "n", true)
end, { noremap = true })

vim.keymap.set({ "", "l", "t" }, "<a-j>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>j]], true, false, true), "n", true)
end, { noremap = true })

vim.keymap.set({ "", "l", "t" }, "<a-k>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>k]], true, false, true), "n", true)
end, { noremap = true })

vim.keymap.set({ "", "l", "t" }, "<a-l>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>l]], true, false, true), "n", true)
end, { noremap = true })

vim.keymap.set({ "", "l", "t" }, "<c-a-h>", function()
	if vim.fn.winnr("$") == 1 then
		vim.cmd("vsplit | b#")
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>h]], true, false, true), "n", true)
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>H]], true, false, true), "n", true)
	end
end, { noremap = true })

vim.keymap.set({ "", "l", "t" }, "<c-a-j>", function()
	if vim.fn.winnr("$") == 1 then
		vim.cmd("split | b#")
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>j]], true, false, true), "n", true)
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>J]], true, false, true), "n", true)
	end
end, { noremap = true })

vim.keymap.set({ "", "l", "t" }, "<c-a-k>", function()
	if vim.fn.winnr("$") == 1 then
		vim.cmd("split | b# | wincmd x")
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>K]], true, false, true), "n", true)
	end
end, { noremap = true })

vim.keymap.set({ "", "l", "t" }, "<c-a-l>", function()
	if vim.fn.winnr("$") == 1 then
		vim.cmd("vsplit | b# | wincmd x")
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<c-\><c-n><c-w>L]], true, false, true), "n", true)
	end
end, { noremap = true })
