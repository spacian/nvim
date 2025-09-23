local higher_equals = function(a, b)
	local ends_with_equals = function(label)
		return label:sub(#label, #label) == "="
	end
	local a_ = ends_with_equals(a.label or "")
	local b_ = ends_with_equals(b.label or "")
	if a_ ~= b_ then
		return a_
	end
	return nil
end

local lower_underscores = function(a, b)
	local starts_with_underscore = function(label, n)
		return label:sub(1, n) == string.sub("__", 1, n)
	end
	local a_ = starts_with_underscore(a.label or "", 2)
	local b_ = starts_with_underscore(b.label or "", 2)
	if a_ ~= b_ then
		return not a_
	end
	return nil
end

local function lower_basemodel(a, b)
	local function is_basemodel_method(label)
		return label:match("^__") or label:match("^model_")
	end
	local a_ = is_basemodel_method(a.label)
	local b_ = is_basemodel_method(b.label)
	if a_ ~= b_ then
		return not a_
	end
end

local function lower_deprecated(a, b)
	-- if a.source_id == "lsp" then
	-- 	print(vim.inspect(a))
	-- end
	local function is_deprecated(item)
		return item.completion_item and item.completion_item.deprecated or false
	end
	local a_ = is_deprecated(a)
	local b_ = is_deprecated(b)
	if a_ ~= b_ then
		return not a_
	end
end

local transform = function(_, items)
	local function is_basemodel_method(label)
		return label:match("^model_")
	end
	local starts_with_underscore = function(label, n)
		return label:sub(1, n) == string.sub("__", 1, n)
	end
	local ends_with_equals = function(label)
		return label:sub(#label, #label) == "="
	end
	for _, item in ipairs(items) do
		if item.deprecated or (item.tags and vim.tbl_contains(item.tags, 1)) then
			item.score_offset = item.score_offset - 5
		end
		if is_basemodel_method(item.label) then
			item.score_offset = item.score_offset - 1
		end
		if starts_with_underscore(item.label, 1) then
			item.score_offset = item.score_offset - 1
		end
		if starts_with_underscore(item.label, 2) then
			item.score_offset = item.score_offset - 1
		end
		if ends_with_equals(item.label) then
			item.score_offset = item.score_offset + 5
		end
	end
	return items
end

return {
	{
		"saghen/blink.cmp",
		enabled = not vim.g.vscode,
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
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
				transform_items = transform,
			},
			fuzzy = {
				sorts = {
					-- higher_equals,
					-- lower_deprecated,
					-- lower_underscores,
					-- lower_basemodel,
					"exact",
					"score",
					"sort_text",
				},
			},
			completion = {
				menu = {
					border = "single",
				},
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 1000,
					window = {
						border = "rounded",
					},
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
