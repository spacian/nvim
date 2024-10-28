require('remaps.vscode.utils')
require('remaps.vscode.jumps')

vim.keymap.set({'n'}, '<leader>oe',
    function()
        register_jump()
        vsc_notify('workbench.explorer.fileView.focus')
    end
)

vim.keymap.set({'n'}, '<c-q>',
    function()
        register_jump()
        vsc_notify('workbench.action.closeActiveEditor')
    end
)

vim.keymap.set({'n'}, '<leader>ot',
    function()
        register_jump()
        vsc_notify('workbench.action.terminal.toggleTerminal')
    end
)

vim.keymap.set({'n'}, '<leader>oo',
    function()
        register_jump()
        vsc_notify('outline.focus')
        vsc_notify('outline.focus')
    end
)

vim.keymap.set({'n'}, '<leader>oP',
    function()
        vsc_notify('workbench.action.openRecent')
    end
)

vim.keymap.set({'n'}, '<leader>of',
    function()
        register_jump()
        vsc_notify('workbench.action.quickOpen')
    end
)

vim.keymap.set({'n'}, '<leader>og',
    function()
        register_jump()
        vsc_notify('workbench.scm.focus')
    end
)

vim.keymap.set({'n'}, '<leader>on',
    function()
        register_jump()
        vsc_notify('extension.advancedNewFile')
    end
)

vim.keymap.set({'n'}, '<esc>',
    function()
        vsc_notify('workbench.action.closeSidebar')
        vsc_notify('workbench.action.closeAuxiliaryBar')
        vsc_notify('workbench.action.closePanel')
    end
)

vim.keymap.set({'n'}, '<leader>cl',
    function()
        vsc_notify('workbench.action.closeSidebar')
    end
)

vim.keymap.set({'n'}, '<leader>ch',
    function()
        vsc_notify('workbench.action.closeAuxiliaryBar')
    end
)

vim.keymap.set({'n'}, '<leader>oc',
    function()
        register_jump()
        vsc_notify('workbench.action.showCommands')
    end
)

vim.keymap.set({'n'}, '<leader>op',
    function()
        register_jump()
        vsc_notify('workbench.action.problems.focus')
    end
)
