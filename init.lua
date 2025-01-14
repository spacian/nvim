if not vim.g.vscode then
    require('autocmd')
    vim.cmd('set spell')
    vim.cmd('set colorcolumn=+1')
    vim.opt.number = true
    vim.opt.relativenumber = false
    vim.opt.cursorline = true
    vim.opt.laststatus = 0
    vim.opt.winbar = "%=%f"
end
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.cmd('language en_US')
    vim.cmd('set shell=cmd.exe')
else
    vim.cmd('set wildignorecase')
end
vim.cmd('set shada="None"')
vim.cmd('set splitright')
vim.cmd('set timeoutlen=2250')
vim.cmd('set nohlsearch')
vim.cmd('set ignorecase')
vim.cmd('set smartcase')
vim.o.textwidth = 88
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.bo.softtabstop = 4
require('remaps')
require('config.lazy')
if not vim.g.vscode then
    require('autocmd')
end
