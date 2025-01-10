vim.api.nvim_create_autocmd(
    {
        "BufWritePre",
    },
    {
        pattern = "*",
        callback = function()
            local buffer_name = vim.api.nvim_buf_get_name(0)
            if
                vim.bo.readonly
                or not (vim.bo.modifiable and vim.bo.modified)
                or string.find(buffer_name, "^oil://") ~= nil
                or string.find(buffer_name, "^replacer://") ~= nil
            then
                return
            end
            local save_cursor = vim.fn.getpos(".")
            pcall(function() vim.cmd([[%s/\s\+$//e]]) end)
            if vim.bo.filetype == "lua" then
                local clients = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
                for _, client in ipairs(clients) do
                    if client.server_capabilities.documentFormattingProvider then
                        vim.lsp.buf.format({ async = false })
                        break
                    end
                end
            end
            vim.fn.setpos(".", save_cursor)
        end,
    }
)
