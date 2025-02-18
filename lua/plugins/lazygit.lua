return {
	{
		"kdheepak/lazygit.nvim",
		enabled = not vim.g.vscode,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 1.0
			vim.keymap.set({ "n" }, "<leader>gr", function()
				require("telescope").extensions.lazygit.lazygit()
			end, { noremap = true })
			vim.keymap.set({ "n" }, "<leader>gg", function()
				vim.cmd("LazyGit")
			end)
			vim.keymap.set({ "n" }, "<leader>gl", function()
				vim.cmd("LazyGitFilter")
			end)
			vim.keymap.set({ "n" }, "<leader>gf", function()
				vim.cmd("LazyGitFilterCurrentFile")
			end)
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				callback = function()
					if not BufIsSpecial() then
						require("lazygit.utils").project_root_dir()
					end
				end,
			})
			vim.g.lazygit_floating_window_use_plenary = 0
		end,
	},
}
