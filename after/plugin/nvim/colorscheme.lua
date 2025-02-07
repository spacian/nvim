if not vim.g.vscode then
	require("vague").setup({
		style = {
			boolean = "italic",
		},
		plugins = {
			lsp = {
				diagnostic_info = "none",
			},
		},
	})
	vim.cmd("colorscheme vague")
	vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = "#3B1F29" })
	-- vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#3B311F" })
	vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#2E2A1F" })
	local colors = require("vague.config.internal").current.colors
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = colors.comment })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = colors.hint })
	vim.api.nvim_set_hl(
		0,
		"DiagnosticUnderlineHint",
		{ cterm = { underline = true }, sp = colors.comment, underline = true }
	)
	vim.api.nvim_set_hl(
		0,
		"DiagnosticUnderlineInfo",
		{ cterm = { underline = true }, sp = colors.hint, underline = true }
	)
	vim.api.nvim_set_hl(
		0,
		"DiagnosticUnderlineWarn",
		{ cterm = { underline = true }, sp = colors.warning, underline = true }
	)
	vim.api.nvim_set_hl(
		0,
		"DiagnosticUnderlineError",
		{ cterm = { underline = true }, sp = colors.error, underline = true }
	)
	vim.api.nvim_set_hl(0, "Pmenu", { bg = "#282830", fg = "#cdcdcd" }) -- Menu background and text color
	vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3c3c46", fg = "#cdcdcd" }) -- Selected item background and text color
	vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#3c3c46" }) -- Scrollbar background
	vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#646477" }) -- Scrollbar thumb color
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282830", fg = "#cdcdcd" }) -- Background and text color
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282830", fg = "#646477" }) -- Border color
	vim.api.nvim_set_hl(0, "CmpDocumentation", { bg = "#282830", fg = "#cdcdcd" }) -- Main text
	vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { fg = "#646477" }) -- Border color
	vim.api.nvim_set_hl(0, "CmpDocumentationFunction", { fg = "#a6e3a1" }) -- Green for function name
	vim.api.nvim_set_hl(0, "CmpDocumentationParameter", { fg = "#fab387" }) -- Orange for parameters
	vim.api.nvim_set_hl(0, "CmpDocumentationType", { fg = "#89b4fa" }) -- Blue for return type
	vim.api.nvim_set_hl(0, "CmpDocumentationHint", { fg = "#9399b2", italic = true }) -- Dimmed hints
	vim.api.nvim_set_hl(0, "CmpDocumentationWarning", { fg = "#f9e2af", bold = true }) -- Yellow warnings
	vim.api.nvim_set_hl(0, "CmpDocumentationError", { fg = "#f38ba8", bold = true }) -- Red errors
	local cmp_kinds = {
		Function = "#be8c8c", -- Functions
		Method = "#be8c8c", -- Methods
		Variable = "#c7c7d4", -- Variables
		Field = "#c7c7d4", -- Fields
		Property = "#c7c7d4", -- Properties
		Class = "#bad1ce", -- Classes
		Interface = "#bad1ce", -- Interfaces
		Module = "#bad1ce", -- Modules
		Constant = "#b4b4ce", -- Constants
		String = "#deb896", -- Strings
		Number = "#d2a374", -- Numbers
		Boolean = "#d2a374", -- Booleans
		Array = "#b4b4ce", -- Arrays
		Object = "#b4b4ce", -- Objects
		Key = "#b9a3ba", -- Keys
		Keyword = "#7894ab", -- Keywords
		Snippet = "#878787", -- Snippets
		Color = "#deb896", -- Colors
		File = "#cdcdcd", -- Files
		Reference = "#b4b4ce", -- References
		Folder = "#cdcdcd", -- Folders
		Enum = "#bad1ce", -- Enums
		EnumMember = "#b4b4ce", -- Enum Members
		Struct = "#bad1ce", -- Structs
		Event = "#be8c8c", -- Events
		Operator = "#96a3b2", -- Operators
		TypeParameter = "#b4b4ce", -- Type Parameters
	}
	for kind, color in pairs(cmp_kinds) do
		vim.api.nvim_set_hl(0, "CmpItemKind" .. kind, { fg = color })
	end
	vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#cdcdcd" }) -- Normal text
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#89b4fa", bold = true }) -- Matched text
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#89b4fa", italic = true }) -- Fuzzy match
	vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7f849c", strikethrough = true }) -- Deprecated

	-- local kanagawa = require("kanagawa")
	-- kanagawa.setup({
	-- 	compile = true,
	-- 	commentStyle = {},
	-- 	functionStyle = {},
	-- 	keywordStyle = { italic = false },
	-- 	statementStyle = {},
	-- 	typeStyle = {},
	-- 	transparent = false,
	-- 	dimInactive = false,
	-- 	terminalColors = true,
	-- 	colors = {
	-- 		palette = {},
	-- 		theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	-- 	},
	-- 	overrides = function(colors)
	-- 		return {
	-- 			["@variable.builtin"] = { italic = false },
	-- 			Visual = { bg = colors.palette.winterGreen },
	-- 			String = { italic = true },
	-- 			Boolean = { italic = true },
	-- 		}
	-- 	end,
	-- 	theme = "wave",
	-- 	background = {
	-- 		dark = "wave",
	-- 		light = "lotus",
	-- 	},
	-- })

	-- require("solarized-osaka").setup({
	-- 	transparent = false,
	-- 	terminal_colors = true,
	-- 	styles = {
	-- 		comments = { italic = false },
	-- 		keywords = { italic = false },
	-- 		functions = {},
	-- 		variables = {},
	-- 		sidebars = "dark",
	-- 		floats = "dark",
	-- 	},
	-- 	sidebars = { "qf", "help" },
	-- 	day_brightness = 0.3,
	-- 	hide_inactive_statusline = false,
	-- 	dim_inactive = false,
	-- 	lualine_bold = false,
	-- 	on_colors = function(colors) end,
	-- 	on_highlights = function(highlights, colors) end,
	-- })

	-- require("catppuccin").setup({
	-- 	flavour = "mocha",
	-- 	background = {
	-- 		light = "latte",
	-- 		dark = "mocha",
	-- 	},
	-- 	transparent_background = false,
	-- 	show_end_of_buffer = false,
	-- 	term_colors = true,
	-- 	dim_inactive = {
	-- 		enabled = false,
	-- 		shade = "dark",
	-- 		percentage = 0.15,
	-- 	},
	-- 	no_italic = true,
	-- 	no_bold = true,
	-- 	no_underline = false,
	-- 	styles = {
	-- 		comments = { "italic" },
	-- 		conditionals = { "italic" },
	-- 		loops = {},
	-- 		functions = {},
	-- 		keywords = {},
	-- 		strings = {},
	-- 		variables = {},
	-- 		numbers = {},
	-- 		booleans = {},
	-- 		properties = {},
	-- 		types = {},
	-- 		operators = {},
	-- 	},
	-- 	color_overrides = {},
	-- 	custom_highlights = {},
	-- 	integrations = {
	-- 		cmp = true,
	-- 		gitsigns = true,
	-- 		nvimtree = true,
	-- 		treesitter = true,
	-- 		notify = false,
	-- 		mini = {
	-- 			enabled = true,
	-- 			indentscope_color = "",
	-- 		},
	-- 	},
	-- })

	-- require("rose-pine").setup({
	-- 	variant = "auto",
	-- 	dark_variant = "main",
	-- 	dim_inactive_windows = false,
	-- 	extend_background_behind_borders = true,
	-- 	enable = {
	-- 		terminal = true,
	-- 		legacy_highlights = true,
	-- 		migrations = true,
	-- 	},
	-- 	styles = {
	-- 		bold = false,
	-- 		italic = false,
	-- 		transparency = false,
	-- 	},
	-- 	groups = {
	-- 		border = "muted",
	-- 		link = "iris",
	-- 		panel = "surface",
	-- 		error = "love",
	-- 		hint = "iris",
	-- 		info = "foam",
	-- 		note = "pine",
	-- 		todo = "rose",
	-- 		warn = "gold",
	-- 		git_add = "foam",
	-- 		git_change = "rose",
	-- 		git_delete = "love",
	-- 		git_dirty = "rose",
	-- 		git_ignore = "muted",
	-- 		git_merge = "iris",
	-- 		git_rename = "pine",
	-- 		git_stage = "iris",
	-- 		git_text = "rose",
	-- 		git_untracked = "subtle",
	-- 		h1 = "iris",
	-- 		h2 = "foam",
	-- 		h3 = "rose",
	-- 		h4 = "gold",
	-- 		h5 = "pine",
	-- 		h6 = "foam",
	-- 	},
	-- 	highlight_groups = {},
	-- 	before_highlight = function(group, highlight, palette) end,
	-- })

	-- require("nightfox").setup()

	-- require("gruvbox").setup({
	-- 	terminal_colors = true, -- add neovim terminal colors
	-- 	undercurl = true,
	-- 	underline = true,
	-- 	bold = true,
	-- 	italic = {
	-- 		strings = true,
	-- 		emphasis = true,
	-- 		comments = true,
	-- 		operators = false,
	-- 		folds = true,
	-- 	},
	-- 	strikethrough = true,
	-- 	invert_selection = false,
	-- 	invert_signs = false,
	-- 	invert_tabline = false,
	-- 	invert_intend_guides = false,
	-- 	inverse = true, -- invert background for search, diffs, statuslines and errors
	-- 	contrast = "hard", -- can be "hard", "soft" or empty string
	-- 	palette_overrides = {},
	-- 	overrides = {
	-- 		SignColumn = { bg = require("gruvbox").palette.dark0_hard },
	-- 		ColorColumn = { bg = require("gruvbox").palette.dark0_hard },
	-- 	},
	-- 	dim_inactive = false,
	-- 	transparent_mode = false,
	-- })

	-- vim.cmd("colorscheme kanagawa")
	-- vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = "#43243B" }) -- kanagawa:winterRed
	-- vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#49443C" }) -- kanagawa:winterYellow

	-- vim.cmd("colorscheme gruvbox")
	-- vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = require("gruvbox").palette.dark_aqua_hard })
	-- vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = require("gruvbox").palette.dark_red_hard })
	-- vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = require("gruvbox").palette.dark1 })

	-- vim.cmd("colorscheme gruvbox")
	-- vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = require("gruvbox").palette.dark_aqua })
	-- vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = require("gruvbox").palette.dark_red })
	-- vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = require("gruvbox").palette.dark2 })
	-- vim.api.nvim_set_hl(0, "SignColumn", { bg = require("gruvbox").palette.dark0 })
	-- vim.api.nvim_set_hl(0, "ColorColumn", { bg = require("gruvbox").palette.dark0 })

	-- vim.cmd("colorscheme ex-gruvbox-hard")

	vim.diagnostic.config({
		virtual_text = {
			severity_sort = true,
		},
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			},
			linehl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticErrorLn",
				[vim.diagnostic.severity.WARN] = "DiagnosticWarnLn",
			},
		},
	})
end
