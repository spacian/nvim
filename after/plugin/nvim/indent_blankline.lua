if not vim.g.vscode then
	require("ibl").setup({
		indent = {
			char = "▏",
		},
		scope = {
			enabled = false,
			show_end = true,
			show_start = false,
		},
	})
end
