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
    },
    {
        "gbprod/substitute.nvim",
    },
    {
        'smoka7/hop.nvim',
    },
    {
        "olimorris/persisted.nvim",
        lazy = false,
        config = true,
        enabled = not vim.g.vscode,
    },
    {
        "stevearc/oil.nvim",
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
        enabled = not vim.g.vscode,
    },
    {
        "nvim-treesitter/nvim-treesitter",
    },
    {
        "rebelot/kanagawa.nvim",
        enabled = not vim.g.vscode,
    },
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        enabled = not vim.g.vscode,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = not vim.g.vscode,
    },
    {
        "EdenEast/nightfox.nvim",
        enabled = not vim.g.vscode,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
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
        dependencies = { "nvim-lua/plenary.nvim", },
        enabled = not vim.g.vscode,
    },
    {
        'linux-cultist/venv-selector.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-telescope/telescope.nvim',
            'mfussenegger/nvim-dap-python',
        },
        enabled = not vim.g.vscode,
    },
    {
        'lervag/vimtex',
        init = function() end,
        enabled = not vim.g.vscode,
    },
    {
        "micangl/cmp-vimtex",
        enabled = not vim.g.vscode,
    },
    {
        "jiaoshijie/undotree",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = { { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" }, },
        enabled = not vim.g.vscode,
    },
    {
        'numToStr/Comment.nvim',
        lazy = false,
        enabled = not vim.g.vscode,
    },
    {
        'gabrielpoca/replacer.nvim',
        enabled = not vim.g.vscode,
    },
})
