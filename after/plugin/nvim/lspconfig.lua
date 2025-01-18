if not vim.g.vscode then
	require("mason").setup()
	require("mason-tool-installer").setup({
		ensure_installed = {
			"cspell",
			-- "pyright",
			"basedpyright",
			"gopls",
			"lua_ls",
			"jsonls",
			"stylua",
		},
	})
	local null_ls = require("null-ls")
	null_ls.setup({
		fallback_severity = vim.diagnostic.severity.HINT,
		sources = {
			require("cspell").diagnostics,
			null_ls.builtins.formatting.stylua,
		},
	})
	local lspconfig = require("lspconfig")
	lspconfig.basedpyright.setup({
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = "strict",
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
					diagnosticSeverityOverrides = {
						reportUnboundVariable = "error",
						reportMissingModuleSource = "error",
					},
				},
			},
		},
	})
	-- lspconfig.pyright.setup({
	--     settings = {
	--         pyright = {
	--             disableOrganizeImports = true,
	--         },
	--         python = {
	--             analysis = {
	--                 typeCheckingMode = "strict",
	--                 autoSearchPaths = true,
	--                 useLibraryCodeForTypes = true,
	--                 diagnosticMode = "workspace",
	--                 diagnosticSeverityOverrides = {
	--                     reportUnboundVariable = "error",
	--                     reportMissingModuleSource = "error",
	--                 },
	--             }
	--         }
	--     }
	-- })
	lspconfig.gopls.setup({})
	lspconfig.jsonls.setup({
		settings = {
			json = {
				validate = { enable = true },
			},
		},
	})
	lspconfig.lua_ls.setup({
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = { vim.env.VIMRUNTIME },
				},
			})
		end,
		settings = {
			Lua = {
				format = { enable = false },
			},
		},
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
			-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
			-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
			-- vim.keymap.set('n', '<space>wl', function()
			--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			-- end, opts)
		end,
	})
end
