return {
  {
    "Aasim-A/scrollEOF.nvim",
    enabled = true,
    config = function()
      local scrolloff = 3
      vim.o.scrolloff = scrolloff
      require("scrollEOF").setup()
      vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew" }, {
        callback = function()
          vim.wo.scrolloff = scrolloff
        end,
      })
    end,
  },
}
