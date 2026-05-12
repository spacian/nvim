vim.lsp.config("jsonls", {
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = false
  end,
  settings = { json = { validate = { enable = true } } },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.lsp.enable("jsonls")
