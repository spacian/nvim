if not vim.g.vscode then
    require("persisted").setup({
        autosave = false,
        silent = true,
        ignored_dirs = { "oil://", "replacer://" },
    })
    local changing_workspace = false
    vim.api.nvim_create_autocmd(
        { "VimLeavePre", "BufRead", "InsertLeave", "TextChanged", "BufWritePost" },
        {
            pattern = {"*"},
            callback = function()
                if (not changing_workspace)
                    and vim.v.vim_did_enter
                    and (not (vim.bo.buftype == "quickfix"))
                    and (not (vim.bo.buftype == "terminal"))
                    and oil.get_current_dir() == nil
                then
                        require("persisted").save({force = true})
                end
                changing_workspace = false
            end,
        }
    )
end
