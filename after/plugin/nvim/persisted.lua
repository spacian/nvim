if not vim.g.vscode then
    require("persisted").setup({
        autosave = false,
        silent = true,
        ignored_dirs = { "oil://", "replacer://" },
    })
    require("telescope").load_extension("persisted")
end
