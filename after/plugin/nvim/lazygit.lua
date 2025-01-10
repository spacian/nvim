if not vim.g.vscode then
    require("telescope").load_extension("lazygit")
    vim.g.lazygit_floating_window_scaling_factor = 0.95
    vim.keymap.set({ "n" }, "<leader>gr",
        function() require("telescope").extensions.lazygit.lazygit() end,
        { noremap = true }
    )
    vim.keymap.set({ "n" }, "<leader>gg", ":LazyGit<enter>")
    vim.keymap.set({ "n" }, "<leader>gl", ":LazyGitFilter<enter>")
    vim.keymap.set({ "n" }, "<leader>gf", ":LazyGitFilterCurrentFile<enter>")
    vim.g.lazygit_floating_window_use_plenary = 1
end
