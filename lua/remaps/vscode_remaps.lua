function nvim_feedkeys(keys, modes)
    local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(feedable_keys, "n", false)
end

vim.keymap.set({'n','v'}, '<C-u>',
    function()
        nvim_feedkeys('<C-u>')
        vim.cmd('call VSCodeNotify("center-editor-window.center")')
    end
)
vim.keymap.set({'n','v'}, '<C-d>',
    function()
        nvim_feedkeys('<C-d>')
        vim.cmd('call VSCodeNotify("center-editor-window.center")')
    end
)
