require('remaps.vscode_utils')

vim.keymap.set({'n'}, 'i',
    function()
        register_jump()
        nvim_feedkeys('i')
    end
)

vim.keymap.set({'n'}, 'I',
    function()
        register_jump()
        nvim_feedkeys('I')
    end
)

vim.keymap.set({'n'}, 'a',
    function()
        register_jump()
        nvim_feedkeys('a')
    end
)

vim.keymap.set({'n'}, 'A',
    function()
        register_jump()
        nvim_feedkeys('A')
    end
)

vim.keymap.set({'n'}, 'o',
    function()
        register_jump()
        nvim_feedkeys('o')
    end
)

vim.keymap.set({'n'}, 'O',
    function()
        register_jump()
        nvim_feedkeys('O')
    end
)

vim.keymap.set({'n'}, 's',
    function()
        register_jump()
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%ds', vim.v.count))
        else
            nvim_feedkeys('s')
        end
    end
)

vim.keymap.set({'n'}, 'S',
    function()
        register_jump()
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%dS', vim.v.count))
        else
            nvim_feedkeys('S')
        end
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
        nvim_feedkeys('G$')
    end
)
