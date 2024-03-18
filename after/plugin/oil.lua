if not vim.g.vscode then
    require("oil").setup({
        keymaps = {
            ["<enter>"] = "actions.select",
            ["<c-p>"] = "actions.preview",
            ["-"] = "actions.parent",
        },
        use_default_keymaps = false,
    })
    vim.keymap.set("n", "<leader>oe",
        function()
        vim.cmd("silent e .")
        end, { noremap = true })
end
