require('remaps.vscode.utils')
require('remaps.vscode.jumps')

vim.keymap.set({'n'}, '<leader>k', '<plug>VSCodeCommentaryLine', {noremap=true})
vim.keymap.set({'x'}, '<leader>k', '<plug>VSCodeCommentary', {noremap=true})
vim.keymap.set({'n'}, '<c-o>', jump_back, {noremap=true})
vim.keymap.set({'n'}, '<c-i>', jump_forw, {noremap=true})

vim.keymap.set({'n'}, 'gd',
    function()
        register_jump()
        vsc_call('editor.action.revealDefinition')
    end
)

vim.keymap.set({'n'}, '<c-d>',
    function()
        nvim_feedkeys('10j')
        center()
    end
)

vim.keymap.set({'n'}, '<c-u>',
    function()
        nvim_feedkeys('10k')
        center()
    end
)


vim.keymap.set({'n'}, '}',
    function()
        nvim_feedkeys('}')
        center()
    end
)

vim.keymap.set({'n'}, '{',
    function()
        nvim_feedkeys('{')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>oe',
    function()
        register_jump()
        vsc_notify('workbench.explorer.fileView.focus')
    end
)

vim.keymap.set({'n'}, '<leader>fs',
    function()
        register_jump()
        vsc_notify('workbench.action.showAllSymbols')
    end
)

vim.keymap.set({'n'}, '<leader>ff',
    function()
        register_jump()
        vsc_notify('search.action.openEditor')
    end
)

vim.keymap.set({'n'}, '<leader>fr',
    function()
        register_jump()
        vsc_notify('editor.action.referenceSearch.trigger')
    end
)

vim.keymap.set({'n'}, '<c-q>',
    function()
        register_jump()
        vsc_notify('workbench.action.closeActiveEditor')
    end
)

vim.keymap.set({'n'}, '<leader>r',
    function()
        vsc_notify('editor.action.rename')
    end
)

vim.keymap.set({'n'}, '<leader>gfl',
    function()
        vsc_notify('workbench.action.focusNextGroup')
    end
)

vim.keymap.set({'n'}, '<leader>gfh',
    function()
        vsc_notify('workbench.action.focusPreviousGroup')
    end
)

vim.keymap.set({'n'}, '<leader>gfj',
    function()
        vsc_notify('workbench.action.focusBelowGroup')
    end
)

vim.keymap.set({'n'}, '<leader>gfk',
    function()
        vsc_notify('workbench.action.focusAboveGroup')
    end
)

vim.keymap.set({'n'}, '<leader>gmk',
    function()
        vsc_notify('workbench.action.moveEditorToAboveGroup')
    end
)

vim.keymap.set({'n'}, '<leader>gmj',
    function()
        vsc_notify('workbench.action.moveEditorToBelowGroup')
    end
)

vim.keymap.set({'n'}, '<leader>gml',
    function()
        vsc_notify('workbench.action.moveEditorToNextGroup')
    end
)

vim.keymap.set({'n'}, '<leader>gmh',
    function()
        vsc_notify('workbench.action.moveEditorToPreviousGroup')
    end
)

vim.keymap.set({'n'}, '<leader>i',
    function()
        vsc_notify('editor.action.showDefinitionPreviewHover')
    end
)

vim.keymap.set({'n'}, '<leader><space>',
    function()
        center()
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

vim.keymap.set({'n'}, '<leader>on',
    function()
        register_jump()
        vsc_notify('extension.advancedNewFile')
    end
)

vim.keymap.set({'n'}, '<leader>e',
    function()
        vsc_notify('workbench.action.closeSidebar')
        vsc_notify('workbench.action.closeAuxiliaryBar')
        vsc_notify('workbench.action.closePanel')
    end
)

vim.keymap.set({'n'}, '<leader>ch',
    function()
        vsc_notify('workbench.action.closeSidebar')
    end
)

vim.keymap.set({'n'}, '<leader>cl',
    function()
        vsc_notify('workbench.action.closeAuxiliaryBar')
    end
)

vim.keymap.set({'n'}, 'm',
    function()
        vsc_notify('codemarks.createMark')
    end
)

vim.keymap.set({'n'}, "'",
    function()
        vsc_notify('codemarks.jumpToMark')
    end
)

vim.keymap.set({'n'}, "`",
    function()
        vsc_notify('codemarks.jumpToMark')
    end
)

vim.keymap.set({'n'}, '<leader>mc',
    function()
        vsc_notify('codemarks.clearMarksUnderCursor')
    end
)

vim.keymap.set({'n'}, '<leader>ml',
    function()
        vsc_notify('codemarks.listMarks')
    end
)

vim.keymap.set({'n'}, '<leader>mac',
    function()
        vsc_notify('codemarks.clearAllMarks')
    end
)

vim.keymap.set({'n'}, '<leader>ha',
    function()
        vsc_notify('vscode-harpoon.addEditor')
    end
)

vim.keymap.set({'n'}, '<leader>he',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.editEditors')
    end
)

vim.keymap.set({'n'}, '<leader>oh',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.editorQuickPick')
    end
)

vim.keymap.set({'n'}, '<leader>hl',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoPreviousHarpoonEditor')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>1',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor1')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>2',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor2')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>3',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor3')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>4',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor4')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>5',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor5')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>6',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor6')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>7',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor7')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>8',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor8')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>9',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor9')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>og',
    function()
        register_jump()
        vsc_notify('workbench.scm.focus')
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

vim.keymap.set({'n'}, 'gi',
    function()
        register_jump()
        jump_forw(1)
    end
)

vim.keymap.set({'n'}, 'go',
    function()
        register_jump()
        jump_back(1)
    end
)
