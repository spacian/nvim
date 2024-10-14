require('remaps.vscode.utils')
require('remaps.vscode.jumps')

vim.keymap.set({'n'}, '<leader>oe',
    function()
        register_jump()
        vsc_call('workbench.explorer.fileView.focus')
    end
)

vim.keymap.set({'n'}, '<c-q>',
    function()
        register_jump()
        vsc_call('workbench.action.closeActiveEditor')
    end
)

vim.keymap.set({'n'}, '<leader>ot',
    function()
        register_jump()
        vsc_call('workbench.action.terminal.toggleTerminal')
    end
)

vim.keymap.set({'n'}, '<leader>oo',
    function()
        register_jump()
        vsc_call('outline.focus')
    end
)

vim.keymap.set({'n'}, '<leader>ow',
    function()
        vsc_call('workbench.action.openRecent')
    end
)

vim.keymap.set({'n'}, '<leader>of',
    function()
        register_jump()
        vsc_call('workbench.action.quickOpen')
    end
)

vim.keymap.set({'n'}, '<leader>or',
    function()
        register_jump()
        vsc_call('workbench.action.quickOpenPreviousRecentlyUsedEditor')
    end
)

vim.keymap.set({'n'}, '<leader>og',
    function()
        register_jump()
        vsc_call('workbench.scm.focus')
    end
)

vim.keymap.set({'n'}, '<leader>on',
    function()
        register_jump()
        vsc_call('extension.advancedNewFile')
    end
)

vim.keymap.set({'n'}, '<esc>',
    function()
        vsc_call('workbench.action.closeSidebar')
        vsc_call('workbench.action.closeAuxiliaryBar')
        vsc_call('workbench.action.closePanel')
    end
)

vim.keymap.set({'n'}, '<leader>cl',
    function()
        vsc_call('workbench.action.closeSidebar')
    end
)

vim.keymap.set({'n'}, '<leader>ch',
    function()
        vsc_call('workbench.action.closeAuxiliaryBar')
    end
)

vim.keymap.set({'n'}, '<leader>gg',
    function()
        register_jump()
        vsc_call('lazygit.lazygit_repository_current_file')
    end
)

vim.keymap.set({'n'}, '<leader>gcr',
    function()
        register_jump()
        vsc_call('lazygit.lazygit')
    end
)

vim.keymap.set({'n'}, '<leader>gcl',
    function()
        register_jump()
        vsc_call('lazygit.log')
    end
)

vim.keymap.set({'n'}, '<leader>gl',
    function()
        register_jump()
        vsc_call('lazygit.log_repository_current_file')
    end
)

vim.keymap.set({'n'}, '<leader>gf',
    function()
        register_jump()
        vsc_call('lazygit.file_history')
    end
)

vim.keymap.set({'n'}, '<leader>gv',
    function()
        register_jump()
        vsc_call('git.viewHistory')
    end
)

vim.keymap.set({'n'}, '<leader>ge',
    function()
        register_jump()
        vsc_call('compareCommitViewProvider.focus')
    end
)

vim.keymap.set({'n'}, '<leader>go',
    function()
        vsc_call('workbench.action.compareEditor.focusOtherSide')
    end
)

vim.keymap.set({'n'}, '<leader>gs',
    function()
        register_jump()
        vsc_call('editor.action.dirtydiff.next')
    end
)

vim.keymap.set({'n'}, '<leader>gp',
    function()
        register_jump()
        vsc_call('workbench.action.compareEditor.previousChange')
        vsc_call('workbench.action.editor.previousChange')
    end
)

vim.keymap.set({'n'}, '<leader>gn',
    function()
        register_jump()
        vsc_call('workbench.action.compareEditor.nextChange')
        vsc_call('workbench.action.editor.nextChange')
    end
)

vim.keymap.set({'n'}, '<leader>oc',
    function()
        register_jump()
        vsc_call('workbench.action.showCommands')
    end
)

vim.keymap.set({'n'}, '<leader>op',
    function()
        register_jump()
        vsc_call('workbench.action.problems.focus')
    end
)
