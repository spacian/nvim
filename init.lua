if not vim.g.vscode then
	vim.cmd("set colorcolumn=+1")
	vim.cmd("set signcolumn=yes:1")
	vim.opt.number = true
	vim.opt.relativenumber = false
	vim.opt.cursorline = false
	vim.opt.laststatus = 0
	vim.opt.winbar = "%=%f"
	vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = "#43243B" }) -- kanagawa:winterRed
	vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#49443C" }) -- kanagawa:winterYellow
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			},
			linehl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticErrorLn",
				[vim.diagnostic.severity.WARN] = "DiagnosticWarnLn",
			},
		},
	})
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
vim.o.textwidth = 88
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.bo.softtabstop = 4
require("remaps")
require("config.lazy")
if not vim.g.vscode then
	require("autocmd")
end
