return {
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		enabled = not vim.g.vscode,
		config = function()
			vim.keymap.set({ "n" }, "<leader>oF", function()
				require("remaps.nvim.jumplist").register(1)
				vim.cmd("Telescope file_browser")
			end)
		end,
	},
}
