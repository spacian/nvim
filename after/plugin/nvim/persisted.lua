if not vim.g.vscode then
    require("persisted").setup({
        autosave = false,
        silent = true,
        ignored_dirs = { "oil://", "replacer://" },
    })
    require("telescope").load_extension("persisted")
    vim.keymap.set({ "n" }, "<leader>oP",
        function()
            local buffer_name = vim.api.nvim_buf_get_name(0)
            if
                string.find(buffer_name, "^oil://") ~= nil
                or string.find(buffer_name, "^replacer://") ~= nil
            then
                vim.cmd("bd!")
            end
            vim.cmd("Telescope persisted")
        end
    )
    vim.api.nvim_create_autocmd(
        { "VimLeavePre", "InsertLeave", "TextChanged", "BufWritePost" },
        {
            callback = function()
                local buffer_name = vim.api.nvim_buf_get_name(0)
                if
                    not (vim.bo.buftype == "quickfix"
                        or vim.bo.buftype == "terminal")
                    and string.find(buffer_name, "^oil://") ~= nil
                    and string.find(buffer_name, "^replacer://") ~= nil
                then
                    require("persisted").save({ force = true })
                end
            end,
        }
    )
end
