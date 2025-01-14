if not vim.g.vscode then
    require('telescope').load_extension('file_browser')
    vim.keymap.set({ 'n' }, '<leader>onP', function()
        vim.cmd('SessionStop')
        vim.cmd('Telescope file_browser path=C:/Users/mark_ro/DLR/Projekte/software_development')
    end)
    vim.keymap.set({ 'n' }, '<leader>oF', function()
        vim.cmd('Telescope file_browser')
    end)
end
