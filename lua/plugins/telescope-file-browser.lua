return {
	{
		"nvim-telescope/telescope-file-browser.nvim",
		enabled = not vim.g.vscode,
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set({ "n" }, "<leader>oF", function()
				require("remaps.nvim.jumplist").register(1)
				vim.cmd("Telescope file_browser")
			end)
		end,
	},
}
