vim.lsp.config("yamlls", {
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = false
  end,
  settings = { yaml = { validate = { enable = true } } },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
