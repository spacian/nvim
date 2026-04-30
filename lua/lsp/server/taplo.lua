vim.lsp.config("taplo", {
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = false
  end,
  settings = { toml = { validate = { enable = true } } },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
