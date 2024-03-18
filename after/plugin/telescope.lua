if not vim.g.vscode then
    require('telescope').setup(
        {
            defaults = {
                layout_config = {
                    horizontal = {
                        preview_cutoff = 0,
                        height = 0.999999,
                        width = 0.999999,
                    },
                },
            },
        }
    )
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>of',
    function()
        builtin.find_files()
    end, {})
    vim.keymap.set('n', '<leader>fg', function()
        builtin.git_files()
    end,  {})
    vim.keymap.set('n', '<leader>ff', function()
        builtin.live_grep()
    end,  {})
end
