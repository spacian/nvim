if not vim.g.vscode then
	local jumplist = require("remaps.nvim.jumplist")
	local oil = require("oil")

	vim.keymap.set("n", "<leader>oE", function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname == "" then
			jumplist.register(1)
			vim.cmd("silent Oil .")
		elseif BufIsSpecial() then
			return
		end
		jumplist.register(1)
		vim.cmd("silent Oil %:h")
	end, { noremap = true })

	vim.api.nvim_create_user_command("Cd", function()
		local cwd = oil.get_current_dir()
		if cwd ~= nil then
			vim.cmd("cd " .. cwd)
		elseif not BufIsSpecial() then
			vim.cmd("cd %:p:h")
		else
			return
		end
		print("new working directory: " .. vim.fn.getcwd())
	end, {})
end
