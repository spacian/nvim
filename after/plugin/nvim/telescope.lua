if not vim.g.vscode then
	local jumplist = require("remaps.nvim.jumplist")
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			layout_config = {
				horizontal = {
					preview_cutoff = 0,
					height = { padding = 0 },
					width = { padding = 0 },
				},
			},
			path_display = { "smart" },
			mappings = {
				i = {
					["<c-j>"] = require("telescope.actions").move_selection_next,
					["<c-k>"] = require("telescope.actions").move_selection_previous,
					["<enter>"] = function(prompt_bufnr)
						actions.select_default(prompt_bufnr)
						vim.cmd("normal! zz")
					end,
				},
				n = {
					["<enter>"] = function(prompt_bufnr)
						actions.select_default(prompt_bufnr)
						vim.cmd("normal! zz")
					end,
				},
			},
		},
		extensions = {
			file_browser = {
				mappings = {},
			},
		},
	})
	require("telescope").load_extension("lazygit")
	require("telescope").load_extension("persisted")
	require("telescope").load_extension("file_browser")
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>of", function()
		jumplist.register()
		builtin.find_files()
	end)
	vim.keymap.set("n", "<leader>ob", function()
		jumplist.register()
		builtin.buffers()
	end)
	vim.keymap.set("n", "<leader>ff", function()
		jumplist.register()
		builtin.live_grep()
	end)
	vim.keymap.set("n", "<leader>fw", function()
		jumplist.register()
		builtin.grep_string()
	end)
	vim.keymap.set("n", "<leader>fp", function()
		jumplist.register()
		builtin.grep_string({
			search = "",
			word_match = "-w",
			shorten_path = true,
			only_sort_text = true,
		})
	end)
	vim.keymap.set("n", "gr", function()
		jumplist.register()
		builtin.lsp_references()
	end)
	vim.keymap.set("n", "gd", function()
		jumplist.register()
		builtin.lsp_definitions()
	end)
	vim.keymap.set("n", "gD", function()
		jumplist.register()
		builtin.lsp_type_definitions()
	end)
	vim.keymap.set("n", "<leader>oR", function()
		jumplist.register()
		builtin.oldfiles()
	end)
	vim.keymap.set("n", "<leader>or", function()
		jumplist.register()
		builtin.resume()
	end)
	vim.keymap.set("n", "<leader>oq", function()
		jumplist.register()
		builtin.quickfix()
	end)
	vim.keymap.set("n", "<leader>od", function()
		jumplist.register()
		builtin.diagnostics()
	end)
	-- vim.keymap.set("n", "<leader>oj", builtin.jumplist)
	vim.keymap.set("n", "<leader>og", function()
		jumplist.register()
		builtin.git_status()
	end)
end
