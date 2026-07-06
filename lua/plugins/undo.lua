return {
  "SunnyTamang/select-undo.nvim",
  config = function()
    require("select-undo").setup({ mapping = false })
    vim.keymap.set("x", "u", ":'<,'>SelectUndoPartial<enter>gv")
  end,
}
