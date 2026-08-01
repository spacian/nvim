return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TreesitterTextobjectsSetupDone",
        callback = function()
          local sign = "▕"
          local signs = {
            add = { text = sign },
            change = { text = sign },
            changedelete = { text = sign },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            untracked = { text = sign },
          }

          require("gitsigns").setup({
            sign_priority = 10000,
            signs = signs,
            signs_staged = signs,
            signs_staged_enable = true,
            attach_to_untracked = true,
            signcolumn = true,
            watch_gitdir = {
              interval = 1000,
              follow_files = true,
            },
            on_attach = function(bufnr)
              local gitsigns = require("gitsigns")

              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end

              local jump_hunk = function(opts)
                Jumplist.register()
                if opts.forward then
                  gitsigns.nav_hunk("next")
                else
                  gitsigns.nav_hunk("prev")
                end
              end

              local ts_repeat_move =
                require("nvim-treesitter-textobjects.repeatable_move")
              local repeatable_jump_hunk =
                ts_repeat_move.make_repeatable_move(jump_hunk)

              map("n", "]g", function()
                repeatable_jump_hunk({ forward = true })
              end)
              map("n", "[g", function()
                repeatable_jump_hunk({ forward = false })
              end)
              map({ "o", "x" }, "ig", gitsigns.select_hunk)
              map({ "o", "x" }, "ag", gitsigns.select_hunk)
              map("n", "<leader>ghs", gitsigns.stage_hunk)
              map("v", "<leader>gs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
              end)
              map("n", "<leader>gS", gitsigns.stage_buffer)
              map("n", "<leader>ghr", gitsigns.reset_hunk)
              map("v", "<leader>gr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
              end)
              map("n", "<leader>gR", gitsigns.reset_buffer)
              map("n", "<leader>ghp", gitsigns.preview_hunk_inline)
              map("n", "<leader>gP", gitsigns.toggle_deleted)
              map("n", "<leader>gw", gitsigns.toggle_word_diff)
            end,
          })
        end,
      })
    end,
  },
}
