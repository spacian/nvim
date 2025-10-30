return {
  "ggandor/leap.nvim",
  enabled = true,
  lazy = false,
  config = function()
    local jumplist = require("remaps.nvim.jumplist")
    require("leap").setup({
      safe_labels = "fmtunqzFMTUNQZ",
      equivalence_classes = {
        " \t\r\n",
        "'\"`",
        "aä",
        "oö",
        "uü",
        "sß",
      },
    })
    vim.keymap.set({ "n" }, "gj", function()
      jumplist.register(1)
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Plug>(leap-forward)", true, true, true),
        "m",
        false
      )
    end)
    vim.keymap.set({ "n" }, "gk", function()
      jumplist.register(1)
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Plug>(leap-backward)", true, true, true),
        "m",
        false
      )
    end)
  end,
}
