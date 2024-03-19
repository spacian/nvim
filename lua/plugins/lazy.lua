local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {
        "kylechui/nvim-surround",
        version = "*",
    },
    {
        "gbprod/substitute.nvim",
        version = "*",
        opts = {},
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {},
    },
    {
        "olimorris/persisted.nvim",
        lazy = false,
        config = true,
        enabled = not vim.g.vscode,
    },
    {
        "stevearc/oil.nvim",
        version = "*",
        opts = {},
        enabled = not vim.g.vscode,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.6',
        dependencies = { "nvim-lua/plenary.nvim" },
        enabled = not vim.g.vscode,
    },
    {
        "neovim/nvim-lspconfig",
        version = "*",
        enabled = not vim.g.vscode,
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
         },
        enabled = not vim.g.vscode,
    },
    {
        "cbochs/grapple.nvim",
        version = "*",
        enabled = not vim.g.vscode,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        version = "*",
        enabled = not vim.g.vscode,
    },
    {
        "rebelot/kanagawa.nvim",
        version = "*",
        enabled = not vim.g.vscode,
    },
    {
        "kdheepak/lazygit.nvim",
    	cmd = {
    		"LazyGit",
    		"LazyGitConfig",
    		"LazyGitCurrentFile",
    		"LazyGitFilter",
    		"LazyGitFilterCurrentFile",
    	},
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
})
