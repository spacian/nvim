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
          "json-lsp",
          "jq",
          "lemminx",
          "lua-language-server",
          "prettier",
          "stylua",
          "taplo",
          "tree-sitter-cli",
          "xmlformatter",
          "yaml-language-server",
        },
      })
    end,
  },
}
