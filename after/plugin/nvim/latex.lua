if not vim.g.vscode then
    local cmp = require('cmp')
    cmp.setup.filetype("tex", {
        sources = {
            { name = 'vimtex' },
            { name = 'buffer' },
        },
    })
    vim.g.vimtex_compiler_latexmk = { out_dir = 'build' }
end
