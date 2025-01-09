if not vim.g.vscode then
    require("persisted").setup({
        autosave = false,
        silent = true,
        ignored_dirs = { "oil://", "replacer://" },
    })
    require("telescope").load_extension("persisted")
    vim.keymap.set({ "n" }, "<leader>oP",
        function()
            if oil.get_current_dir() ~= nil
                or vim.fn.expand("%:p") == "replacer://replacer"
            then
                vim.cmd("bd!")
            end
            vim.cmd("Telescope persisted")
        end
    )
    vim.api.nvim_create_autocmd(
        { "VimLeavePre", "InsertLeave", "TextChanged", "BufWritePost" },
        {
            pattern = { "*" },
            callback = function()
                if not (
                        vim.bo.buftype == "quickfix"
                        or vim.bo.buftype == "terminal"
                        or oil.get_current_dir() == nil)
                then
                    require("persisted").save({ force = true })
                end
            end,
        }
    )
end
