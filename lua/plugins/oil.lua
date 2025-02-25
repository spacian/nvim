return {
	{
		"stevearc/oil.nvim",
		enabled = not vim.g.vscode,
        lazy = false,
		config = function()
			local jumplist = require("remaps.nvim.jumplist")
			local oil = require("oil")
			oil.setup({
				keymaps = {
					["<enter>"] = { "actions.select", mode = "n" },
					["<c-p>"] = { "actions.preview", mode = "n" },
					["<c-h>"] = { "actions.toggle_hidden", mode = "n" },
					["-"] = { "actions.parent", mode = "n" },
					["<leader>r"] = { "actions.refresh", mode = "n" },
					["<esc>"] = { "actions.close", mode = "n" },
					["q"] = { "actions.close", mode = "n" },
				},
				use_default_keymaps = false,
				view_options = {
					show_hidden = false,
					is_hidden_file = function(name, bufnr)
						local m = name:match("^%.") or name:match("__pycache__")
						return m ~= nil and name ~= ".." and name ~= ".gitignore"
					end,
				},
			})

			vim.keymap.set("n", "<leader>oe", function()
				local bufname = vim.api.nvim_buf_get_name(0)
				if bufname == "" then
					jumplist.register(1)
					vim.cmd("silent Oil .")
				elseif BufIsSpecial() then
					return
				end
				jumplist.register(1)
				local file = vim.fn.expand("%:t")
				oil.open(vim.fn.expand("%:h"), {}, function()
					vim.cmd("silent! call search('\\V' . escape('" .. file .. "', '\\') , 'w')")
				end)
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
		end,
	},
}
