require('remaps')
require('plugins')
if not vim.g.vscode then
    require('autocmd')
    vim.api.nvim_exec('set spell', true)
    vim.api.nvim_exec('set colorcolumn=+1', true)
end
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.api.nvim_exec('language en_US', true)
else
    vim.api.nvim_exec('set wildignorecase', true)
    vim.api.nvim_exec('set splitright', true)
end
vim.api.nvim_exec('set timeoutlen=2250', true)
vim.api.nvim_exec('set nohlsearch', true)
vim.api.nvim_exec('set ignorecase', true)
vim.api.nvim_exec('set smartcase', true)
vim.o.textwidth = 88
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.bo.softtabstop = 4
