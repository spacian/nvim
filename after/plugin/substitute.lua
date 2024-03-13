require('remaps.vscode.utils')

vim.keymap.set("n", "<leader>s",
    function()
        register_jump()
        register_jump(1)
        require('substitute').operator()
    end, { noremap = true }
)

vim.keymap.set("n", "<leader>S",
    function()
        register_jump()
        register_jump(1)
        require('substitute').eol()
    end, { noremap = true }
)

vim.keymap.set("n", "<leader>ss",
    function()
        register_jump()
        register_jump(1)
        require('substitute').line()
    end, { noremap = true }
)

vim.keymap.set("x", "<leader>s",
    function()
        register_jump()
        register_jump(1)
        require('substitute').visual()
    end, { noremap = true }
)
