vim.lsp.config("gopls", {
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = false
  end,
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.lsp.enable("gopls")
