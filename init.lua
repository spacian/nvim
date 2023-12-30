require('remaps')
require('plugins')
vim.api.nvim_exec('language en_US', true)
vim.api.nvim_exec('set notimeout', true)
vim.api.nvim_exec('set nohlsearch', true)
vim.o.textwidth = 88
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.bo.softtabstop = 4
