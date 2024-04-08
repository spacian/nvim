require('remaps.vscode.utils')
require('remaps.vscode.jumps')

vim.keymap.set({'n'}, '<c-o>', jump_back, {noremap=true})
vim.keymap.set({'n'}, '<c-i>', jump_forw, {noremap=true})

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

vim.keymap.set({'n'}, 'M',
    function()
        vsc_notify('codemarks.createMark')
    end
)

vim.keymap.set({'n'}, "m",
    function()
        register_jump()
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
        register_jump()
        vsc_notify('codemarks.listMarks')
    end
)

vim.keymap.set({'n'}, '<leader>mac',
    function()
        vsc_notify('codemarks.clearAllMarks')
    end
)

vim.keymap.set({'n'}, '<leader>a',
    function()
        vsc_notify('vscode-harpoon.addEditor')
    end
)

vim.keymap.set({'n'}, '<leader>oh',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.editEditors')
    end
)

vim.keymap.set({'n'}, '<leader>j',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor1')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>k',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor2')
        center()
    end
)

vim.keymap.set({'n'}, '<leader>l',
    function()
        register_jump()
        vsc_notify('vscode-harpoon.gotoEditor3')
        center()
    end
)
