return {
	{
		"gbprod/substitute.nvim",
		config = function()
			local substitute = require("substitute")
			substitute.setup({
				highlight_substituted_text = {
					enabled = false,
				},
			})
			vim.keymap.set("n", "S", substitute.operator, { noremap = true })
		end,
	},
}
