return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set({ "n" }, "<leader>oF", function()
        require("remaps.nvim.jumplist").register()
        vim.cmd("Telescope file_browser")
      end)
    end,
  },
}
