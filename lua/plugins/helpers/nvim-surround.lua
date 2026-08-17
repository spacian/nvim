return {
  {
    "kylechui/nvim-surround",
    enabled = true,
    lazy = false,
    config = function()
      require("nvim-surround").setup()
      vim.keymap.set("x", "S", "<Plug>(nvim-surround-visual)")
    end,
  },
}
