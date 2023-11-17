function nvim_feedkeys(keys)
    local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(feedable_keys, "n", false)
end

function vsc_notify(arg)
    nvim_feedkeys(string.format(':call VSCodeNotify("%s")<enter>', arg))
end

function center()
    vsc_notify('center-editor-window.center')
end


vim.keymap.set({'n','v'}, '<c-d>',
    function()
        nvim_feedkeys('20j^')
        center()
    end
)

vim.keymap.set({'n','v'}, '<c-u>',
    function()
        nvim_feedkeys('20k^')
        center()
    end
)
vim.keymap.set({'n','v'}, '<c-k>',
    function()
        nvim_feedkeys('5k')
        center()
    end
)

vim.keymap.set({'n','v'}, '<c-j>',
    function()
        nvim_feedkeys('5j')
        center()
    end
)

vim.keymap.set({'n','v'}, '<leader>fe',
    function()
        vsc_notify('workbench.view.explorer')
    end
)

vim.keymap.set({'n','v'}, '<leader>fs',
    function()
        vsc_notify('workbench.action.findInFiles')
    end
)

vim.keymap.set({'n','v'}, 'q',
    function()
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

vim.keymap.set({'n','v'}, '<leader>fl',
    function()
        vsc_notify('workbench.action.focusNextGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>fh',
    function()
        vsc_notify('workbench.action.focusPreviousGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>fj',
    function()
        vsc_notify('workbench.action.focusBelowGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>fk',
    function()
        vsc_notify('workbench.action.focusAboveGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>mk',
    function()
        vsc_notify('workbench.action.moveEditorToAboveGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>mj',
    function()
        vsc_notify('workbench.action.moveEditorToBelowGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>ml',
    function()
        vsc_notify('workbench.action.moveEditorToNextGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>mh',
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

vim.keymap.set({'n','v'}, '<leader>ft',
    function()
        vsc_notify('workbench.action.terminal.toggleTerminal')
    end
)

vim.keymap.set({'n','v'}, '<leader>ct',
    function()
        vsc_notify('workbench.action.togglePanel')
    end
)

vim.keymap.set({'n','v'}, '<leader>fo',
    function()
        vsc_notify('outline.focus')
    end
)

vim.keymap.set({'n','v'}, '<leader>ow',
    function()
        vsc_notify('workbench.action.openRecent')
    end
)

vim.keymap.set({'n','v'}, '<leader>of',
    function()
        vsc_notify('workbench.action.quickOpen')
    end
)

vim.keymap.set({'n','v'}, '<leader>or',
    function()
        vsc_notify('workbench.action.quickOpenPreviousRecentlyUsedEditor')
    end
)

vim.keymap.set({'n'}, '<leader>sf',
    function()
        vsc_notify('workbench.action.files.save')
    end
)

vim.keymap.set({'n','v'}, '<leader>fn',
    function()
        vsc_notify('extension.advancedNewFile')
    end
)

vim.keymap.set({'n','v'}, '<leader>cj',
    function()
        vsc_notify('workbench.action.closeSidebar')
        vsc_notify('workbench.action.closeAuxiliaryBar')
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

vim.keymap.set({'n','v'}, '<leader>mtl',
    function()
        if (vim.v.count > 0) then
            for _ = 1, vim.v.count, 1
            do
                vsc_notify('workbench.action.moveEditorRightInGroup')
            end
        else
            vsc_notify('workbench.action.moveEditorRightInGroup')
        end
    end
)

vim.keymap.set({'n','v'}, '<leader>mth',
    function()
        if (vim.v.count > 0) then
            for _ = 1, vim.v.count, 1
            do
                vsc_notify('workbench.action.moveEditorLeftInGroup')
            end
        else
            vsc_notify('workbench.action.moveEditorLeftInGroup')
        end
    end
)

vim.keymap.set({'n','v'}, '<leader>fg',
    function()
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
        vsc_notify('vscode-harpoon.editEditors')
    end
)

vim.keymap.set({'n'}, '<leader>ho',
    function()
        vsc_notify('vscode-harpoon.editorQuickPick')
    end
)

vim.keymap.set({'n'}, '<leader>hp',
    function()
        vsc_notify('vscode-harpoon.gotoPreviousHarpoonEditor')
        center()
    end
)

vim.keymap.set({'n'}, '<c-1>',
    function()
        vsc_notify('vscode-harpoon.gotoEditor1')
        center()
    end
)

vim.keymap.set({'n'}, '<c-2>',
    function()
        vsc_notify('vscode-harpoon.gotoEditor2')
        center()
    end
)

vim.keymap.set({'n'}, '<c-3>',
    function()
        vsc_notify('vscode-harpoon.gotoEditor3')
        center()
    end
)

vim.keymap.set({'n'}, '<c-4>',
    function()
        vsc_notify('vscode-harpoon.gotoEditor4')
        center()
    end
)

vim.keymap.set({'n'}, '<c-5>',
    function()
        vsc_notify('vscode-harpoon.gotoEditor5')
        center()
    end
)

vim.keymap.set({'n'}, '<c-6>',
    function()
        vsc_notify('vscode-harpoon.gotoEditor6')
        center()
    end
)

vim.keymap.set({'n'}, '<c-7>',
    function()
        vsc_notify('vscode-harpoon.gotoEditor7')
        center()
    end
)

vim.keymap.set({'n'}, '<c-8>',
    function()
        vsc_notify('vscode-harpoon.gotoEditor8')
        center()
    end
)

vim.keymap.set({'n'}, '<c-9>',
    function()
        vsc_notify('vscode-harpoon.gotoEditor9')
        center()
    end
)
