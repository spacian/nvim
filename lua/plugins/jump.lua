return {
  "folke/flash.nvim",
  config = function()
    local flash = require("flash")
    flash.setup({
      labels = "jkumhfdrvgytnblsiecowxpqaz",
      label = {
        style = "overlay",
        after = false,
        before = true,
        reuse = "none",
      },
      highlight = {
        backdrop = false,
        groups = {
          current = "Search",
          match = "Search",
          label = "IncSearch",
        },
      },
      prompt = {
        prefix = { { "/", "Normal" } },
      },
      modes = {
        char = {
          enabled = false,
        },
      },
    })

    vim.keymap.set({ "n", "x", "o" }, "s", function()
      Jumplist.register()
      require("flash").jump({ search = { mode = "search" } })
    end)
  end,
}
