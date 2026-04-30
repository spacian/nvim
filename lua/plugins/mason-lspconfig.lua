return {
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("lsp")
    end,
  },
}
