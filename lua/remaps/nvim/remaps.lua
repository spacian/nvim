local jumplist = require("remaps.nvim.jumplist")
vim.keymap.set({ "n" }, "<a-q>", "q")
vim.keymap.set({ "n" }, "q", "")
vim.keymap.set({ "c" }, "<c-h>", "<c-p>")
vim.keymap.set({ "c" }, "<c-l>", "<c-n>")
vim.keymap.set({ "c" }, "<c-k>", "<c-y>")

vim.keymap.set({ "n" }, "<c-i>", function()
  jumplist.jump_forward()
  vim.api.nvim_feedkeys("zz", "n", true)
end)

vim.keymap.set({ "n" }, "<c-o>", function()
  jumplist.jump_back()
  vim.api.nvim_feedkeys("zz", "n", true)
end)

vim.keymap.set({ "n" }, "/", function()
  jumplist.register(1)
  vim.cmd("set nohls")
  vim.api.nvim_feedkeys("/", "n", true)
end)

vim.keymap.set({ "n" }, "?", function()
  jumplist.register(1)
  vim.cmd("set nohls")
  vim.api.nvim_feedkeys("?", "n", true)
end)

vim.keymap.set({ "n" }, "*", function()
  jumplist.register(1)
  vim.cmd("set nohls")
  vim.api.nvim_feedkeys("*", "n", true)
end)

vim.keymap.set({ "n" }, "#", function()
  jumplist.register(1)
  vim.cmd("set nohls")
  vim.api.nvim_feedkeys("#", "n", true)
end)

vim.keymap.set({ "n", "x" }, "gg", function()
  jumplist.register(1)
  if vim.v.count > 0 then
    vim.api.nvim_feedkeys(vim.v.count .. "gg", "n", true)
  else
    vim.api.nvim_feedkeys("gg0", "n", true)
  end
end)

vim.keymap.set({ "n", "x" }, "G", function()
  jumplist.register(1)
  vim.api.nvim_feedkeys("G$", "n", true)
end)

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.api.nvim_create_user_command("OpenInExplorer", function()
    vim.cmd('silent !start "" /max  explorer /select,' .. vim.api.nvim_buf_get_name(0))
  end, {})
end

vim.api.nvim_create_autocmd({ "TextChanged", "InsertEnter" }, {
  callback = function()
    if not BufIsSpecial() then
      jumplist.register(1)
    end
  end,
})
