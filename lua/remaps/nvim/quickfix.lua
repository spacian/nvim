vim.keymap.set("n", "<leader>qq", function()
	vim.cmd("cexpr []")
	vim.diagnostic.setqflist({ open = true })
end)
vim.keymap.set("n", "<leader>qfd", function()
	local qf = vim.fn.getqflist()
	local filtered = {}
	local filter_by = vim.fn.input("filter qflist by description: ")
	for _, item in ipairs(qf) do
		if item.text:match(filter_by) then
			table.insert(filtered, item)
		end
	end
	vim.fn.setqflist(filtered)
end)
vim.keymap.set("n", "<leader>qft", function()
	local qf = vim.fn.getqflist()
	local filtered = {}
	local filter_by = vim.fn.input("filter qflist by type (E/W/I/N): ", "E")
	for _, item in ipairs(qf) do
		if item.type:match(filter_by) then
			table.insert(filtered, item)
		end
	end
	vim.fn.setqflist(filtered)
end)
vim.keymap.set("n", "<leader>qff", function()
	local qf = vim.fn.getqflist()
	local filtered = {}
	local filter_by = vim.fn.input("filter qflist by file: ")
	for _, item in ipairs(qf) do
		local bufnr = tonumber(item.bufnr)
		if bufnr ~= nil and vim.api.nvim_buf_get_name(bufnr):match(filter_by) then
			table.insert(filtered, item)
		end
	end
	vim.fn.setqflist(filtered)
end)
