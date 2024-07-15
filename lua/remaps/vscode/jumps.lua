require('remaps.vscode.utils')

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

vim.api.nvim_create_autocmd(
    { 'InsertLeave' },
    {
        pattern = '*',
        callback = function()
            register_jump()
            register_jump(1)
        end
  }
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
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%dgg^', vim.v.count))
        else
            nvim_feedkeys('gg^')
        end
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

vim.keymap.set({'n'}, 'U',
    function()
        register_jump()
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%dU', vim.v.count))
        else
            nvim_feedkeys('U')
        end
        register_jump()
        register_jump(1)
    end
)

vim.keymap.set({'n'}, 'u',
    function()
        register_jump()
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%du', vim.v.count))
        else
            nvim_feedkeys('u')
        end
        register_jump()
        register_jump(1)
    end
)

vim.keymap.set({'n'}, '<c-r>',
    function()
        register_jump()
        if vim.v.count > 0 then
            nvim_feedkeys(string.format('%d<c-r>', vim.v.count))
        else
            nvim_feedkeys('<c-r>')
        end
        register_jump()
        register_jump(1)
    end
)
