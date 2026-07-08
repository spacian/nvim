return {
  "williamboman/mason.nvim",
  enabled = not vim.g.vscode,
  config = function()
    require("mason").setup()
  end,
}
