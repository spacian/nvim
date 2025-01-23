if not vim.g.vscode then
	local fb_actions = require("telescope").extensions.file_browser.actions
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
				mappings = {
					["i"] = {
						["<a-n>"] = fb_actions.create,
						["<a-c>"] = false,
					},
				},
			},
		},
	})
	require("telescope").load_extension("lazygit")
	require("telescope").load_extension("persisted")
	require("telescope").load_extension("file_browser")
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>of", builtin.find_files)
	vim.keymap.set("n", "<leader>ob", builtin.buffers)
	vim.keymap.set("n", "<leader>ff", builtin.live_grep)
	vim.keymap.set("n", "<leader>fp", function()
		builtin.grep_string({
			search = "",
			word_match = "-w",
			shorten_path = true,
			only_sort_text = true,
		})
	end)
	vim.keymap.set("n", "gr", builtin.lsp_references)
	vim.keymap.set("n", "gd", builtin.lsp_definitions)
	vim.keymap.set("n", "gD", builtin.lsp_type_definitions)
	vim.keymap.set("n", "<leader>or", builtin.oldfiles)
	vim.keymap.set("n", "<leader>R", builtin.resume)
	vim.keymap.set("n", "<leader>oq", builtin.quickfix)
	vim.keymap.set("n", "<leader>od", builtin.diagnostics)
end
