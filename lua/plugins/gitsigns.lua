return {
	{
		"lewis6991/gitsigns.nvim",
		enabled = not vim.g.vscode,
		lazy = false,
		config = function()
			local sign = "▕"
			local signs = {
				add = { text = sign },
				change = { text = sign },
				changedelete = { text = sign },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				untracked = { text = sign },
			}
			require("gitsigns").setup({
				sign_priority = 0,
				signs = signs,
				signs_staged = signs,
				signs_staged_enable = true,
				attach_to_untracked = true,
				signcolumn = true,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "]g", function()
						gitsigns.nav_hunk("next")
					end)

					map("n", "[g", function()
						gitsigns.nav_hunk("prev")
					end)
					map("n", "<leader>gt", gitsigns.toggle_deleted)
					map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
					map({ "o", "x" }, "ag", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
}
