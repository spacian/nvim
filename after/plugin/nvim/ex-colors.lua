if not vim.g.vscode then
	require("ex-colors").setup({
		-- included_patterns = require("ex-colors.presets").recommended.included_patterns + { "^GitSigns%u" },
		included_patterns = { "." },
	})
end
