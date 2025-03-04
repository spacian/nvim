return {
	"ggandor/leap.nvim",
	enabled = true,
	lazy = false,
	config = function()
		require("leap").opts.equivalence_classes = {
			" \t\r\n",
			"'\"`",
			"aä",
			"oö",
			"uü",
			"sß",
		}
		vim.keymap.set({ "n" }, "gj", "<Plug>(leap-forward)")
		vim.keymap.set({ "n" }, "gk", "<Plug>(leap-backward)")
	end,
}
