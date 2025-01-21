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
			"taplo",
			"yaml-language-server",
		},
	})
	local lspconfig = require("lspconfig")
	local null_ls = require("null-ls")
	null_ls.setup({
		fallback_severity = vim.diagnostic.severity.HINT,
		sources = {
			require("cspell").diagnostics.with({
				config = {
					reload_on_cwd_change = true,
					cspell_import_files = {
						vim.fn.expand("$APPDATA") .. "/npm/node_modules/@cspell/dict-de-de/cspell-ext.json",
					},
				},
			}),
		},
	})
	require("mason-lspconfig").setup_handlers({
		basedpyright = function()
			lspconfig.basedpyright.setup({
				on_init = function(client, _)
					if client.name == "basedpyright" then
						client.server_capabilities.documentFormattingProvider = false
					end
				end,
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
		end,
		-- pyright = function()
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
		-- end,
		jsonls = function()
			lspconfig.jsonls.setup({ settings = { json = { validate = { enable = true } } } })
		end,
		gopls = function()
			lspconfig.gopls.setup({})
		end,
		taplo = function()
			lspconfig.taplo.setup({ settings = { toml = { validate = { enable = true } } } })
		end,
		yamlls = function()
			lspconfig.yamlls.setup({ settings = { yaml = { validate = { enable = true } } } })
		end,
		lua_ls = function()
			null_ls.register({ sources = { null_ls.builtins.formatting.stylua } })
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
		end,
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
