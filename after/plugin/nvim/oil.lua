if not vim.g.vscode then
    oil = require("oil")
    oil.setup({
        keymaps = {
            ["<enter>"] = "actions.select",
            ["<c-p>"] = "actions.preview",
            ["-"] = "actions.parent",
            ["<leader>r"] = "actions.refresh",
        },
        use_default_keymaps = false,
        view_options = {
            show_hidden = true,
        },
    })
    vim.keymap.set("n", "<leader>oe",
        function()
            local bufname = vim.fn.expand("%")
            if bufname ~= "" then
                vim.cmd("silent e %:h")
            else
                vim.cmd("silent e .")
            end
        end, { noremap = true })
    vim.keymap.set("n", "<leader>cd",
        function()
            local cwd = oil.get_current_dir()
            if cwd ~= nil then
                vim.cmd("cd " .. cwd)
            else
                vim.cmd("cd %:p:h")
            end
            print("current working directory: "..vim.fn.getcwd())
        end, { noremap = true })
    vim.keymap.set(
        'n',
        '<leader>otf',
        function()
            local cwd = oil.get_current_dir()
            if cwd == nil then
                local path = vim.fn.expand("%:p:h")
                if vim.loop.os_uname().sysname == "Windows_NT" then
                    print('windows')
                    vim.cmd('vsplit')
                    vim.cmd('term')
                    local enter = vim.api.nvim_replace_termcodes(
                        "<enter>", true, true, true
                    )
                    vim.fn.feedkeys('a')
                    vim.fn.feedkeys('cd ' .. path:gsub("\\", "/") .. enter)
                    vim.fn.feedkeys('cls' .. enter)
                else
                    vim.cmd('vsplit term://bash')
                    vim.cmd('startinsert')
                    vim.cmd('call feedkeys("cd ' .. path .. '\\nclear\\n")')
                end
            end
        end,
        {noremap=true}
    )
end
