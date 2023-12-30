require('remaps.remaps')
if vim.g.vscode then
    require('remaps.vscode')
else
    require('remaps.nvim')
end
