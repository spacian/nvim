local hop = require('hop')
hop.setup({})

local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})

vim.keymap.set({'n'}, '<leader>l',
    function()
        hop.hint_lines_skip_whitespace()
    end
)

vim.keymap.set({'n'}, '<leader>c',
    function()
        hop.hint_char1()
    end
)

vim.keymap.set({'n'}, '<leader>jd',
    function()
        hop.hint_char2()
    end
)

vim.keymap.set({'n'}, '<leader>w',
    function()
        hop.hint_words()
    end
)

vim.keymap.set({'n'}, '<leader>jp',
    function()
        hop.hint_patterns()
    end
)

vim.keymap.set({'n'}, '<leader>ja',
    function()
        hop.hint_anywhere()
    end
)
