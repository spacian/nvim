if not vim.g.vscode then
	require("mason").setup()
	require("mason-tool-installer").setup({
		ensure_installed = {
			"cspell",
			"basedpyright",
			"gopls",
			"lua_ls",
			"jsonls",
			"stylua",
			"taplo",
			"yaml-language-server",
			"lemminx",
		},
	})

	local null_ls = require("null-ls")
	null_ls.register({ sources = { null_ls.builtins.formatting.stylua } })

	local capabilities = require("blink.cmp").get_lsp_capabilities()

	vim.lsp.config("lua_ls", {
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
		capabilities = capabilities,
	})

	vim.lsp.config("basedpyright", {
		on_init = function(client, _)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.semanticTokensProvider = false
			local root = vim.fn.getcwd()
			client.config.settings.basedpyright.analysis.extraPaths = { root }
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end,
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = "strict",
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					autoImportCompletions = true,
					diagnosticMode = "workspace",
					diagnosticSeverityOverrides = {
						reportUnboundVariable = "error",
						reportMissingModuleSource = "error",
						reportUnusedVariable = "warning",
						reportUnusedFunction = "warning",
						reportUnusedImport = "warning",
					},
				},
			},
		},
		capabilities = capabilities,
	})

	vim.lsp.config("jsonls", {
		on_init = function(client)
			client.server_capabilities.semanticTokensProvider = false
		end,
		settings = { json = { validate = { enable = true } } },
		capabilities = capabilities,
	})

	vim.lsp.config("gopls", {
		on_init = function(client)
			client.server_capabilities.semanticTokensProvider = false
		end,
		capabilities = capabilities,
	})

	vim.lsp.config("taplo", {
		on_init = function(client)
			client.server_capabilities.semanticTokensProvider = false
		end,
		settings = { toml = { validate = { enable = true } } },
		capabilities = capabilities,
	})

	vim.lsp.config("yamlls", {
		on_init = function(client)
			client.server_capabilities.semanticTokensProvider = false
		end,
		settings = { yaml = { validate = { enable = true } } },
		capabilities = capabilities,
	})

	vim.lsp.config("lemminx", {
		on_init = function(client)
			client.server_capabilities.semanticTokensProvider = false
		end,
		capabilities = capabilities,
	})

	require("mason-lspconfig").setup()

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
