if not vim.g.vscode then
    vim.api.nvim_create_autocmd(
        'BufWritePost',
        {
          pattern = '*.py',
          callback = function()
            vim.cmd('silent !isort %:p')
            vim.cmd('silent !black %:p')
          end,
        }
    )
end
