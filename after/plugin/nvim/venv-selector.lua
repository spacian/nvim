if not vim.g.vscode then
    require('venv-selector').setup({
        name = { ".venv", "venv" },
        search_workspace = true,
        search_venv_managers = false,
        search = true,
        parents = 0,
        notify_user_on_activate = false,
    })
    vim.keymap.set('n', '<leader>vs', function() vim.cmd('VenvSelect') end)
    vim.keymap.set('n', '<leader>vc', function()
        print(require('venv-selector').venv())
    end)
end
