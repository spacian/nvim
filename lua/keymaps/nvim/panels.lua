vim.api.nvim_create_user_command("CleanupBuffers", function()
  if BufIsSpecial() then
    print("cannot cleanup buffers from special buffer")
  else
    local view = vim.fn.winsaveview()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      vim.diagnostic.reset(nil, bufnr)
    end
    vim.cmd("%bd!|e#")
    vim.fn.winrestview(view)
  end
end, {})

vim.keymap.set({ "", "l", "t" }, "<c-up>", "<c-w>-")
vim.keymap.set({ "", "l", "t" }, "<c-down>", "<c-w>+")
vim.keymap.set({ "", "l", "t" }, "<c-left>", "<c-w>>")
vim.keymap.set({ "", "l", "t" }, "<c-right>", "<c-w><")

vim.keymap.set({ "t" }, "<c-n>", [[<c-\><c-n>]])

vim.keymap.set({ "", "l", "t" }, "<a-h>", function()
  Feedkeys([[<c-\><c-n><c-w>h]])
end)

vim.keymap.set({ "", "l", "t" }, "<a-j>", function()
  Feedkeys([[<c-\><c-n><c-w>j]])
end)

vim.keymap.set({ "", "l", "t" }, "<a-k>", function()
  Feedkeys([[<c-\><c-n><c-w>k]])
end)

vim.keymap.set({ "", "l", "t" }, "<a-l>", function()
  Feedkeys([[<c-\><c-n><c-w>l]])
end)

vim.keymap.set({ "", "l", "t" }, "<c-a-h>", function()
  vim.cmd("vsplit | b#")
  Feedkeys([[<c-\><c-n><c-w>h]])
end)

vim.keymap.set({ "", "l", "t" }, "<c-a-j>", function()
  vim.cmd("split | b#")
  Feedkeys([[<c-\><c-n><c-w>j]])
end)

vim.keymap.set({ "", "l", "t" }, "<c-a-k>", function()
  vim.cmd("split | b# | wincmd x")
end)

vim.keymap.set({ "", "l", "t" }, "<c-a-l>", function()
  vim.cmd("vsplit | b# | wincmd x")
end)
