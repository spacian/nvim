return {
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = not vim.g.vscode,
    main = "ibl",
    lazy = false,
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
        },
        scope = {
          enabled = false,
        },
        viewport_buffer = {
          min = 1000,
        },
      })
    end,
  },
}
