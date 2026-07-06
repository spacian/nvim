vim.api.nvim_create_autocmd({ "BufEnter", "InsertEnter" }, {
  callback = function()
    vim.api.nvim_echo({ { "" } }, false, {})
  end,
})
