return {
  {
    "kylechui/nvim-surround",
    enabled = true,
    lazy = false,
    config = function()
      require("nvim-surround").setup()
      vim.keymap.set("v", "S", "<Plug>(nvim-surround-visual)")
    end,
  },
}
