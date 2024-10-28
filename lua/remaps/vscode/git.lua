require('remaps.vscode.utils')
require('remaps.vscode.jumps')

vim.keymap.set({'n'}, '<leader>gg',
    function()
        register_jump()
        vsc_notify('workbench.action.closeSidebar')
        vsc_notify('workbench.action.closeAuxiliaryBar')
        vsc_notify('lazygit.lazygit_repository_current_file')
    end
)

vim.keymap.set({'n'}, '<leader>gr',
    function()
        register_jump()
        vsc_notify('workbench.action.closeSidebar')
        vsc_notify('workbench.action.closeAuxiliaryBar')
        vsc_notify('lazygit.lazygit')
    end
)

vim.keymap.set({'n'}, '<leader>gl',
    function()
        register_jump()
        vsc_notify('workbench.action.closeSidebar')
        vsc_notify('workbench.action.closeAuxiliaryBar')
        vsc_notify('lazygit.log_repository_current_file')
    end
)

vim.keymap.set({'n'}, '<leader>gf',
    function()
        register_jump()
        vsc_notify('workbench.action.closeSidebar')
        vsc_notify('workbench.action.closeAuxiliaryBar')
        vsc_notify('lazygit.file_history')
    end
)

vim.keymap.set({'n'}, '<leader>gv',
    function()
        register_jump()
        vsc_notify('git.viewHistory')
    end
)

vim.keymap.set({'n'}, '<leader>gs',
    function()
        register_jump()
        vsc_notify('editor.action.dirtydiff.next')
    end
)

vim.keymap.set({'n'}, '<leader>gp',
    function()
        register_jump()
        vsc_notify('workbench.action.compareEditor.previousChange')
        vsc_notify('workbench.action.editor.previousChange')
    end
)

vim.keymap.set({'n'}, '<leader>gn',
    function()
        register_jump()
        vsc_notify('workbench.action.compareEditor.nextChange')
        vsc_notify('workbench.action.editor.nextChange')
    end
)

vim.keymap.set({'n'}, '<leader>gd',
    function()
        register_jump()
        vsc_notify('git.openChange')
    end
)

vim.keymap.set({'n'}, '<leader>go',
    function()
        vsc_notify('workbench.action.compareEditor.focusOtherSide')
    end
)
