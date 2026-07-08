return {
  {
    "mcauley-penney/visual-whitespace.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    opts = {
      fileformat_chars = {
        unix = "",
        mac = "",
        dos = "",
      },
    },
  },
}
