return {
	{
		"folke/snacks.nvim",
		enabled = not vim.g.vscode,
		lazy = false,
		config = function()
			local jumplist = require("remaps.nvim.jumplist")
			local snacks = require("snacks")
			snacks.setup({
				picker = {
					layout = {
						fullscreen = true,
						cycle = true,
						preset = function()
							return "default"
						end,
					},
					explorer = {
						include = { "build" },
					},
					win = {
						preview = {
							wo = {
								signcolumn = "no",
								number = false,
								statuscolumn = "",
							},
						},
						input = {
							keys = {
								["<a-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
								["<a-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
							},
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>of", function()
				jumplist.register(1)
				snacks.picker.smart({
					multi = { "recent", "files" },
					watch = true,
					hidden = true,
					filter = { cwd = true },
				})
			end)

			vim.keymap.set("n", "<leader>ob", function()
				jumplist.register(1)
				snacks.picker.buffers()
			end)

			vim.keymap.set("n", "<leader>ff", function()
				jumplist.register(1)
				snacks.picker.grep()
			end)

			vim.keymap.set("n", "<leader>fw", function()
				jumplist.register(1)
				snacks.picker.grep_word()
			end)

			vim.keymap.set("n", "gr", function()
				jumplist.register(1)
				snacks.picker.lsp_references()
			end)

			vim.keymap.set("n", "gd", function()
				jumplist.register(1)
				snacks.picker.lsp_definitions()
			end)

			vim.keymap.set("n", "gD", function()
				jumplist.register(1)
				snacks.picker.lsp_type_definitions()
			end)

			vim.keymap.set("n", "<leader>oR", function()
				jumplist.register(1)
				snacks.picker.recent()
			end)

			vim.keymap.set("n", "<leader>or", function()
				jumplist.register(1)
				snacks.picker.resume()
			end)

			vim.keymap.set("n", "<leader>oq", function()
				jumplist.register(1)
				snacks.picker.qflist()
			end)

			vim.keymap.set("n", "<leader>od", function()
				jumplist.register(1)
				snacks.picker.diagnostics()
			end)

			vim.keymap.set("n", "<leader>og", function()
				jumplist.register(1)
				snacks.picker.git_diff()
			end)

			-- vim.keymap.set("n", "<leader>os", function()
			-- 	jumplist.register(1)
			-- 	snacks.picker.lsp_symbols()
			-- end)
		end,
	},
}
