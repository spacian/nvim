if not vim.g.vscode then
    require("persisted").setup({autosave = false})
    require("telescope").load_extension("persisted")
    vim.keymap.set({"n"}, "<leader>ow", ":Telescope persisted<enter>", {noremap=true})
    vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        pattern = {"*"},
        callback = function()
            require("persisted").save({force = true})
        end,
    })
end
