---@param bufname string|nil
---@return boolean
BufIsSpecial = function(bufname)
	if bufname == nil then
		if vim.bo.buftype ~= "" then
			return true
		end
		bufname = vim.api.nvim_buf_get_name(0)
	end
	return bufname == ""
		or bufname:match("oil://")
		or bufname:match("replacer://")
		or bufname:match("neo%-tree filesystem")
		or bufname:match("term://")
end

require("remaps")
require("config.lazy")
if not vim.g.vscode then
	require("autocmd")
	function Line(line, width)
		local s = tostring(line)
		local pad = width - #s
		if pad > 0 then
			return string.rep(" ", pad) .. s
		else
			return s
		end
	end
	vim.o.wrap = true
	vim.o.signcolumn = "yes:1"
	vim.o.statuscolumn = "%{v:lua.Line(v:lnum, 4)}%s"
	vim.o.cursorline = true
	vim.o.foldcolumn = "0"
	vim.o.signcolumn = "yes:1"
	vim.o.cmdheight = 1
	vim.o.showcmd = false
	vim.o.ruler = false
	vim.o.showmode = false
	vim.o.jumpoptions = "stack,view"
	vim.o.scrolloff = 3
	vim.opt.sessionoptions:remove("terminal")
end
if vim.loop.os_uname().sysname == "Windows_NT" then
	vim.o.shell = "cmd.exe"
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
require("highlights")
