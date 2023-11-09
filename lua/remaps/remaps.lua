vim.g.mapleader=' '
vim.keymap.set({'v'}    , 'p'               , '"_dP'               , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>p'       , '"+p'                , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>y'       , '"+y'                , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>d'       , '"_d'                , {noremap=true})
vim.keymap.set({'n','v'}, '<leader>n'       , ':nohl<enter>'       , {noremap=true})
vim.keymap.set({'i'}    , '<c-l>'           , '<del>'              , {noremap=true})
vim.keymap.set({'n'}    , 'o'               , 'o.<backspace>'      , {noremap=true})
vim.keymap.set({'n'}    , 'O'               , 'O.<backspace>'      , {noremap=true})
vim.keymap.set({'n','v'}, 'q'               , ''                   , {noremap=true})
vim.keymap.set({'n','v'}, 'Q'               , ''                   , {noremap=true})
vim.keymap.set({'n','v'}, 'J'               , 'mzJ`z'              , {noremap=true})
vim.keymap.set({'n','v'}, 'K'               , 'a<enter><esc>k$'    , {noremap=true})
vim.keymap.set({'x'}    , '<leader>sub'     , '"zy<esc>:%s/<c-r>z/', {noremap=true})
vim.keymap.set({'n','v'}, 'H'               , '^'                  , {noremap=true})
vim.keymap.set({'n','v'}, 'L'               , '$'                  , {noremap=true})
vim.keymap.set({'n','v'}, 'gg'              , 'gg0'                , {noremap=true})
vim.keymap.set({'n','v'}, 'G'               , 'G$'                 , {noremap=true})
vim.keymap.set({'n'}    , 'yall'            , ':%y<enter>'         , {noremap=true})
vim.keymap.set({'n'}    , '<leader>yall'    , ':%y+<enter>'        , {noremap=true})
