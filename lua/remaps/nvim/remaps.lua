vim.keymap.set({'n'}, 'o', 'o.<backspace>', {noremap=true})
vim.keymap.set({'n'}, 'O', 'O.<backspace>', {noremap=true})
vim.keymap.set({'n'}, '<c-s>', ':w<enter>', {noremap=true})
vim.keymap.set({''}, '<c-j>', '10jzz', {noremap=true})
vim.keymap.set({''}, '<c-k>', '10kzz', {noremap=true})
vim.keymap.set({''}, '<c-d>', '}zz', {noremap=true})
vim.keymap.set({''}, '<c-u>', '{zz', {noremap=true})
vim.keymap.set({''}, '<c-q>', ':w<enter>:bd<enter>', {noremap=true})
vim.keymap.set({'', 'l', 't'}, '<a-q>', [[<c-\><c-n>:q<enter>]], {noremap=true})
vim.keymap.set({'', 'l', 't'}, '<a-h>', [[<c-\><c-n><c-w>h]], {noremap=true})
vim.keymap.set({'', 'l', 't'}, '<a-j>', [[<c-\><c-n><c-w>j]], {noremap=true})
vim.keymap.set({'', 'l', 't'}, '<a-k>', [[<c-\><c-n><c-w>k]], {noremap=true})
vim.keymap.set({'', 'l', 't'}, '<a-l>', [[<c-\><c-n><c-w>l]], {noremap=true})
vim.keymap.set({'', 'l', 't'}, '<c-a-h>', [[<c-\><c-n><c-w>H]], {noremap=true})
vim.keymap.set({'', 'l', 't'}, '<c-a-j>', [[<c-\><c-n><c-w>J]], {noremap=true})
vim.keymap.set({'', 'l', 't'}, '<c-a-k>', [[<c-\><c-n><c-w>K]], {noremap=true})
vim.keymap.set({'', 'l', 't'}, '<c-a-l>', [[<c-\><c-n><c-w>L]], {noremap=true})
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.keymap.set({'n'}, '<leader>otw',
        function()
            vim.cmd('vsplit')
            vim.cmd('term')
            vim.fn.feedkeys('a')
            vim.fn.feedkeys(
                'cls' .. vim.api.nvim_replace_termcodes('<enter>', true, true, true)
            )
        end, {noremap=true})
    vim.keymap.set(
        {'t'},
        '<a-e>',
        [[python -c "import sys; print(sys.executable)"<enter>]],
        {noremap=true}
    )
else
    vim.keymap.set({'n'}, '<leader>otw', ':vsplit term://<enter>a', {noremap=true})
    vim.keymap.set(
        {'t'},
        '<a-e>',
        [[python3 -c "import sys; print(sys.executable)"<enter>]],
        {noremap=true}
    )
end
