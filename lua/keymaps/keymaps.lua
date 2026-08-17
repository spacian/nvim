vim.keymap.set({ "n", "x" }, "<leader><leader>", "")
vim.keymap.set({ "x" }, "p", '"_dP')
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "x" }, "<leader>P", '"+P')
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+y$')
vim.keymap.set({ "n", "x" }, "<c-t>", "")
vim.keymap.set({ "n" }, "J", function()
  local pos = vim.fn.getpos(".")
  vim.fn.feedkeys("J", "n")
  vim.schedule(function()
    vim.fn.setpos(".", pos)
  end)
end)
vim.keymap.set(
  { "n", "x", "o" },
  "H",
  "(col('.') == matchend(getline('.'), '^\\s*')+1 ? '0' : '^')",
  { expr = true }
)
vim.keymap.set({ "n", "x", "o" }, "L", "$")
vim.keymap.set({ "n", "x" }, "<c-d>", "10j")
vim.keymap.set({ "n", "x" }, "<c-u>", "10k")
vim.keymap.set({ "n" }, "<leader>o", "")

local function wrap_textwrap(key)
  vim.keymap.set({ "n" }, key, function()
    vim.o.textwidth = 88
    vim.api.nvim_feedkeys(key .. "^", "nx", false)
    vim.o.textwidth = 0
  end)
end

for _, key in ipairs({ "gwip", "gwl", "gw" }) do
  wrap_textwrap(key)
end

vim.keymap.set({ "n" }, "<c-i>", function()
  Jumplist.jump_forward()
  vim.api.nvim_feedkeys("zz", "n", true)
end)

vim.keymap.set({ "n" }, "<c-o>", function()
  Jumplist.jump_back()
  vim.api.nvim_feedkeys("zz", "n", true)
end)

local function wrap_register(key)
  vim.keymap.set({ "n" }, key, function()
    Jumplist.register()
    vim.api.nvim_feedkeys(key, "n", true)
  end)
end

for _, key in ipairs({ "/", "?", "*", "#", "gf" }) do
  wrap_register(key)
end

vim.keymap.set({ "n", "x" }, "gg", function()
  Jumplist.register()
  if vim.v.count > 0 then
    vim.api.nvim_feedkeys(vim.v.count .. "gg", "n", true)
  else
    vim.api.nvim_feedkeys("gg0", "n", true)
  end
end)

vim.keymap.set({ "n", "x" }, "G", function()
  Jumplist.register()
  vim.api.nvim_feedkeys("G$", "n", true)
end)

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.api.nvim_create_user_command("OpenInExplorer", function()
    vim.cmd(
      'silent !start "" /max  explorer /select,'
        .. vim.api.nvim_buf_get_name(0):gsub("/", "\\")
    )
  end, {})
  vim.api.nvim_create_user_command("CopyFilePath", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
  end, {})
  vim.api.nvim_create_user_command("CopyFolderPath", function()
    vim.fn.setreg("+", vim.fn.expand("%:p:h"))
  end, {})
end

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  callback = function()
    if not BufIsSpecial() then
      Jumplist.register()
    end
  end,
})

for i = 1, 12 do
  vim.keymap.set({ "i" }, ("<F%d>"):format(i), "<Nop>")
end

vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function()
    vim.keymap.set("n", "q", "<cmd>:q<enter>", { buffer = true })
  end,
})
