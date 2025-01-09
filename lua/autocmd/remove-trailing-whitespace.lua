vim.api.nvim_create_autocmd(
    {
        "BufWritePre",
    },
    {
        pattern = "*",
        callback = function()
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
