vim.api.nvim_create_autocmd(
    { 'VimLeave', 'BufLeave', 'FocusLost' },
    {
        pattern = '*',
        callback = function()
            if
                vim.bo.readonly
                or vim.api.nvim_buf_get_name(0) == ''
                or vim.bo.buftype ~= ''
                or not (vim.bo.modifiable and vim.bo.modified)
            then
                return
            end
            vim.cmd('doau BufWritePre')
            vim.cmd('silent w')
            vim.cmd('doau BufWritePost')
        end
  }
)

vim.api.nvim_create_autocmd(
    { 'VimEnter', 'SessionLoadPost' },
    {
        pattern = '*',
        callback = function()
            local exists = false
            local cwd = vim.fn.getcwd()
            local folders = vim.lsp.buf.list_workspace_folders()
            for i = 1, #folders do
                if folders[i] == cwd then
                    exists = true
                else
                    vim.lsp.buf.remove_workspace_folder(folders[i])
                end
            end
            if not exists then
                vim.lsp.buf.add_workspace_folder(vim.fn.getcwd())
            end
            require('venv-selector').retrieve_from_cache()
        end
  }
)
