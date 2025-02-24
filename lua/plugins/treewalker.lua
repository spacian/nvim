return {
	{
		"aaronik/treewalker.nvim",
		enabled = true,
		after = "nvim-treesitter",
		config = function()
			local tw = require("treewalker")
			tw.setup({ highlight = false })
			vim.keymap.set("n", "<c-j>", function()
				tw.move_down()
				vim.api.nvim_feedkeys("zz", "n", true)
			end, { noremap = true })
			vim.keymap.set("n", "<c-k>", function()
				tw.move_up()
				vim.api.nvim_feedkeys("zz", "n", true)
			end, { noremap = true })
			vim.keymap.set("n", "<c-h>", function()
				tw.move_out()
				vim.api.nvim_feedkeys("zz", "n", true)
			end, { noremap = true })
			vim.keymap.set("n", "<c-l>", function()
				tw.move_in()
				vim.api.nvim_feedkeys("zz", "n", true)
			end, { noremap = true })
		end,
	},
}
