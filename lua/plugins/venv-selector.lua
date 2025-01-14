return {
    {
        'linux-cultist/venv-selector.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-telescope/telescope.nvim',
            'mfussenegger/nvim-dap',
            'mfussenegger/nvim-dap-python',
        },
        lazy = false,
        branch = "regexp",
        enabled = not vim.g.vscode,
    },
}
