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
        nvim_feedkeys('5k^')
        center()
    end
)

vim.keymap.set({'n','v'}, '<c-j>',
    function()
        nvim_feedkeys('5j^')
        center()
    end
)

vim.keymap.set({'n','v'}, '<leader>fe',
    function()
        vsc_notify('workbench.view.explorer')
    end
)

vim.keymap.set({'n','v'}, '<leader>ff',
    function()
        vsc_notify('workbench.action.findInFiles')
    end
)

vim.keymap.set({'n','v'}, '<leader>q',
    function()
        vsc_notify('workbench.action.closeActiveEditor')
    end
)

vim.keymap.set({'n','v'}, '<leader>Q',
    function()
        vsc_notify('workbench.action.closeOtherEditors')
    end
)

vim.keymap.set({'n','v'}, '<leader>r',
    function()
        vsc_notify('editor.action.rename')
    end
)

vim.keymap.set({'n','v'}, '<leader>h',
    function()
        vsc_notify('workbench.action.previousEditor')
    end
)

vim.keymap.set({'n','v'}, '<leader>l',
    function()
        vsc_notify('workbench.action.nextEditor')
    end
)

vim.keymap.set({'n','v'}, '<leader>1',
    function()
        vsc_notify('workbench.action.openEditorAtIndex1')
    end
)

vim.keymap.set({'n','v'}, '<leader>2',
    function()
        vsc_notify('workbench.action.openEditorAtIndex2')
    end
)

vim.keymap.set({'n','v'}, '<leader>3',
    function()
        vsc_notify('workbench.action.openEditorAtIndex3')
    end
)

vim.keymap.set({'n','v'}, '<leader>4',
    function()
        vsc_notify('workbench.action.openEditorAtIndex4')
    end
)

vim.keymap.set({'n','v'}, '<leader>5',
    function()
        vsc_notify('workbench.action.openEditorAtIndex5')
    end
)

vim.keymap.set({'n','v'}, '<leader>6',
    function()
        vsc_notify('workbench.action.openEditorAtIndex6')
    end
)

vim.keymap.set({'n','v'}, '<leader>7',
    function()
        vsc_notify('workbench.action.openEditorAtIndex7')
    end
)

vim.keymap.set({'n','v'}, '<leader>8',
    function()
        vsc_notify('workbench.action.openEditorAtIndex8')
    end
)

vim.keymap.set({'n','v'}, '<leader>9',
    function()
        vsc_notify('workbench.action.openEditorAtIndex9')
    end
)

vim.keymap.set({'n','v'}, '<leader>0',
    function()
        vsc_notify('workbench.action.lastEditorInGroup')
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
        vsc_notify('workbench.action.moveEditorRightInGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>mth',
    function()
        vsc_notify('workbench.action.moveEditorLeftInGroup')
    end
)

vim.keymap.set({'n','v'}, '<leader>fg',
    function()
        vsc_notify('workbench.scm.focus')
    end
)


vim.keymap.set({'n'}, '<leader>so',
    function()
        vsc_notify('workbench.action.decreaseViewSize')
    end
)
vim.keymap.set({'n'}, '<leader>si',
    function()
        vsc_notify('workbench.action.increaseViewSize')
    end
)

vim.keymap.set({'n'}, '<leader>sr',
    function()
        vsc_notify('workbench.action.evenEditorWidths')
    end
)
