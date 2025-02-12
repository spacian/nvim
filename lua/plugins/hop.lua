return {
	{
		"smoka7/hop.nvim",
		enabled = false,
		config = function()
			local hop = require("hop")
			hop.setup({ keys = "kdslaeiowcpnbtyhgruvmfj" })
			vim.keymap.set({ "n", "v" }, "<leader>hc", function()
				hop.hint_char1()
			end)
			vim.keymap.set({ "n", "v" }, "<leader>hd", function()
				hop.hint_char2()
			end)
			vim.keymap.set({ "n", "v" }, "<leader>hw", function()
				hop.hint_words()
			end)
			vim.keymap.set({ "n", "v" }, "<leader>hl", function()
				hop.hint_lines_skip_whitespace()
			end)
		end,
	},
}
