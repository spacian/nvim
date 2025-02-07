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
	local cspell_last_session = ""
	local force_cspell_reload = false
	vim.api.nvim_create_user_command("CSpellReload", function()
		if BufIsSpecial() then
			print("cannot reload from special buffer")
			return
		end
		force_cspell_reload = true
		vim.cmd("noa w|e")
	end, {})
	null_ls.setup({
		fallback_severity = vim.diagnostic.severity.HINT,
		sources = {
			require("cspell").diagnostics.with({
				config = {
					cspell_import_files = function(_)
						return { vim.fn.expand("$APPDATA") .. "/npm/node_modules/@cspell/dict-de-de/cspell-ext.json" }
					end,
					cwd = function(_)
						return vim.fn.getcwd()
					end,
					reset_cspell = function(params)
						if
							params ~= nil
							and params.cwd ~= nil
							and (vim.v.this_session ~= cspell_last_session or force_cspell_reload)
						then
							cspell_last_session = vim.v.this_session
							force_cspell_reload = false
							return true
						else
							return false
						end
					end,
				},
			}),
		},
	})
	require("mason-lspconfig").setup_handlers({
		basedpyright = function()
			lspconfig.basedpyright.setup({
				on_init = function(client, _)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.semanticTokensProvider = false
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
			lspconfig.jsonls.setup({
				on_init = function(client)
					client.server_capabilities.semanticTokensProvider = false
				end,
				settings = { json = { validate = { enable = true } } },
			})
		end,
		gopls = function()
			lspconfig.gopls.setup({
				on_init = function(client)
					client.server_capabilities.semanticTokensProvider = false
				end,
			})
		end,
		taplo = function()
			lspconfig.taplo.setup({
				on_init = function(client)
					client.server_capabilities.semanticTokensProvider = false
				end,
				settings = { toml = { validate = { enable = true } } },
			})
		end,
		yamlls = function()
			lspconfig.yamlls.setup({
				on_init = function(client)
					client.server_capabilities.semanticTokensProvider = false
				end,
				settings = { yaml = { validate = { enable = true } } },
			})
		end,
		lua_ls = function()
			null_ls.register({ sources = { null_ls.builtins.formatting.stylua } })
			lspconfig.lua_ls.setup({
				on_init = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.semanticTokensProvider = false
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
