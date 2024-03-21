vim.keymap.set({'n'}, '<enter>' , 'o.<backspace><esc>', {noremap=true})
vim.keymap.set({'n'}, 'o', 'o.<backspace>', {noremap=true})
vim.keymap.set({'n'}, 'O', 'O.<backspace>', {noremap=true})
vim.keymap.set({'n'}, '<c-s>', ':w<enter>', {noremap=true})
vim.keymap.set({'t'}, '<a-q>', [[<c-\><c-n>:q<enter>]], {noremap=true})
vim.keymap.set('', '<a-h>', [[<c-\><c-n><c-w>h]], {noremap=true})
vim.keymap.set('', '<a-j>', [[<c-\><c-n><c-w>j]], {noremap=true})
vim.keymap.set('', '<a-k>', [[<c-\><c-n><c-w>k]], {noremap=true})
vim.keymap.set('', '<a-l>', [[<c-\><c-n><c-w>l]], {noremap=true})
vim.keymap.set(
    {'t'},
    '<a-e>',
    [[python3 -c "import sys; print(sys.executable)"<enter>]],
    {noremap=true}
)
vim.keymap.set({'n'}, '<leader>otw', ':vsplit term://bash<enter>a', {noremap=true})
