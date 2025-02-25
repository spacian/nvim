return {
	{
		"craftzdog/solarized-osaka.nvim",
		-- enabled = not vim.g.vscode,
        enabled = false,
		priority = 1000,
		lazy = false,
		config = function()
			require("solarized-osaka").setup({
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					functions = {},
					variables = {},
					sidebars = "dark",
					floats = "dark",
				},
				sidebars = { "qf", "help" },
				day_brightness = 0.3,
				hide_inactive_statusline = false,
				dim_inactive = false,
				lualine_bold = false,
				on_colors = function(colors) end,
				on_highlights = function(highlights, colors) end,
			})
			vim.cmd("colorscheme solarized-osaka")
		end,
	},
}
