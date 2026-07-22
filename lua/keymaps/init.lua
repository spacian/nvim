require("keymaps.keymaps")
if vim.g.vscode then
  require("keymaps.code")
else
  require("keymaps.nvim")
end
