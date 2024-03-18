if not vim.g.vscode then
    require("workspaces").setup()
    require("telescope").load_extension('workspaces')
    vim.keymap.set({'n'}, '<leader>ow', ':Telescope workspaces<enter>', {noremap=true})
end
