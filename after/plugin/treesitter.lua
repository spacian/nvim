require('nvim-treesitter.configs').setup({
  highlight = {
    enable = not vim.g.vscode,
    additional_vim_regex_highlighting = false,
    disable = { "latex" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
        node_incremental = "v",
        node_decremental = "V",
    },
  },
})
