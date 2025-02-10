return {
	{
		"spacian/autoclose.nvim",
		opts = {
			keys = {
				["`"] = { escape = false, close = false, pair = "``" },
				["'"] = { escape = false, close = false, pair = "''" },
				['"'] = { escape = false, close = false, pair = '""' },
				["<"] = { escape = false, close = false, pair = "<>" },
				[">"] = { escape = false, close = false, pair = "<>" },
			},
			options = {
				disabled_filetypes = { "text", "markdown" },
				disable_when_touch = true,
				touch_regex = ".",
				touch_regex_exceptions = "[})%]]",
			},
			auto_indent = false,
		},
		enabled = not vim.g.vscode,
	},
}
