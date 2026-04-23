if not vim.g.vscode then
  require("mason").setup()
  require("mason-tool-installer").setup({
    ensure_installed = {
      "basedpyright",
      "black",
      "codebook",
      "gopls",
      "isort",
      "jsonls",
      "lemminx",
      "lua_ls",
      "stylua",
      "taplo",
      "tree-sitter-cli",
      "yaml-language-server",
    },
  })

  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("codebook", { init_options = { diagnosticSeverity = "hint" } })

  vim.lsp.config("lua_ls", {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.semanticTokensProvider = false
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          vim.loop.fs_stat(path .. "/.luarc.json")
          or vim.loop.fs_stat(path .. "/.luarc.jsonc")
        then
          return
        end
      end
      client.config.settings.Lua =
        vim.tbl_deep_extend("force", client.config.settings.Lua, {
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
      client:notify(
        "workspace/didChangeConfiguration",
        { settings = client.config.settings }
      )
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
            reportUnusedParameter = "warning",
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

  require("mason-lspconfig").setup({
    automatic_enable = {
      exclude = { "stylua" },
    },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    end,
  })
end
