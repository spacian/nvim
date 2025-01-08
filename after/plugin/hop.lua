local hop = require('hop')
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
