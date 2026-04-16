local jumplist = require("remaps.nvim.jumplist")

vim.keymap.set("n", "<leader>M", function()
  local c = vim.fn.getcharstr()
  if c:match("%l") then
    c = c:upper()
  end
  vim.cmd("normal! m" .. c)
end, {})

vim.keymap.set("n", "M", function()
  local c = vim.fn.getcharstr()
  if c:match("%l") then
    c = c:upper()
  end
  local ok, pos = pcall(vim.api.nvim_get_mark, c, {})
  if ok and pos[1] ~= 0 then
    jumplist.register(1)
    vim.cmd("normal! `" .. c .. "zz")
  else
    vim.notify("E20: Mark " .. c .. " not set", vim.log.levels.ERROR)
  end
end, {})
