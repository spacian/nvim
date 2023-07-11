vim.g.mapleader=' '
vim.keymap.set({'n','v'}, '<leader><space>'	, ':'               , {noremap=true, silent=true,   })
vim.keymap.set({'n'}    , '<enter>'	        , 'a<enter><esc>l'  , {noremap=true, silent=true,   })
vim.keymap.set({'n'}    , '<leader><enter>'	, 'i<enter><esc>l'  , {noremap=true, silent=true,   })
vim.keymap.set({'n','v'}, '<leader>n'       , ':nohl<enter>'    , {noremap=true, silent=true,   })
vim.keymap.set({'n','v'}, '<leader>p'       , '"_dp'            , {noremap=true, silent=true,   })
vim.keymap.set({'n','v'}, '<leader>d'       , '"_d'             , {noremap=true,                })
vim.keymap.set({'i'}    , '<c-p>'           , '<c-o>p'          , {noremap=true,                })
vim.keymap.set({'i'}    , '<c-l>'           , '<del>'           , {noremap=true,                })
vim.keymap.set({'v'}    , 'v'               , 'iw'              , {noremap=true,                })
vim.keymap.set({'n'}    , 'o'               , 'o.<backspace>'   , {noremap=true,                })
vim.keymap.set({'n'}    , 'O'               , 'O.<backspace>'   , {noremap=true,                })
vim.keymap.set({'n','v'}, 'q'               , ''                , {noremap=true,                })
vim.keymap.set({'n','v'}, 'Q'               , ''                , {noremap=true,                })
vim.keymap.set({'n','v'}, 'J'               , 'J^'              , {noremap=true,                })
