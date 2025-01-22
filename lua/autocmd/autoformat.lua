vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*.py",
	callback = function()
		vim.cmd("silent !isort %:p")
		vim.cmd("silent !black %:p")
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if vim.bo.buftype == "python" or BufIsSpecial(bufname) then
		return
		end
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		for _, client in ipairs(clients) do
			if client.supports_method("textDocument/formatting") then
				vim.lsp.buf.format({ async = false })
				break
			end
		end
		if not vim.bo.readonly and vim.bo.modifiable and vim.bo.modified then
			local save_cursor = vim.fn.getpos(".")
			pcall(function()
				vim.cmd([[%s/\s\+$//e]])
			end)
			vim.fn.setpos(".", save_cursor)
		end
	end,
})
