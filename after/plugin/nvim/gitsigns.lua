if not vim.g.vscode then
	require("gitsigns").setup({
		sign_priority = 0,
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "┃" },
			untracked = { text = "?" },
		},
		signs_staged = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "┃" },
			untracked = { text = "?" },
		},
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

			-- Navigation
			map("n", "]g", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]g", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end)

			map("n", "[g", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[g", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end)

			-- Actions
			map("n", "<leader>gd", gitsigns.diffthis)
			map("n", "<leader>gt", gitsigns.toggle_deleted)

			-- Text object
			map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
			map({ "o", "x" }, "ag", ":<C-U>Gitsigns select_hunk<CR>")
		end,
	})
end
