require("remaps.remaps")
require("remaps.diagnostic")
if vim.g.vscode then
	require("remaps.code")
else
	require("remaps.nvim")
end
