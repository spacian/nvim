vim.g.mapleader = " "
vim.opt.shortmess:append("I")
vim.o.wrap = true
vim.o.signcolumn = "yes:1"
vim.o.foldcolumn = "0"
vim.o.number = true
vim.o.statuscolumn = "%l%s"
vim.opt.numberwidth = 3
vim.opt.fillchars = { eob = " " }
vim.opt.formatoptions:remove("t")
vim.o.textwidth = 0
vim.o.cursorline = true
vim.o.cmdheight = 1
vim.o.showcmd = false
vim.o.ruler = false
vim.o.showmode = false
vim.o.jumpoptions = "stack,view"
vim.opt.sessionoptions:remove("terminal")
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "hiddenoff",
  "algorithm:histogram",
  "indent-heuristic",
  "linematch:200",
  "context:99999",
}

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.cmd("language en_US")
else
  vim.o.wildignorecase = true
end

vim.o.shada = ""
vim.o.splitright = true
vim.o.timeoutlen = 2250
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.bo.softtabstop = 4
