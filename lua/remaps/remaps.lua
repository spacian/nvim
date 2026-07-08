vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<leader><leader>", "")
vim.keymap.set({ "v" }, "p", '"_dP')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y$')
vim.keymap.set({ "n", "v" }, "<c-t>", "")
vim.keymap.set({ "n" }, "J", function()
  local pos = vim.fn.getpos(".")
  vim.fn.feedkeys("J", "n")
  vim.schedule(function()
    vim.fn.setpos(".", pos)
  end)
end)
vim.keymap.set(
  { "n", "v" },
  "H",
  "(col('.') == matchend(getline('.'), '^\\s*')+1 ? '0' : '^')",
  { expr = true }
)
vim.keymap.set({ "n", "v" }, "L", "$")
vim.keymap.set({ "n" }, "yall", ":%y<enter>")
vim.keymap.set({ "n" }, "<leader>yall", ":%y+<enter>")
vim.keymap.set({ "n", "v" }, "<c-d>", "10j")
vim.keymap.set({ "n", "v" }, "<c-u>", "10k")
vim.keymap.set({ "n" }, "<leader>o", "")
vim.keymap.set({ "n" }, "gwip", function()
  vim.o.textwidth = 88
  vim.api.nvim_feedkeys("gwip^", "n", false)
  vim.o.textwidth = 0
end)
vim.keymap.set({ "n" }, "gwl", function()
  vim.o.textwidth = 88
  vim.api.nvim_feedkeys("gwl^", "n", false)
  vim.o.textwidth = 0
end)
vim.keymap.set({ "x" }, "gw", function()
  vim.o.textwidth = 88
  vim.api.nvim_feedkeys("gw^", "n", false)
  vim.o.textwidth = 0
end)
vim.keymap.set("n", "q", function()
  if vim.fn.reg_recording() ~= "" then
    vim.api.nvim_feedkeys("q", "n", false)
    return
  end
  local char = vim.fn.getcharstr()
  if vim.fn.confirm("Execute 'q" .. char .. "'?", "&Yes\n&No", 1) == 1 then
    vim.api.nvim_feedkeys("q" .. char, "n", false)
  end
end)
