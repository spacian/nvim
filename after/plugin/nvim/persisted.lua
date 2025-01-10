if not vim.g.vscode then
    local persisted = require('persisted')
    persisted.setup({
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
                print('cannot open new session from this buffer')
                return
            end
            vim.cmd("Telescope persisted")
        end
    )
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
            vim.cmd('Telescope persisted')
        end
    })
    vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedTelescopeLoadPre",
        callback = function(session)
            require("persisted").save({ session = vim.g.persisted_loaded_session })
            vim.cmd('%bd!')
        end,
    })
    vim.api.nvim_create_autocmd(
        { "VimLeavePre", "BufEnter", "TextChanged", "BufWritePost" },
        {
            callback = function()
                local buffer_name = vim.api.nvim_buf_get_name(0)
                if
                    not (vim.bo.buftype == "quickfix")
                    and not (vim.bo.buftype == "terminal")
                    and string.find(buffer_name, "^oil://") == nil
                    and string.find(buffer_name, "^replacer://") == nil
                then
                    persisted.save({ force = true })
                end
            end,
        }
    )
end
