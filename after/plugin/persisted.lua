if not vim.g.vscode then
    require("persisted").setup({
        autosave = false,
        silent = true,
        ignored_dirs = {"oil:///"},
    })
    require("telescope").load_extension("persisted")
    vim.keymap.set({"n"}, "<leader>ow", ":Telescope persisted<enter>")
    vim.keymap.set({"n"}, "<leader>sw",
        function() require("persisted").save() end
    )
    vim.api.nvim_create_autocmd({ "VimLeavePre", "BufRead" }, {
        pattern = {"*"},
        callback = function()
            require("persisted").save({force = true})
        end,
    })
end
