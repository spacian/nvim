if not vim.g.vscode then
    require("oil").setup()
    vim.keymap.set("n", "<leader>oe",
        function()
        vim.cmd("silent e .")
        end, { noremap = true })
end
