return {
  {
    "chrisgrieser/nvim-spider",
    enabled = false,
    lazy = false,
    config = function()
      require("spider").setup({
        customPatterns = { "[%wÜÄÖüäöß_]+" },
        overrideDefault = true,
      })
      vim.keymap.set({ "n", "v" }, "w", function()
        require("spider").motion(
          "w",
          { customPatterns = { "[%wÜÄÖüäöß_]+", ".$" } }
        )
      end)
      vim.keymap.set({ "n", "v" }, "e", function()
        require("spider").motion(
          "e",
          { customPatterns = { "[%wÜÄÖüäöß_]+", ".$" } }
        )
      end)
      vim.keymap.set({ "n", "v" }, "b", function()
        require("spider").motion(
          "b",
          { customPatterns = { "[%wÜÄÖüäöß_]+", "^." } }
        )
      end)
      vim.keymap.set({ "n", "v" }, "ge", function()
        require("spider").motion(
          "ge",
          { customPatterns = { "[%wÜÄÖüäöß_]+", "^." } }
        )
      end)
    end,
  },
}
