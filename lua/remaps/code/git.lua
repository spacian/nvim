require("remaps.code.utils")
require("remaps.code.jumps")

vim.keymap.set({ "n" }, "<leader>gg", function()
	Register_jump()
	Vsc_notify("workbench.action.closeSidebar")
	Vsc_notify("workbench.action.closeAuxiliaryBar")
	Vsc_notify("lazygit.lazygit_repository_current_file")
end)

vim.keymap.set({ "n" }, "<leader>gr", function()
	Register_jump()
	Vsc_notify("workbench.action.closeSidebar")
	Vsc_notify("workbench.action.closeAuxiliaryBar")
	Vsc_notify("lazygit.lazygit")
end)

vim.keymap.set({ "n" }, "<leader>gl", function()
	Register_jump()
	Vsc_notify("workbench.action.closeSidebar")
	Vsc_notify("workbench.action.closeAuxiliaryBar")
	Vsc_notify("lazygit.log_repository_current_file")
end)

vim.keymap.set({ "n" }, "<leader>gf", function()
	Register_jump()
	Vsc_notify("workbench.action.closeSidebar")
	Vsc_notify("workbench.action.closeAuxiliaryBar")
	Vsc_notify("lazygit.file_history")
end)

vim.keymap.set({ "n" }, "<leader>gv", function()
	Register_jump()
	Vsc_notify("git.viewHistory")
end)

vim.keymap.set({ "n" }, "<leader>gs", function()
	Register_jump()
	Vsc_notify("editor.action.dirtydiff.next")
end)

vim.keymap.set({ "n" }, "<leader>gp", function()
	Register_jump()
	Vsc_notify("workbench.action.compareEditor.previousChange")
	Vsc_notify("workbench.action.editor.previousChange")
end)

vim.keymap.set({ "n" }, "<leader>gn", function()
	Register_jump()
	Vsc_notify("workbench.action.compareEditor.nextChange")
	Vsc_notify("workbench.action.editor.nextChange")
end)

vim.keymap.set({ "n" }, "<leader>gd", function()
	Register_jump()
	Vsc_notify("git.openChange")
end)

vim.keymap.set({ "n" }, "<leader>go", function()
	Vsc_notify("workbench.action.compareEditor.focusOtherSide")
end)
