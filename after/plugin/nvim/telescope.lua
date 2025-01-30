if not vim.g.vscode then
	local jumplist = require("remaps.nvim.jumplist")
	local actions = require("telescope.actions")
	require("telescope").setup({
		pickers = {
			find_files = {
				hidden = true,
				file_ignore_patterns = { "^.git[/\\]", ".*__pycache__[/\\].*" },
			},
		},
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
				hidden = true,
				mappings = {},
			},
		},
	})
	require("telescope").load_extension("lazygit")
	require("telescope").load_extension("persisted")
	require("telescope").load_extension("file_browser")
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>of", function()
		jumplist.register(1)
		builtin.find_files()
	end)
	vim.keymap.set("n", "<leader>ob", function()
		jumplist.register(1)
		builtin.buffers()
	end)
	vim.keymap.set("n", "<leader>ff", function()
		jumplist.register(1)
		builtin.live_grep()
	end)
	vim.keymap.set("n", "<leader>fw", function()
		jumplist.register(1)
		builtin.grep_string()
	end)
	vim.keymap.set("n", "<leader>fp", function()
		jumplist.register(1)
		builtin.grep_string({
			search = "",
			word_match = "-w",
			shorten_path = true,
			only_sort_text = true,
		})
	end)
	vim.keymap.set("n", "gr", function()
		jumplist.register(1)
		builtin.lsp_references()
	end)
	vim.keymap.set("n", "gd", function()
		jumplist.register(1)
		builtin.lsp_definitions()
	end)
	vim.keymap.set("n", "gD", function()
		jumplist.register(1)
		builtin.lsp_type_definitions()
	end)
	vim.keymap.set("n", "<leader>oR", function()
		jumplist.register(1)
		builtin.oldfiles()
	end)
	vim.keymap.set("n", "<leader>or", function()
		jumplist.register(1)
		builtin.resume()
	end)
	vim.keymap.set("n", "<leader>oq", function()
		jumplist.register(1)
		builtin.quickfix()
	end)
	vim.keymap.set("n", "<leader>od", function()
		jumplist.register(1)
		builtin.diagnostics()
	end)
	-- vim.keymap.set("n", "<leader>oj", builtin.jumplist)
	vim.keymap.set("n", "<leader>og", function()
		jumplist.register(1)
		builtin.git_status()
	end)
end
