local moves = { "n", "N", "{", "}", "(", ")" }
for i = 1, #moves do
	vim.keymap.set({ "n" }, moves[i], function()
		vim.cmd("silent keepjumps normal! " .. moves[i] .. "zz")
	end, { noremap = true })
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	callback = function()
		local jumps = vim.fn.getjumplist()[1]
		if #jumps > 0 then
			local jump = jumps[#jumps]
			local cur_bufnr = vim.api.nvim_get_current_buf()
			local cur_line = vim.fn.getpos(".")[2]
			if jump.bufnr == cur_bufnr and math.abs(jump.lnum - cur_line) < 9 then
				return
			end
		end
		vim.cmd("silent normal! m'")
	end,
})
