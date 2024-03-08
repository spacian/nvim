require('remaps.vscode.utils')

vim.keymap.set({'n'}, 'x',
    function()
        register_jump()
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%dx', vim.v.count))
        else
            nvim_feedkeys('x')
        end
    end
)

vim.keymap.set({'i'}, '<escape>',
    function()
        nvim_feedkeys('<escape>')
        register_jump()
        register_jump(1)
    end
)

vim.keymap.set({'n'}, '/',
    function()
        register_jump()
        nvim_feedkeys('/')
    end
)

vim.keymap.set({'n'}, '?',
    function()
        register_jump()
        nvim_feedkeys('?')
    end
)

vim.keymap.set({'n'}, '#',
    function()
        register_jump()
        nvim_feedkeys('#')
    end
)

vim.keymap.set({'n'}, '*',
    function()
        register_jump()
        nvim_feedkeys('*')
    end
)

vim.keymap.set({'n'}, 'gg',
    function()
        register_jump()
        nvim_feedkeys('gg^')
    end
)

vim.keymap.set({'n'}, 'G',
    function()
        register_jump()
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%dG^', vim.v.count))
        else
            nvim_feedkeys('G$')
        end
    end
)
