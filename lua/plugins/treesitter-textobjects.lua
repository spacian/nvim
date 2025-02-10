return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		after = "nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["ai"] = "@statement.outer",
							["ah"] = "@assignment.lhs",
							["al"] = "@assignment.rhs",
							["as"] = "@assignment.outer",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ak"] = "@comment.outer",
							["ik"] = "@comment.inner",
							["ad"] = {
								query = "@string.documentation",
								query_group = "highlights",
							},
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
						selection_modes = {
							--   ['@parameter.outer'] = 'v', -- charwise
							["@class.inner"] = "V", -- linewise
							["@class.outer"] = "V", -- linewise
							["@function.outer"] = "V", -- linewise
							["@function.inner"] = "V", -- linewise
							["@block.outer"] = "V", -- linewise
							["@block.inner"] = "V", -- linewise
							--   ['@class.outer'] = '<c-v>', -- blockwise
						},
						include_surrounding_whitespace = false,
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>mna"] = "@parameter.inner",
							["<leader>mnf"] = "@function.outer",
							["<leader>mnc"] = "@class.outer",
						},
						swap_previous = {
							["<leader>mpa"] = "@parameter.inner",
							["<leader>mpf"] = "@function.outer",
							["<leader>mpc"] = "@class.outer",
						},
					},
					move = {
						enable = true,
						set_jumps = false,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]a"] = "@parameter.inner",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]A"] = "@parameter.inner",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[a"] = "@parameter.inner",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[A"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
}
