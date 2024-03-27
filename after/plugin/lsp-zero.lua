if not vim.g.vscode then
    local lsp_zero = require('lsp-zero')
    lsp_zero.on_attach(
        function(client, bufnr)
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
            lsp_zero.default_keymaps({buffer = bufnr})
        end
    )
    local cmp = require('cmp')
    local cmp_format = require('lsp-zero').cmp_format({details = true})
    cmp.setup({
        formatting = cmp_format,
        mapping = {
            ['<c-l>'] = cmp.mapping(
                function()
                    if cmp.visible() then
                        cmp.confirm({select = true})
                    else
                        cmp.complete()
                    end
                end
            ),
            ['<c-h>'] = cmp.mapping.abort(),
            ['<c-k>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
            ['<c-j>'] = cmp.mapping.select_next_item({behavior = 'select'}),
            ['<c-u>'] = cmp.mapping.scroll_docs(-4),
            ['<c-d>'] = cmp.mapping.scroll_docs(4),
        },
    })
    end
