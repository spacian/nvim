if not vim.g.vscode then
    require('telescope').setup(
        {
            defaults = {
                layout_config = {
                    horizontal = {
                        preview_cutoff = 0,
                        height = { padding=0 },
                        width = { padding=0 },
                    },
                },
                mappings = {
                    i = {
                        ["<c-j>"] = require('telescope.actions').move_selection_next,
                        ["<c-k>"] = require('telescope.actions').move_selection_previous,
                    },
                },
            },
        }
    )
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>of', builtin.find_files)
    vim.keymap.set('n', '<leader>fg', builtin.git_files)
    vim.keymap.set('n', '<leader>ff', builtin.live_grep)
    vim.keymap.set('n', '<leader>fw', builtin.grep_string)
    vim.keymap.set('n', 'gr', builtin.lsp_references)
    vim.keymap.set('n', 'gd', builtin.lsp_definitions)
    vim.keymap.set('n', 'gD', builtin.lsp_type_definitions)
    vim.keymap.set('n', '<leader>osf', builtin.lsp_document_symbols)
    vim.keymap.set('n', '<leader>osw', builtin.lsp_dynamic_workspace_symbols)
    vim.keymap.set('n', '<leader>or', builtin.oldfiles)
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find)
    vim.keymap.set('n', '<leader>otl', builtin.resume)
    vim.keymap.set('n', '<leader>ocs', builtin.colorscheme)
    vim.keymap.set('n', '<leader>oj', builtin.jumplist)
    vim.keymap.set('n', '<leader>oqf', builtin.quickfix)
    vim.keymap.set('n', '<leader>oqh', builtin.quickfixhistory)
end
