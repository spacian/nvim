vim.loader.enable()

---@param bufname string|nil
---@return boolean
BufIsSpecial = function(bufname)
	if bufname == nil then
		return vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == ""
	else
		return bufname == ""
			or bufname:match("oil://")
			or bufname:match("replacer://")
			or bufname:match("neo%-tree filesystem")
	end
end

require("remaps")
require("config.lazy")
if not vim.g.vscode then
	require("autocmd")
end
if not vim.g.vscode then
	vim.cmd("set colorcolumn=89")
	vim.cmd("set signcolumn=yes:1")
	vim.o.number = false
	vim.o.relativenumber = false
	vim.o.cursorline = true
	vim.o.cmdheight = 1
	vim.o.showcmd = false
	vim.o.ruler = false
	vim.o.showmode = false
	vim.o.jumpoptions = "stack,view"
	vim.o.scrolloff = 3
end
if vim.loop.os_uname().sysname == "Windows_NT" then
	vim.cmd("language en_US")
	vim.cmd("set shell=cmd.exe")
else
	vim.cmd("set wildignorecase")
end
vim.cmd('set shada="None"')
vim.cmd("set splitright")
vim.cmd("set timeoutlen=2250")
vim.cmd("set nohlsearch")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.bo.softtabstop = 4
