if not vim.g.vscode then
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
		local bufname = vim.fn.expand("%")
		if bufname ~= "" then
			vim.cmd("silent Oil %:h")
		else
			vim.cmd("silent Oil .")
		end
	end, { noremap = true })
	-- vim.keymap.set("n", "<leader>oD", function()
	-- 	vim.cmd("silent e " .. vim.fn.getcwd())
	-- end, { noremap = true })
	vim.keymap.set("n", "<leader>cd", function()
		local cwd = oil.get_current_dir()
		if cwd ~= nil then
			vim.cmd("cd " .. cwd)
		else
			vim.cmd("cd %:p:h")
		end
		print("new working directory: " .. vim.fn.getcwd())
	end, { noremap = true })
end
