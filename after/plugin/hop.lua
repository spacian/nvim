local hop = require('hop')
local directions = require('hop.hint').HintDirection
local position = require('hop.hint').HintPosition

hop.setup({ keys = 'kdslaeiowcpnbtyhgruvmfj'})

vim.keymap.set({'n', 'v'}, '<leader>,',
    function()
        hop.hint_char2()
    end
)

vim.keymap.set({'n', 'v'}, '<leader>;',
    function()
        hop.hint_camel_case()
    end
)
