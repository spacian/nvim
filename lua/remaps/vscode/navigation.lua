require('remaps.vscode.utils')
require('remaps.vscode.jumps')

vim.keymap.set({'n'}, '<c-o>', jump_back, {noremap=true})
vim.keymap.set({'n'}, '<c-i>', jump_forw, {noremap=true})

vim.keymap.set({'n'}, 'j',
    function()
        vim.cmd(
            "call VSCodeNotify('cursorMove', " ..
            "{'to':'down', 'by':'wrappedLine', 'value':" .. vim.v.count + 1 .. "})"
        )
    end
)

vim.keymap.set({'n'}, 'k',
    function()
        vim.cmd(
            "call VSCodeNotify('cursorMove', {'to':'up', 'by':'wrappedLine', 'value':"
            ..vim.v.count..
            "})"
        )
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

for i = 1, 26 do
    local upper = string.char(i+64)
    local lower = string.char(i+96)
    vim.keymap.set({'n'}, 'M'..upper,
        function()
            vsc_notify('vim-marks.create_mark_'..upper)
        end
    )
    vim.keymap.set({'n'}, 'M'..lower,
        function()
            vsc_notify('vim-marks.create_mark_'..lower)
        end
    )
    vim.keymap.set({'n'}, 'm'..upper,
        function()
            register_jump()
            vsc_notify('vim-marks.jump_to_mark_'..upper)
        end
    )
    vim.keymap.set({'n'}, 'm'..lower,
        function()
            register_jump()
            vsc_notify('vim-marks.jump_to_mark_'..lower)
        end
    )
end

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
