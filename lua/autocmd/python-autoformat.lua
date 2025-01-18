vim.api.nvim_create_autocmd({
	"BufWritePost",
}, {
	pattern = "*.py",
	callback = function()
		vim.cmd("silent !isort %:p")
		vim.cmd("silent !black %:p")
	end,
})
vim.api.nvim_create_autocmd({
	"BufWritePost",
}, {
	pattern = "*.lua",
	callback = function()
		vim.lsp.buf.format()
	end,
})
