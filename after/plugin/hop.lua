local hop = require('hop')
local directions = require('hop.hint').HintDirection
local position = require('hop.hint').HintPosition

hop.setup({ keys = 'kdslaeiowcpnbtyhgruvmfj'})

vim.keymap.set('', 'f',
    function()
        hop.hint_char1({
            direction = directions.AFTER_CURSOR,
            current_line_only = true })
    end, {remap=true})

vim.keymap.set('', 'F',
    function()
        hop.hint_char1({
            direction = directions.BEFORE_CURSOR,
            current_line_only = true })
    end, {remap=true})

vim.keymap.set('', 't',
    function()
        hop.hint_char1({
            direction = directions.AFTER_CURSOR,
            current_line_only = true,
            hint_offset = -1 })
    end, {remap=true})

vim.keymap.set('', 'T',
    function()
        hop.hint_char1({
            direction = directions.BEFORE_CURSOR,
            current_line_only = true,
            hint_offset = 1 })
    end, {remap=true})

vim.keymap.set('', '<leader>e',
    function()
        hop.hint_words({
            direction = directions.AFTER_CURSOR,
            current_line_only = true,
            hint_position = position.END })
    end, {remap=true})

vim.keymap.set('', '<leader>w',
    function()
        hop.hint_words({
            direction = directions.AFTER_CURSOR,
            current_line_only = true })
    end, {remap=true})

vim.keymap.set('', '<leader>jl',
    function()
        hop.hint_lines_skip_whitespace()
    end
)

vim.keymap.set('', '<leader>js',
    function()
        hop.hint_lines()
    end
)

vim.keymap.set('', '<leader>jc',
    function()
        hop.hint_char1()
    end
)

vim.keymap.set('', '<leader>jd',
    function()
        hop.hint_char2()
    end
)

vim.keymap.set('', ',',
    function()
        hop.hint_words()
    end
)

vim.keymap.set('', '<leader>,',
    function()
        hop.hint_words({ hint_position = position.END })
    end
)

vim.keymap.set('', '<leader>jp',
    function()
        hop.hint_patterns()
    end
)

vim.keymap.set('', '<leader>ja',
    function()
        hop.hint_anywhere()
    end
)
