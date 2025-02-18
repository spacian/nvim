return {
	"ggandor/leap.nvim",
	enabled = true,
	lazy = false,
	config = function()
		require("leap").opts.equivalence_classes = {
			" \t\r\n",
			"([{",
			")]}",
			"'\"`",
			"aäàáâãā",
			"dḍ",
			"eëéèêē",
			"gǧğ",
			"hḥḫ",
			"iïīíìîı",
			"nñ",
			"oō",
			"sṣšß",
			"tṭ",
			"uúûüűū",
			"zẓ",
		}
		vim.keymap.set({ "n" }, "S", "<Plug>(leap-forward)")
		vim.keymap.set({ "n" }, "X", "<Plug>(leap-backward)")
	end,
}
