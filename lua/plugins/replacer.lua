return {
  {
    "gabrielpoca/replacer.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
      require("replacer").setup({ rename_files = false })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "qf", -- quickfix buffer
        callback = function(args)
          vim.keymap.set("n", "<leader>m", function()
            require("replacer").run()
          end, { silent = true, buffer = args.buf })
        end,
      })
    end,
  },
}
