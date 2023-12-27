require('remaps.vscode_utils')
require('remaps.vscode_jumps')

vim.keymap.set({'n'}, '<c-o>', jump_back, {noremap=true})
vim.keymap.set({'n'}, '<c-i>', jump_forw, {noremap=true})

vim.keymap.set({'n'}, 'gd',
    function()
        register_jump()
        vsc_call('editor.action.revealDefinition')
        register_jump()
    end
)

vim.keymap.set({'n','v'}, '<c-d>',
    function()
        nvim_feedkeys('10j')
        center()
    end
)

vim.keymap.set({'n','v'}, '<c-u>',
    function()
        nvim_feedkeys('10k')
        center()
    end
)

vim.keymap.set({'n','v'}, '<c-k>',
    function()
        vsc_notify('scrollLineUp')
    end
)

vim.keymap.set({'n','v'}, '<c-j>',
    function()
        vsc_notify('scrollLineDown')
    end
)

vim.keymap.set({'n'}, '<leader>oe',
    function()
        register_jump()
        vsc_notify('workbench.view.explorer')
    end
)

vim.keymap.set({'n'}, '<leader>os',
    function()
        register_jump()
        vsc_notify('workbench.action.findInFiles')
    end
)

vim.keymap.set({'n','v'}, 'q',
    function()
        register_jump()
        vsc_notify('workbench.action.closeActiveEditor')
    end
)

vim.keymap.set({'n','v'}, 'Q',
    function()
        vsc_notify('workbench.action.closeOtherEditors')
    end
)

vim.keymap.set({'n','v'}, '<leader>r',
    function()
        vsc_notify('editor.action.rename')
    end
)

vim.keymap.set({'n','v'}, '<leader>gfl',
    function()
        vsc_notify('workbench.action.focusNextGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>gfh',
    function()
        vsc_notify('workbench.action.focusPreviousGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>gfj',
    function()
        vsc_notify('workbench.action.focusBelowGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>gfk',
    function()
        vsc_notify('workbench.action.focusAboveGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>gmk',
    function()
        vsc_notify('workbench.action.moveEditorToAboveGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>gmj',
    function()
        vsc_notify('workbench.action.moveEditorToBelowGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>gml',
    function()
        vsc_notify('workbench.action.moveEditorToNextGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>gmh',
    function()
        vsc_notify('workbench.action.moveEditorToPreviousGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>i',
    function()
        vsc_notify('editor.action.showDefinitionPreviewHover')
    end
)

vim.keymap.set({'n','v'}, '<leader><space>',
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

vim.keymap.set({'n','v'}, '<leader>ct',
    function()
        vsc_notify('workbench.action.closePanel')
    end
)

vim.keymap.set({'n'}, '<leader>oo',
    function()
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

vim.keymap.set({'n'}, '<leader>sf',
    function()
        vsc_notify('workbench.action.files.save')
    end
)

vim.keymap.set({'n'}, '<leader>on',
    function()
        register_jump()
        vsc_notify('extension.advancedNewFile')
    end
)

vim.keymap.set({'n','v'}, '<leader>e',
    function()
        vsc_notify('workbench.action.closeSidebar')
        vsc_notify('workbench.action.closeAuxiliaryBar')
        vsc_notify('workbench.action.closePanel')
    end
)

vim.keymap.set({'n','v'}, '<leader>ch',
    function()
        vsc_notify('workbench.action.closeSidebar')
    end
)

vim.keymap.set({'n','v'}, '<leader>cl',
    function()
        vsc_notify('workbench.action.closeAuxiliaryBar')
    end
)

vim.keymap.set({'n'}, '<leader>og',
    function()
        register_jump()
        vsc_notify('workbench.scm.focus')
    end
)

vim.keymap.set({'n'}, '<leader>so',
    function()
        if (vim.v.count > 0) then
            for _ = 1, vim.v.count, 1
            do
                vsc_notify('workbench.action.decreaseViewSize')
            end
        else
            vsc_notify('workbench.action.decreaseViewSize')
        end
    end
)

vim.keymap.set({'n'}, '<leader>si',
    function()
        if (vim.v.count > 0) then
            for _ = 1, vim.v.count, 1
            do
                vsc_notify('workbench.action.increaseViewSize')
            end
        else
            vsc_notify('workbench.action.increaseViewSize')
        end
    end
)

vim.keymap.set({'n'}, '<leader>sr',
    function()
        vsc_notify('workbench.action.evenEditorWidths')
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

vim.keymap.set({'n'}, '<leader>lm',
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

vim.keymap.set({'n'}, '<c-1>',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor1')
        center()
    end
)

vim.keymap.set({'n'}, '<c-2>',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor2')
        center()
    end
)

vim.keymap.set({'n'}, '<c-3>',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor3')
        center()
    end
)

vim.keymap.set({'n'}, '<c-4>',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor4')
        center()
    end
)

vim.keymap.set({'n'}, '<c-5>',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor5')
        center()
    end
)

vim.keymap.set({'n'}, '<c-6>',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor6')
        center()
    end
)

vim.keymap.set({'n'}, '<c-7>',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor7')
        center()
    end
)

vim.keymap.set({'n'}, '<c-8>',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor8')
        center()
    end
)

vim.keymap.set({'n'}, '<c-9>',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor9')
        center()
    end
)

vim.keymap.set({'n','v'}, '<leader>f', 'f', {noremap=true})
vim.keymap.set({'n'}, 'f',
    function()
        vsc_notify('metaGo.gotoBefore')
    end
)

vim.keymap.set({'n'}, '<leader>v',
    function()
        vsc_notify('metaGo.selectAfter')
    end
)

vim.keymap.set({'n',}, '<leader>ga',
    function()
        vsc_notify('git.stage')
    end
)

vim.keymap.set({'n',}, '<leader>gu',
    function()
        vsc_notify('git.unstage')
    end
)

vim.keymap.set({'n',}, '<leader>gc',
    function()
        vsc_notify('git.commitStaged')
    end
)
