if not vim.g.vscode then
	require("kanagawa").setup({
		commentStyle = { italic = false },
		functionStyle = {},
		keywordStyle = { italic = false },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = false,
		dimInactive = false,
		terminalColors = true,
		colors = {
			palette = {},
			theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
		},
		overrides = function(colors)
			return {
				["@variable.builtin"] = { italic = false },
				-- Visual = { bg = colors.palette.lotusOrange },
				-- Visual = { bg = colors.palette.lotusRed },
				-- Visual = { bg = colors.palette.oniViolet },
				-- Visual = { bg = colors.palette.lotusRed3 },
				Visual = { bg = colors.palette.lotusViolet4 },
			}
		end,
		theme = "wave",
		background = {
			dark = "wave",
			light = "lotus",
		},
	})

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

	require("catppuccin").setup({
		flavour = "mocha",
		background = {
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false,
		show_end_of_buffer = false,
		term_colors = true,
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.15,
		},
		no_italic = true,
		no_bold = true,
		no_underline = false,
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		color_overrides = {},
		custom_highlights = {},
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = false,
			mini = {
				enabled = true,
				indentscope_color = "",
			},
		},
	})

	require("rose-pine").setup({
		variant = "auto",
		dark_variant = "main",
		dim_inactive_windows = false,
		extend_background_behind_borders = true,
		enable = {
			terminal = true,
			legacy_highlights = true,
			migrations = true,
		},
		styles = {
			bold = false,
			italic = false,
			transparency = false,
		},
		groups = {
			border = "muted",
			link = "iris",
			panel = "surface",
			error = "love",
			hint = "iris",
			info = "foam",
			note = "pine",
			todo = "rose",
			warn = "gold",
			git_add = "foam",
			git_change = "rose",
			git_delete = "love",
			git_dirty = "rose",
			git_ignore = "muted",
			git_merge = "iris",
			git_rename = "pine",
			git_stage = "iris",
			git_text = "rose",
			git_untracked = "subtle",
			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
		highlight_groups = {},
		before_highlight = function(group, highlight, palette) end,
	})

	require("nightfox").setup()

	vim.cmd("colorscheme kanagawa")
end
