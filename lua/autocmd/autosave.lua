vim.api.nvim_create_autocmd({ "VimLeavePre", "BufLeave", "FocusLost" }, {
	callback = function()
		local buffer_name = vim.api.nvim_buf_get_name(0)
		if
			vim.bo.readonly
			or buffer_name == ""
			or vim.bo.buftype ~= ""
			or not (vim.bo.modifiable and vim.bo.modified)
			or BufIsSpecial(buffer_name)
		then
			return
		end
		vim.cmd("silent noa w")
	end,
})
