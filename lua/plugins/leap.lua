return {
	"ggandor/leap.nvim",
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
		vim.keymap.set({ "n" }, "<leader>h", "<Plug>(leap-forward)")
		vim.keymap.set({ "n" }, "<leader>H", "<Plug>(leap-backward)")
	end,
}
