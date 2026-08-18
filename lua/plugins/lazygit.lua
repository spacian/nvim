return {
  {
    "103sbavert/lazygit.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("lazygit").setup({
        floating_window = {
          scaling_factor = 1.0,
          use_plenary = true,
        },
      })
      vim.keymap.set({ "n" }, "<leader>gg", function()
        vim.cmd("LazyGit")
      end)
      vim.keymap.set({ "n" }, "<leader>gl", function()
        vim.cmd("LazyGitLog")
      end)
      vim.keymap.set({ "n" }, "<leader>gf", function()
        vim.cmd("LazyGitFilterCurrentFile")
      end)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lazygit",
        callback = function(args)
          vim.keymap.set("t", "<c-j>", function()
            local key = vim.api.nvim_replace_termcodes("<a-down>", true, false, true)
            vim.api.nvim_feedkeys(key, "t", false)
          end, { buffer = args.buf })
        end,
      })
    end,
  },
}
