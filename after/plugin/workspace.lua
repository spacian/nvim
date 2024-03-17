if not vim.g.vscode then
    require("workspaces").setup()
    vim.keymap.set({'n'}, '<leader>ow', ':WorkspacesOpen ', {noremap=true})
end
