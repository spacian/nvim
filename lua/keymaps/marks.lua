vim.keymap.set("n", "M", function()
  local c = vim.fn.getcharstr()
  if c:match("%l") then
    c = c:upper()
  end
  print("marked " .. c)
  vim.cmd("normal! m" .. c)
end, {})

vim.keymap.set("n", "m", function()
  local c = vim.fn.getcharstr()
  if c:match("%l") then
    c = c:upper()
  end
  local ok, pos = pcall(vim.api.nvim_get_mark, c, {})
  if ok and pos[1] ~= 0 then
    Jumplist.register()
    vim.cmd("normal! `" .. c .. "zz")
    print("jumped " .. c)
  else
    vim.notify("E20: Mark " .. c .. " not set", vim.log.levels.ERROR)
  end
end, {})
