if not vim.g.vscode then
    require('venv-selector').setup({
        name = {".venv", "venv"},
        search_workspace = false,
        search_venv_managers = false,
        search = true,
        parents = 0,
    })
    vim.keymap.set('n', '<leader>vs', function() vim.cmd('VenvSelect') end)
    vim.keymap.set('n', '<leader>vc', function() vim.cmd('VenvSelectCached') end)
    vim.api.nvim_create_autocmd({ "VimEnter", "SessionLoadPost" }, {
        pattern = {"*"},
        callback = function()
            vim.cmd("silent VenvSelectCached")
        end,
    })
end
