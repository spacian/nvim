vim.lsp.config("basedpyright", {
  on_init = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.semanticTokensProvider = false
  end,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "recommended",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        diagnosticMode = "workspace",
        extraPaths = { "./src" },
        venvPath = { "." },
        venv = { ".venv" },
        exclude = { ".venv" },
        diagnosticSeverityOverrides = {
          reportUnboundVariable = "error",
          reportMissingModuleSource = "error",
          reportUnusedVariable = "warning",
          reportUnusedFunction = "warning",
          reportUnusedImport = "warning",
          reportUnusedParameter = "warning",
          reportUnusedCallResult = "hint",
        },
      },
    },
  },
  init_options = { disablePullDiagnostics = true },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.lsp.enable("basedpyright")
