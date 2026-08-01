return {
  "esmuellert/codediff.nvim",
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
      vim.cmd("CodeDiff file HEAD")
    end)
  end,
}
