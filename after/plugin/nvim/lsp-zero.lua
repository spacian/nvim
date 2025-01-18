if not vim.g.vscode then
	local lsp_zero = require("lsp-zero")
	lsp_zero.on_attach(function(_, bufnr)
		lsp_zero.default_keymaps({ buffer = bufnr })
	end)
	local cmp = require("cmp")
	local types = require("cmp.types")
	local compare = require("cmp.config.compare")
	local disallowed = { types.lsp.CompletionItemKind.Text }
	local cmp_format = require("lsp-zero").cmp_format({
		details = true,
		format = function(_, vim_item)
			if vim.tbl_contains(disallowed, vim_item.kind) then
				return nil
			end
			return vim_item
		end,
	})
	local modified_priority = {
		[types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
		[types.lsp.CompletionItemKind.Snippet] = 0,
		[types.lsp.CompletionItemKind.Keyword] = 0,
		[types.lsp.CompletionItemKind.Text] = 100,
	}
	local function modified_kind(kind)
		return modified_priority[kind] or kind
	end
	cmp.setup({
		preselect = cmp.PreselectMode.Item,
		formatting = cmp_format,
		mapping = {
			["<c-l>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.confirm({ select = true })
				else
					cmp.complete()
				end
			end),
			["<c-h>"] = cmp.mapping.abort(),
			["<c-k>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
			["<c-j>"] = cmp.mapping.select_next_item({ behavior = "select" }),
			["<c-u>"] = cmp.mapping.scroll_docs(-4),
			["<c-d>"] = cmp.mapping.scroll_docs(4),
		},
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		sorting = {
			comparators = {
				compare.offset,
				compare.exact,
				function(entry1, entry2)
					local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
					local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
					if len1 ~= len2 then
						return len1 - len2 < 0
					end
				end,
				compare.recently_used,
				function(entry1, entry2)
					local kind1 = modified_kind(entry1:get_kind())
					local kind2 = modified_kind(entry2:get_kind())
					if kind1 ~= kind2 then
						return kind1 - kind2 < 0
					end
				end,
				function(entry1, entry2)
					local t1 = entry1.completion_item.sortText
					local t2 = entry2.completion_item.sortText
					if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
						return t1 < t2
					end
				end,
				compare.score,
				compare.order,
			},
		},
	})
end
