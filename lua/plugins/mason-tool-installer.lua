return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    after = { "mason", "nvim-treesitter", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "basedpyright",
          "black",
          "codebook",
          "gopls",
          "isort",
          "json-lsp",
          "lemminx",
          "lua-language-server",
          "stylua",
          "taplo",
          "tree-sitter-cli",
          "yaml-language-server",
        },
      })
    end,
  },
}
