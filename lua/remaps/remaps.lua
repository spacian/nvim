vim.g.mapleader = ' '
vim.keymap.set({ 'n', 'v' }, '<leader><leader>', '', { noremap = true })
vim.keymap.set({ 'v' }, 'p', '"_dP', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+y$', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>n', ':set hls!<enter>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<c-t>', '', { noremap = true })
vim.keymap.set({ 'n' }, 'J', 'mzJ`z', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'H', '^', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { noremap = true })
vim.keymap.set({ 'n' }, 'gg', 'gg0', { noremap = true })
vim.keymap.set({ 'n' }, 'G', 'G$', { noremap = true })
vim.keymap.set({ 'n' }, 'yall', ':%y<enter>', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>yall', ':%y+<enter>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<c-d>', '10j', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<c-u>', '10k', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>o', '', { noremap = true })
vim.keymap.set({ 'n' }, 'gwip', 'gwip0', { noremap = true })
vim.keymap.set({ 'n' }, 'gwl', 'gwl0', { noremap = true })
vim.keymap.set({ 'x' }, 'gw', 'gw0', { noremap = true })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>qq', function()
    vim.cmd('cexpr []')
    vim.diagnostic.setqflist({ open = true })
end)
vim.keymap.set('n', '<leader>qfd', function()
    local qf = vim.fn.getqflist()
    local filtered = {}
    local filter_by = vim.fn.input("filter qflist by description: ")
    for _, item in ipairs(qf) do
        if item.text:match(filter_by) then
            table.insert(filtered, item)
        end
    end
    vim.fn.setqflist(filtered)
end)
vim.keymap.set('n', '<leader>qft', function()
    local qf = vim.fn.getqflist()
    local filtered = {}
    local filter_by = vim.fn.input("filter qflist by type ([E]/W/H): ")
    for _, item in ipairs(qf) do
        if item.type:match(filter_by) then
            table.insert(filtered, item)
        end
    end
    vim.fn.setqflist(filtered)
end)
vim.keymap.set('n', '<leader>qff', function()
    local qf = vim.fn.getqflist()
    local filtered = {}
    local filter_by = vim.fn.input("filter qflist by file: ")
    for _, item in ipairs(qf) do
        local bufnr = tonumber(item.bufnr)
        if bufnr ~= nil and vim.api.nvim_buf_get_name(bufnr):match(filter_by) then
            table.insert(filtered, item)
        end
    end
    vim.fn.setqflist(filtered)
end)
