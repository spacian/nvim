if not vim.g.vscode then
    require("persisted").setup({
        autosave = true,
        silent = true,
    })
    require("telescope").load_extension("persisted")
    vim.keymap.set({"n"}, "<leader>ow", ":Telescope persisted<enter>", {noremap=true})
end
