vim.api.nvim_exec('language en_US', true)
vim.api.nvim_exec('set notimeout', true)
vim.api.nvim_exec('set nohlsearch', true)
require('remaps')
require('plugins')
vim.o.textwidth = 88
