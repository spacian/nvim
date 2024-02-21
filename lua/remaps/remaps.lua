vim.g.mapleader=' '
vim.keymap.set({'v'}    , 'p'           , '"_dP'               , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>p'   , '"+p'                , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>P'   , '"+P'                , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>y'   , '"+y'                , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>Y'   , '"+y$'               , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>d'   , '"_d'                , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>n'   , ':set hls!<enter>'   , {noremap=true})
-- vim.keymap.set({'i'}    , '<c-l>'       , '<del>'              , {noremap=true})
-- vim.keymap.set({'n'}    , 'o'           , 'o.<backspace>'      , {noremap=true})
-- vim.keymap.set({'n'}    , 'O'           , 'O.<backspace>'      , {noremap=true})
vim.keymap.set({'n','v'}, '<c-t>'       , ''                   , {noremap=true})
vim.keymap.set({'n'}    , 'J'           , 'mzJ`z'              , {noremap=true})
vim.keymap.set({'n'}    , 'K'           , 'a<enter><esc>k$'    , {noremap=true})
vim.keymap.set({'x'}    , '<leader>sub' , '"zy<esc>:%s/<c-r>z/', {noremap=true})
vim.keymap.set({'n','v'}, 'H'           , '^'                  , {noremap=true})
vim.keymap.set({'n','v'}, 'L'           , '$'                  , {noremap=true})
vim.keymap.set({'n'}    , 'gg'          , 'gg0'                , {noremap=true})
vim.keymap.set({'n'}    , 'G'           , 'G$'                 , {noremap=true})
vim.keymap.set({'n'}    , 'yall'        , ':%y<enter>'         , {noremap=true})
vim.keymap.set({'n'}    , '<leader>yall', ':%y+<enter>'        , {noremap=true})
vim.keymap.set({'n','v'}, '<c-j>'       , '5j'                 , {noremap=true})
vim.keymap.set({'n','v'}, '<c-k>'       , '5k'                 , {noremap=true})
vim.keymap.set({'n'}    , '<leader>o'   , ''                   , {noremap=true})
vim.keymap.set({'n'}    , 'gwip'        , 'gwip0'              , {noremap=true})
