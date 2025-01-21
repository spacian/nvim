vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*.py",
	callback = function()
		vim.cmd("silent !isort %:p")
		vim.cmd("silent !black %:p")
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "!.py",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_clients({ bufnr = bufnr })

		for _, client in ipairs(clients) do
			if client.supports_method("textDocument/formatting") then
				vim.lsp.buf.format({
					async = false,
					bufnr = bufnr,
				})
				return
			end
		end
	end,
})
