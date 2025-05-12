return {
	{
		"lervag/vimtex",
		init = function() end,
		lazy = false,
		enabled = not vim.g.vscode,
	},
	-- {
	-- 	"micangl/cmp-vimtex",
	-- 	lazy = false,
	-- 	enabled = not vim.g.vscode,
	-- 	dependencies = {
	-- 		{ "saghen/blink.compat", version = "*", lazy = true, opts = {} },
	-- 	},
	-- },
}
