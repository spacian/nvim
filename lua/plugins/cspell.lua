return {
  {
    "spacian/cspell.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
  },
}
