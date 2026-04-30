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
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
