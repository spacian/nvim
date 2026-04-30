if not vim.g.vscode then
  require("lsp.server.basedpyright")
  require("lsp.server.codebook")
  require("lsp.server.gopls")
  require("lsp.server.jsonls")
  require("lsp.server.lemminx")
  require("lsp.server.lua")
  require("lsp.server.taplo")
  require("lsp.server.yamlls")

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    end,
  })
end
