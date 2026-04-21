return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = false,
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    after = "nvim-treesitter",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            --   ['@parameter.outer'] = 'v', -- charwise
            ["@class.inner"] = "V", -- linewise
            ["@class.outer"] = "V", -- linewise
            ["@function.outer"] = "V", -- linewise
            ["@function.inner"] = "V", -- linewise
            ["@block.outer"] = "V", -- linewise
            ["@block.inner"] = "V", -- linewise
            --   ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = false,
        },
      })
      local keymap_select = function(lhs, obj)
        vim.keymap.set({ "x", "o" }, lhs, function()
          require("nvim-treesitter-textobjects").select_textobject(obj, "textobjects")
        end)
      end
      keymap_select("ai", "@statement.outer")
      keymap_select("ah", "@assignment.lhs")
      keymap_select("al", "@assignment.rhs")
      keymap_select("as", "@assignment.outer")
      keymap_select("ab", "@block.outer")
      keymap_select("ib", "@block.inner")
      keymap_select("ac", "@class.outer")
      keymap_select("ic", "@class.inner")
      keymap_select("af", "@function.outer")
      keymap_select("if", "@function.inner")
      keymap_select("ak", "@comment.outer")
      keymap_select("ik", "@comment.inner")
      keymap_select("aa", "@parameter.outer")
      keymap_select("ia", "@parameter.inner")

      local keymap_swap_next = function(lhs, obj)
        vim.keymap.set({ "n" }, lhs, function()
          require("nvim-treesitter-textobjects.swap").swap_next(obj)
        end)
      end
      keymap_swap_next("gla", "@parameter.inner")
      keymap_swap_next("glf", "@function.outer")
      keymap_swap_next("glc", "@class.outer")

      local keymap_swap_previous = function(lhs, obj)
        vim.keymap.set({ "n" }, lhs, function()
          require("nvim-treesitter-textobjects.swap").swap_previous(obj)
        end)
      end
      keymap_swap_previous("gha", "@parameter.inner")
      keymap_swap_previous("ghf", "@function.outer")
      keymap_swap_previous("ghc", "@class.outer")

      local keymap_move_next_start = function(lhs, obj)
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
          require("nvim-treesitter-textobjects.move").goto_next_start(
            obj,
            "textobjects"
          )
        end)
      end
      keymap_move_next_start("]f", "@function.outer")
      keymap_move_next_start("]c", "@class.outer")
      keymap_move_next_start("]a", "@parameter.inner")

      local keymap_move_next_end = function(lhs, obj)
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
          require("nvim-treesitter-textobjects.move").goto_next_end(obj, "textobjects")
        end)
      end
      keymap_move_next_end("]F", "@function.outer")
      keymap_move_next_end("]C", "@class.outer")
      keymap_move_next_end("]A", "@parameter.inner")

      local keymap_move_previous_start = function(lhs, obj)
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
          require("nvim-treesitter-textobjects.move").goto_previous_start(
            obj,
            "textobjects"
          )
        end)
      end
      keymap_move_previous_start("[f", "@function.outer")
      keymap_move_previous_start("[c", "@class.outer")
      keymap_move_previous_start("[a", "@parameter.inner")

      local keymap_move_previous_end = function(lhs, obj)
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
          require("nvim-treesitter-textobjects.move").goto_previous_end(
            obj,
            "textobjects"
          )
        end)
      end
      keymap_move_previous_end("[F", "@function.outer")
      keymap_move_previous_end("[C", "@class.outer")
      keymap_move_previous_end("[A", "@parameter.inner")

      local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
      vim.keymap.set(
        { "n", "x", "o" },
        "f",
        ts_repeat_move.builtin_f_expr,
        { expr = true }
      )
      vim.keymap.set(
        { "n", "x", "o" },
        "F",
        ts_repeat_move.builtin_F_expr,
        { expr = true }
      )
      vim.keymap.set(
        { "n", "x", "o" },
        "t",
        ts_repeat_move.builtin_t_expr,
        { expr = true }
      )
      vim.keymap.set(
        { "n", "x", "o" },
        "T",
        ts_repeat_move.builtin_T_expr,
        { expr = true }
      )
    end,
  },
}
