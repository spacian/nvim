return {
	{
		"folke/snacks.nvim",
		enabled = not vim.g.vscode,
		config = function()
			local jumplist = require("remaps.nvim.jumplist")
			local snacks = require("snacks")
			snacks.setup({
				picker = {
					layout = { fullscreen = true },
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
		end,
	},
}
