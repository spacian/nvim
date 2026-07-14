return {
  "yorickpeterse/nvim-jump",
  config = function()
    require("jump").setup({
      label = "IncSearch",
      labels = "jkfdumrvhgytnblsiecowxpqaz",
    })

    local jumplist = require("remaps.nvim.jumplist")

    vim.keymap.set({ "n", "x", "o" }, "<leader>j", function()
      jumplist.register()
      require("jump").start()
    end, {})
  end,
}
