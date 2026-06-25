return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup({
      max_lines = 2,
      trim_scope = "inner",
      mode = "topline",
      separator = "-",
    })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = MergeHL("Normal").bg })
    vim.api.nvim_set_hl(
      0,
      "TreesitterContextSeparator",
      MergeHL("TreesitterContextSeparator", { bg = MergeHL("Normal").bg })
    )
  end,
}
