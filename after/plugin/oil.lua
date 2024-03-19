if not vim.g.vscode then
    oil = require("oil")
    oil.setup({
        keymaps = {
            ["<enter>"] = "actions.select",
            ["<c-p>"] = "actions.preview",
            ["-"] = "actions.parent",
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
end
