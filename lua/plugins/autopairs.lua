return {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup({
      ignored_next_char = [=[[^%)^%}^%]]]=],
    })
  end,
}
