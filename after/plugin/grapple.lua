if not vim.g.vscode then
    local grapple = require("grapple")
    grapple.setup({ icons = false })
    vim.keymap.set('n', '<leader>a', function() vim.cmd("Grapple tag") end)
    vim.keymap.set('n', '<leader>oh', function() require("grapple").open_tags() end)
    vim.keymap.set('n', '<leader>h', ":Grapple select index=1<enter>")
    vim.keymap.set('n', '<leader>j', ":Grapple select index=2<enter>")
    vim.keymap.set('n', '<leader>k', ":Grapple select index=3<enter>")
    vim.keymap.set('n', '<leader>l', ":Grapple select index=4<enter>")
end
