vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.diagnostic.show()
  end,
})
