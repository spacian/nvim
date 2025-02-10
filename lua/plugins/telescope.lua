return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		opts = {
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
							require("telescope.actions").select_default(prompt_bufnr)
							vim.cmd("normal! zz")
						end,
					},
					n = {
						["<enter>"] = function(prompt_bufnr)
							require("telescope.actions").select_default(prompt_bufnr)
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
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		enabled = not vim.g.vscode,
	},
}
