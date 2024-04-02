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
    end
)

vim.keymap.set({'n'}, '<leader>ow',
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

vim.keymap.set({'n'}, '<leader>or',
    function()
        register_jump()
        vsc_notify('workbench.action.quickOpenPreviousRecentlyUsedEditor')
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

vim.keymap.set({'n'}, '<leader>gg',
    function()
        register_jump()
        vsc_notify('lazygit.lazygit_repository_current_file')
    end
)

vim.keymap.set({'n'}, '<leader>gcr',
    function()
        register_jump()
        vsc_notify('lazygit.lazygit')
    end
)

vim.keymap.set({'n'}, '<leader>gcl',
    function()
        register_jump()
        vsc_notify('lazygit.log')
    end
)

vim.keymap.set({'n'}, '<leader>gl',
    function()
        register_jump()
        vsc_notify('lazygit.log_repository_current_file')
    end
)

vim.keymap.set({'n'}, '<leader>gf',
    function()
        register_jump()
        vsc_notify('lazygit.file_history')
    end
)

vim.keymap.set({'n'}, '<leader>gv',
    function()
        register_jump()
        vsc_notify('git.viewHistory')
    end
)

vim.keymap.set({'n'}, '<leader>ge',
    function()
        register_jump()
        vsc_notify('compareCommitViewProvider.focus')
    end
)

vim.keymap.set({'n'}, '<leader>go',
    function()
        vsc_notify('workbench.action.compareEditor.focusOtherSide')
    end
)

vim.keymap.set({'n'}, '<leader>ga',
    function()
        vsc_notify('git.stage')
    end
)

vim.keymap.set({'n'}, '<leader>gu',
    function()
        vsc_notify('git.unstage')
    end
)

vim.keymap.set({'n'}, '<leader>gc',
    function()
        vsc_notify('git.commitStaged')
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

vim.keymap.set({'n'}, '<leader>oc',
    function()
        register_jump()
        vsc_notify('workbench.action.showCommands')
    end
)
