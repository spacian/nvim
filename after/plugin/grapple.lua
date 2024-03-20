if not vim.g.vscode then
    local grapple = require("grapple")
    grapple.setup({ icons = false })
    vim.keymap.set('n', '<leader>a', function() vim.cmd("silent Grapple tag") end)
    vim.keymap.set('n', '<leader>oh', function() require("grapple").open_tags() end)
    vim.keymap.set('n', '<c-n>', function() grapple.cycle("forward") end)
    vim.keymap.set('n', '<c-p>', function() grapple.cycle("backward") end)
    vim.keymap.set('n', '<c-j>', ":Grapple select index=1<enter>")
    vim.keymap.set('n', '<c-k>', ":Grapple select index=2<enter>")
    vim.keymap.set('n', '<c-l>', ":Grapple select index=3<enter>")
end
