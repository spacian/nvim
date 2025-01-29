if not vim.g.vscode then
	local jumplist = require("remaps.nvim.jumplist")
	local oil = require("oil")
	oil.setup({
		keymaps = {
			["<enter>"] = "actions.select",
			["<c-p>"] = "actions.preview",
			["-"] = "actions.parent",
			["<leader>r"] = "actions.refresh",
			["<esc>"] = { "actions.close", mode = "n" },
			["q"] = { "actions.close", mode = "n" },
		},
		use_default_keymaps = false,
		view_options = {
			show_hidden = true,
		},
	})

	vim.keymap.set("n", "<leader>oe", function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname == "" then
			jumplist.register(false)
			vim.cmd("silent Oil .")
		elseif BufIsSpecial() then
			return
		end
		jumplist.register(false)
		vim.cmd("silent Oil %:h")
	end, { noremap = true })

	vim.api.nvim_create_user_command("CD", function()
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
