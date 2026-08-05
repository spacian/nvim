return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    after = { "mason", "arborist", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "basedpyright",
          "black",
          "cspell",
          "gopls",
          "isort",
          "jq",
          "json-lsp",
          "lemminx",
          "lua-language-server",
          "prettier",
          "stylua",
          "taplo",
          "tree-sitter-cli",
          "yaml-language-server",
        },
      })
    end,
  },
}
