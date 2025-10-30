return {
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
}
