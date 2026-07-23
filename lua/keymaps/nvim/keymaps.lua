local jumplist = require("keymaps.nvim.jumplist")
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
  jumplist.register()
  vim.cmd("set nohls")
  vim.api.nvim_feedkeys("/", "n", true)
end)

vim.keymap.set({ "n" }, "?", function()
  jumplist.register()
  vim.cmd("set nohls")
  vim.api.nvim_feedkeys("?", "n", true)
end)

vim.keymap.set({ "n" }, "*", function()
  jumplist.register()
  vim.cmd("set nohls")
  vim.api.nvim_feedkeys("*", "n", true)
end)

vim.keymap.set({ "n" }, "#", function()
  jumplist.register()
  vim.cmd("set nohls")
  vim.api.nvim_feedkeys("#", "n", true)
end)

vim.keymap.set({ "n" }, "gf", function()
  jumplist.register()
  vim.cmd("set nohls")
  vim.api.nvim_feedkeys("gf", "n", true)
end)

vim.keymap.set({ "n", "x" }, "gg", function()
  jumplist.register()
  if vim.v.count > 0 then
    vim.api.nvim_feedkeys(vim.v.count .. "gg", "n", true)
  else
    vim.api.nvim_feedkeys("gg0", "n", true)
  end
end)

vim.keymap.set({ "n", "x" }, "G", function()
  jumplist.register()
  vim.api.nvim_feedkeys("G$", "n", true)
end)

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.api.nvim_create_user_command("OpenInExplorer", function()
    vim.cmd(
      'silent !start "" /max  explorer /select,'
        .. vim.api.nvim_buf_get_name(0):gsub("/", "\\")
    )
  end, {})
end

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  callback = function()
    if not BufIsSpecial() then
      jumplist.register()
    end
  end,
})

for i = 1, 12 do
  vim.keymap.set({ "i" }, ("<F%d>"):format(i), "<Nop>")
end

vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function()
    vim.keymap.set("n", "<esc>", "<cmd>:q<enter>", { buffer = true })
    vim.keymap.set("n", "q", "<cmd>:q<enter>", { buffer = true })
  end,
})
