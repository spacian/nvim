require("remaps.code.utils")
require("remaps.code.jumps")

vim.keymap.set({ "n" }, "<leader>oe", function()
	Register_jump()
	Vsc_notify("workbench.explorer.fileView.focus")
end)

vim.keymap.set({ "n" }, "<c-q>", function()
	Register_jump()
	Vsc_notify("workbench.action.closeActiveEditor")
end)

vim.keymap.set({ "n" }, "<leader>ot", function()
	Register_jump()
	Vsc_notify("workbench.action.terminal.toggleTerminal")
end)

vim.keymap.set({ "n" }, "<leader>oo", function()
	Register_jump()
	Vsc_notify("outline.focus")
	Vsc_notify("outline.focus")
end)

vim.keymap.set({ "n" }, "<leader>oP", function()
	Vsc_notify("workbench.action.openRecent")
end)

vim.keymap.set({ "n" }, "<leader>of", function()
	Register_jump()
	Vsc_notify("workbench.action.quickOpen")
end)

vim.keymap.set({ "n" }, "<leader>og", function()
	Register_jump()
	Vsc_notify("workbench.scm.focus")
end)

vim.keymap.set({ "n" }, "<leader>on", function()
	Register_jump()
	Vsc_notify("extension.advancedNewFile")
end)

vim.keymap.set({ "n" }, "<esc>", function()
	Vsc_notify("workbench.action.closeSidebar")
	Vsc_notify("workbench.action.closeAuxiliaryBar")
	Vsc_notify("workbench.action.closePanel")
	Vsc_notify("notifications.hideToasts")
end)

vim.keymap.set({ "n" }, "<leader>cl", function()
	Vsc_notify("workbench.action.closeSidebar")
end)

vim.keymap.set({ "n" }, "<leader>ch", function()
	Vsc_notify("workbench.action.closeAuxiliaryBar")
end)

vim.keymap.set({ "n" }, "<leader>oc", function()
	Register_jump()
	Vsc_notify("workbench.action.showCommands")
end)

vim.keymap.set({ "n" }, "<leader>op", function()
	Register_jump()
	Vsc_notify("workbench.action.problems.focus")
end)
