local starts_with_underscore = function(label, n)
	return label:sub(1, n) == string.sub("__", 1, n)
end

local ends_with_equals = function(label)
	return label:sub(#label, #label) == "="
end
return {
	{
		"saghen/blink.cmp",
		enabled = not vim.g.vscode,
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		branch = "main",
		opts = {
			keymap = {
				preset = "none",
				["<c-l>"] = { "show", "accept", "fallback" },
				["<c-h>"] = { "hide", "fallback" },
				["<c-j>"] = { "select_next", "fallback" },
				["<c-k>"] = { "select_prev", "fallback" },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "buffer" },
			},
			fuzzy = {
				max_typos = function()
					return 0
				end,
				implementation = "lua",
				sorts = {
					function(a, b)
						local a_ = ends_with_equals(a.label or "")
						local b_ = ends_with_equals(b.label or "")
						if a_ ~= b_ then
							return a_
						end
						return nil
					end,
					function(a, b)
						local a_ = starts_with_underscore(a.label or "", 2)
						local b_ = starts_with_underscore(b.label or "", 2)
						if a_ ~= b_ then
							return not a_
						end
						return nil
					end,
					"score",
					"sort_text",
				},
			},
			completion = {
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 1000,
				},
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
