require('remaps.vscode.utils')

vim.api.nvim_create_autocmd(
    { 'InsertLeave', 'TextChanged' },
    {
        pattern = '*',
        callback = function()
            register_jump()
            register_jump(1)
        end
    }
)

jump_keys = {
    ['/'] = '',
    ['?'] = '',
    ['#'] = '',
    ['*'] = '',
    ['gg'] = 'gg^',
    ['G'] = 'G$',
    ['<c-r>'] = '',
    ['u'] = '',
    ['U'] = ''
}

for key, map in pairs(jump_keys) do
    if string.len(map) == 0 then
        map = key
    end
    vim.keymap.set({ 'n' }, key,
        function()
            register_jump()
            if vim.v.count > 0 then
                nvim_feedkeys(vim.v.count .. map)
            else
                nvim_feedkeys(map)
            end
        end
    )
end
