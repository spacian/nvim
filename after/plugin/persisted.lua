if not vim.g.vscode then
    require("persisted").setup({
        autosave = true,
        silent = true,
        ignored_dirs = {"oil:///"},
    })
    require("telescope").load_extension("persisted")
    vim.keymap.set({"n"}, "<leader>ow", ":Telescope persisted<enter>")
    vim.keymap.set({"n"}, "<leader>sw", 
        function() require("persisted").save() end
    )
end
