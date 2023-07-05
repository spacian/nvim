function nvim_feedkeys(keys, modes)
    local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(feedable_keys, "n", false)
end

vim.keymap.set({'n','v'}, '<c-u>',
    function()
        nvim_feedkeys('12k')
        vim.cmd('call VSCodeNotify("center-editor-window.center")')
    end
)
vim.keymap.set({'n','v'}, '<c-d>',
    function()
        nvim_feedkeys('12j')
        vim.cmd('call VSCodeNotify("center-editor-window.center")')
    end
)

vim.keymap.set({'n','v'}, '<leader>e',
    function()
        vim.cmd('call VSCodeNotify("workbench.view.explorer")')
    end
)

vim.keymap.set({'n','v'}, '<leader>f',
    function()
        vim.cmd('call VSCodeNotify("workbench.action.findInFiles")')
    end
)

vim.keymap.set({'n','v'}, '<leader>q',
    function()
        vim.cmd('call VSCodeNotify("workbench.action.closeActiveEditor")')
    end
)

vim.keymap.set({'n','v'}, '<leader>Q',
    function()
        vim.cmd('call VSCodeNotify("workbench.action.closeOtherEditors")')
    end
)

vim.keymap.set({'n','v'}, '<leader>r',
    function()
        vim.cmd('call VSCodeNotify("editor.action.rename")')
    end
)
