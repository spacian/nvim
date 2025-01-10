require('remaps.remaps')
if vim.g.vscode then
    require('remaps.code')
else
    require('remaps.nvim')
end
