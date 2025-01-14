return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = 'v3.x',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
        },
        enabled = not vim.g.vscode,
    },
}
