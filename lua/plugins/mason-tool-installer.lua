return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    after = { "mason", "nvim-treesitter" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "basedpyright",
          "black",
          "codebook",
          "gopls",
          "isort",
          "jsonls",
          "lemminx",
          "lua_ls",
          "stylua",
          "taplo",
          "tree-sitter-cli",
          "yaml-language-server",
        },
      })
    end,
  },
}
