vim.keymap.set({ 'n' }, 'o', 'o.<backspace>', { noremap = true })
vim.keymap.set({ 'n' }, 'O', 'O.<backspace>', { noremap = true })
vim.keymap.set({ 'n' }, '<c-s>', ':w<enter>', { noremap = true })
vim.keymap.set({ '' }, '<c-q>',
    function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname == '' then
            return
        elseif bufname:match("^term://") then
            vim.cmd('bd!')
            return
        else
            vim.cmd('w|bd')
        end
    end, { noremap = true })
vim.keymap.set({ 't' }, '<c-q>', [[<c-\><c-n>:q<enter>]], { noremap = true })
vim.keymap.set({ 't' }, '<c-n>', [[<c-\><c-n>]], { noremap = true })
vim.keymap.set({ '', 'l', 't' }, '<a-h>', [[<c-\><c-n><c-w>h]], { noremap = true })
vim.keymap.set({ '', 'l', 't' }, '<a-j>', [[<c-\><c-n><c-w>j]], { noremap = true })
vim.keymap.set({ '', 'l', 't' }, '<a-k>', [[<c-\><c-n><c-w>k]], { noremap = true })
vim.keymap.set({ '', 'l', 't' }, '<a-l>', [[<c-\><c-n><c-w>l]], { noremap = true })
vim.keymap.set({ '', 'l', 't' }, '<c-a-f>', [[<c-\><c-n><c-w>T]], { noremap = true })
vim.keymap.set({ '', 'l', 't' }, '<c-a-h>', [[<c-\><c-n><c-w>H]], { noremap = true })
vim.keymap.set({ '', 'l', 't' }, '<c-a-j>', [[<c-\><c-n><c-w>J]], { noremap = true })
vim.keymap.set({ '', 'l', 't' }, '<c-a-k>', [[<c-\><c-n><c-w>K]], { noremap = true })
vim.keymap.set({ '', 'l', 't' }, '<c-a-l>', [[<c-\><c-n><c-w>L]], { noremap = true })
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.keymap.set({ 'n' }, '<leader>otw',
        function()
            local buffer_name = vim.api.nvim_buf_get_name(0)
            if
                string.find(buffer_name, "^oil://") ~= nil
                or string.find(buffer_name, "^replacer://") ~= nil
            then
                return
            else
                vim.cmd('vsplit')
                vim.cmd('term')
                vim.fn.feedkeys('a')
                vim.fn.feedkeys(
                    'cls' .. vim.api.nvim_replace_termcodes('<enter>', true, true, true)
                )
            end
        end, { noremap = true })
    vim.keymap.set(
        { 't' },
        '<c-e>',
        [[python -c "import sys; print(sys.executable)"<enter>]],
        { noremap = true }
    )
else
    vim.keymap.set({ 'n' }, '<leader>otw', function()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        if
            string.find(buffer_name, "^oil://") ~= nil
            or string.find(buffer_name, "^replacer://") ~= nil
        then
            return
        else
            vim.cmd('vsplit term://<enter>a')
        end
    end, { noremap = true })
    vim.keymap.set(
        { 't' },
        '<c-e>',
        [[python3 -c "import sys; print(sys.executable)"<enter>]],
        { noremap = true }
    )
end

local letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #letters do
    vim.keymap.set({ 'n' },
        'M' .. letters:sub(i, i):upper(),
        'm' .. letters:sub(i, i),
        { noremap = true })
    vim.keymap.set({ 'n' },
        'm' .. letters:sub(i, i):upper(),
        '`' .. letters:sub(i, i),
        { noremap = true })
    vim.keymap.set({ 'n' },
        'M' .. letters:sub(i, i),
        'm' .. letters:sub(i, i):upper(),
        { noremap = true })
    vim.keymap.set({ 'n' },
        'm' .. letters:sub(i, i),
        '`' .. letters:sub(i, i):upper(),
        { noremap = true })
end
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
    local filter_by = vim.fn.input("filter qflist by type (E/W/I/N): ", "E")
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
vim.keymap.set(
    'n',
    '<leader>otf',
    function()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        if
            string.find(buffer_name, "^oil://") ~= nil
            or string.find(buffer_name, "^replacer://") ~= nil
        then
            return
        else
            local path = vim.fn.expand("%:p:h")
            if vim.loop.os_uname().sysname == "Windows_NT" then
                vim.cmd('vsplit')
                vim.cmd('term')
                local enter = vim.api.nvim_replace_termcodes(
                    "<enter>", true, true, true
                )
                vim.fn.feedkeys('a')
                vim.fn.feedkeys('cd ' .. path:gsub("\\", "/") .. enter)
                vim.fn.feedkeys('cls' .. enter)
            else
                vim.cmd('vsplit term://bash')
                vim.cmd('startinsert')
                vim.cmd('call feedkeys("cd ' .. path .. '\\nclear\\n")')
            end
        end
    end,
    { noremap = true }
)
