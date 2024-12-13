require('remaps.vscode.utils')
require('remaps.vscode.jumps')

vim.keymap.set({'n'}, '<c-o>', jump_back, {noremap=true})
vim.keymap.set({'n'}, '<c-i>', jump_forw, {noremap=true})

local do_wrap = true

function wrap_jk()
    vim.keymap.set({'n'}, 'I',
        function()
            vsc_notify('cursorMove', {
                args={to='wrappedLineStart'}
            })
            nvim_feedkeys('i')
        end
    )
    vim.keymap.set({'n'}, 'A',
        function()
            vsc_notify('cursorMove', {
                args={to='wrappedLineEnd'}
            })
            nvim_feedkeys('a')
        end
    )
    vim.keymap.set({'n'}, 'H',
        function()
            vsc_notify('cursorMove', {
                args={to='wrappedLineStart'}
            })
        end
    )
    vim.keymap.set({'n'}, 'L',
        function()
            vsc_notify('cursorMove', {
                args={to='wrappedLineEnd'}
            })
        end
    )
    vim.keymap.set({'n'}, 'j',
        function()
            vsc_notify('cursorMove', {
                args={to='down', by='wrappedLine', value=vim.v.count+1}
            })
        end
    )
    vim.keymap.set({'n'}, 'k',
        function()
            vsc_notify('cursorMove', {
                args={to='up', by='wrappedLine', value=vim.v.count}
            })
        end
    )
end

function unwrap_jk()
    vim.keymap.set({'n'}, 'j', 'j')
    vim.keymap.set({'n'}, 'k', 'k')
    vim.keymap.set({'n'}, 'L', '$')
    vim.keymap.set({'n'}, 'H', '^')
    vim.keymap.set({'n'}, 'A', 'A')
    vim.keymap.set({'n'}, 'I', 'I')
end

vim.keymap.set({'n'}, 'gwrap',
    function()
        if do_wrap then
            print("wrapped line navigation: enabled ")
            wrap_jk()
        else
            print("wrapped line navigation: disabled")
            unwrap_jk()
        end
        do_wrap = not do_wrap
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

vim.keymap.set({'n'}, '<leader>ah',
    function()
        vsc_notify('vscode-harpoon.addEditor')
    end
)

vim.keymap.set({'n'}, '<leader>aj',
    function()
        vsc_notify('vscode-harpoon.addEditor1')
    end
)

vim.keymap.set({'n'}, '<leader>ak',
    function()
        vsc_notify('vscode-harpoon.addEditor2')
    end
)

vim.keymap.set({'n'}, '<leader>al',
    function()
        vsc_notify('vscode-harpoon.addEditor3')
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
