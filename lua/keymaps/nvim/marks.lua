local jumplist = require("keymaps.nvim.jumplist")

vim.keymap.set("n", "<leader>m", function()
  local c = vim.fn.getcharstr()
  if c:match("%l") then
    c = c:upper()
  end
  vim.cmd("normal! m" .. c)
end, {})

vim.keymap.set("n", "m", function()
  local c = vim.fn.getcharstr()
  if c:match("%l") then
    c = c:upper()
  end
  local ok, pos = pcall(vim.api.nvim_get_mark, c, {})
  if ok and pos[1] ~= 0 then
    jumplist.register()
    vim.cmd("normal! `" .. c .. "zz")
  else
    vim.notify("E20: Mark " .. c .. " not set", vim.log.levels.ERROR)
  end
end, {})
