return {
  {
    "chrisgrieser/nvim-spider",
    enabled = true,
    lazy = false,
    config = function()
      require("spider").setup({
        customPatterns = { "[%wÜÄÖüäöß_]+" },
        overrideDefault = true,
      })
      vim.keymap.set({ "n", "v" }, "w", function()
        require("spider").motion("w")
      end)
      vim.keymap.set({ "n", "v" }, "e", function()
        require("spider").motion("e")
      end)
      vim.keymap.set({ "n", "v" }, "b", function()
        require("spider").motion("b")
      end)
      vim.keymap.set({ "n", "v" }, "ge", function()
        require("spider").motion("ge")
      end)
    end,
  },
}
