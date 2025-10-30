return {
  "dimtion/guttermarks.nvim",
  config = function()
    require("guttermarks").setup({
      local_mark = { enabled = true },
      global_mark = { enabled = true },
      special_mark = { enabled = false },
    })
  end,
}
