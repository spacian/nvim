if not vim.g.vscode then
    require("replacer").setup({ rename_files = false })
    vim.keymap.set("n", "<leader>m",
        function()
            if vim.bo.buftype == "quickfix" then
                require("replacer").run()
            else
                print("replacer: Not a quickfix buffer.")
            end
        end, { silent = true }
    )
end
