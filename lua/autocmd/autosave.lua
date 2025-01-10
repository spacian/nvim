vim.api.nvim_create_autocmd(
    { 'VimLeave', 'BufLeave', 'FocusLost' },
    {
        pattern = '*',
        callback = function()
            local buffer_name = vim.api.nvim_buf_get_name(0)
            if
                vim.bo.readonly
                or buffer_name == ''
                or vim.bo.buftype ~= ''
                or not (vim.bo.modifiable and vim.bo.modified)
                or string.find(buffer_name, "^oil://") ~= nil
                or string.find(buffer_name, "^replacer://") ~= nil
            then
                return
            end
            vim.cmd('doau BufWritePre')
            vim.cmd('silent w')
            vim.cmd('doau BufWritePost')
        end
    }
)
