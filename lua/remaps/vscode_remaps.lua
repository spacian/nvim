function nvim_feedkeys(keys)
    local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(feedable_keys, "n", false)
end

function vsc_notify(arg)
    nvim_feedkeys(string.format(':call VSCodeNotify("%s")<enter>', arg))
end

vim.keymap.set({'n','v'}, '<c-u>',
    function()
        nvim_feedkeys('12k')
        vsc_notify('center-editor-window.center')
    end
)

vim.keymap.set({'n','v'}, '<c-d>',
    function()
        nvim_feedkeys('12j')
        vsc_notify('center-editor-window.center')
    end
)

vim.keymap.set({'n','v'}, '<leader>e',
    function()
        vsc_notify('workbench.view.explorer')
    end
)

vim.keymap.set({'n','v'}, '<leader>f',
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
