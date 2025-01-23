if not vim.g.vscode then
	local lsp_zero = require("lsp-zero")
	lsp_zero.on_attach(function(_, bufnr)
		lsp_zero.default_keymaps({ buffer = bufnr })
	end)
	local cmp = require("cmp")
	local compare = require("cmp.config.compare")
	local cmp_format = require("lsp-zero").cmp_format({ details = true })
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
				compare.recently_used,
				compare.offset,
				compare.exact,
				compare.score,
				compare.kind,
				compare.sort_text,
				compare.length,
				compare.order,
			},
		},
	})
end
