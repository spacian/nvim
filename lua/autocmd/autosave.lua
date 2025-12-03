vim.api.nvim_create_autocmd({ "VimLeavePre", "BufLeave", "FocusLost" }, {
  callback = function()
    if
      vim.bo.readonly
      or not (vim.bo.modifiable and vim.bo.modified)
      or BufIsSpecial()
    then
      return
    end
    vim.cmd("silent noa w")
  end,
})

vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    vim.cmd("stopinsert")
  end,
})
