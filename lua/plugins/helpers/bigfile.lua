return {
  {
    "LunarVim/bigfile.nvim",
    lazy = false,
    opts = {
      features = {
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        -- "matchparen",
        "vimopts",
        "filetype",
      },
    },
    event = "BufReadPre",
  },
}
