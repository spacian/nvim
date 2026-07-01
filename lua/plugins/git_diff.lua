return {
  "esmuellert/codediff.nvim",
  enabled = not vim.g.vscode,
  config = function()
    require("codediff").setup({
      diff = {
        layout = "inline",
      },
      explorer = {
        hidden = true,
        initial_focus = "original",
      },
    })

    vim.keymap.set("n", "<leader>gd", function()
      vim.cmd("CodeDiff HEAD")
    end)
  end,
}
