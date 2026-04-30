return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsUpdateCompleted",
      callback = function()
        require("lsp")
      end,
    })
  end,
}
