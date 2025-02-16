if not vim.g.vscode then
	-- this is what fixes the weird hover bug in python
	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	-- vim.lsp.handlers["textDocument/signatureHelp"] =
	-- 	vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	local lsp_zero = require("lsp-zero")
	lsp_zero.on_attach(function(_, bufnr)
		lsp_zero.default_keymaps({ buffer = bufnr })
	end)
	local cmp = require("cmp")
	local compare = require("cmp.config.compare")
	local cmp_format = require("lsp-zero").cmp_format({ details = true })
	local starts_with_underscore = function(label, n)
		return label:sub(1, n) == string.sub("__", 1, n)
	end
	local ends_on_equals = function(label)
		return string.match(label, "=$") == "="
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
		},
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		sorting = {
			comparators = {
				function(a, b)
					local a_enum = a.completion_item.kind == cmp.lsp.CompletionItemKind.EnumMember
					local b_enum = b.completion_item.kind == cmp.lsp.CompletionItemKind.EnumMember
					if a_enum ~= b_enum then
						return a_enum
					end
					return nil
				end,
				function(a, b)
					local a_ = ends_on_equals(a.completion_item.label or "")
					local b_ = ends_on_equals(b.completion_item.label or "")
					if a_ ~= b_ then
						return a_
					end
					return nil
				end,
				function(a, b)
					local a_ = starts_with_underscore(a.completion_item.label or "", 2)
					local b_ = starts_with_underscore(b.completion_item.label or "", 2)
					if a_ ~= b_ then
						return not a_
					end
					return nil
				end,
				function(a, b)
					local a_ = starts_with_underscore(a.completion_item.label or "", 1)
					local b_ = starts_with_underscore(b.completion_item.label or "", 1)
					if a_ ~= b_ then
						return not a_
					end
					return nil
				end,
				compare.offset,
				compare.exact,
				compare.score,
				compare.recently_used,
				compare.kind,
				compare.sort_text,
				compare.length,
				compare.order,
			},
		},
	})
end
