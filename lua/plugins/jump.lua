return {
  "yorickpeterse/nvim-jump",
  config = function()
    require("jump").setup({ label = "IncSearch", labels = "fjdkruvmghtybnsleislwoaqpz" })
    local jumplist = require("remaps.nvim.jumplist")

    vim.keymap.set({ "n", "x", "o" }, "gj", function()
      jumplist.register(1)
      require("jump").start()
    end, {})
  end,
}
