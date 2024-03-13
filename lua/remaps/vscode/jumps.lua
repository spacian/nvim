require('remaps.vscode.utils')

vim.keymap.set({'n'}, 'd',
    function()
        register_jump()
        register_jump(1)
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%dd', vim.v.count))
        else
            nvim_feedkeys('d')
        end
    end
)

vim.keymap.set({'n'}, 'D',
    function()
        register_jump()
        register_jump(1)
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%dD', vim.v.count))
        else
            nvim_feedkeys('D')
        end
    end
)

vim.keymap.set({'n'}, 'r',
    function()
        register_jump()
        register_jump(1)
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%dr', vim.v.count))
        else
            nvim_feedkeys('r')
        end
    end
)

vim.keymap.set({'n'}, 'R',
    function()
        register_jump()
        register_jump(1)
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%dR', vim.v.count))
        else
            nvim_feedkeys('R')
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
