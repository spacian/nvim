require('nvim-treesitter.configs').setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ash"] = "@assignment.lhs",
        ["asl"] = "@assignment.rhs",
        ["aso"] = "@assignment.outer",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ib"] = "@conditional.inner",
        ["ab"] = "@conditional.outer",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["asc"] = { query = "@local.scope", query_group = "locals" },
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
      include_surrounding_whitespace = false,
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>mna"] = "@parameter.inner",
        ["<leader>mnf"] = "@function.outer",
        ["<leader>mnc"] = "@class.outer",
      },
      swap_previous = {
        ["<leader>mpa"] = "@parameter.inner",
        ["<leader>mpf"] = "@function.outer",
        ["<leader>mpc"] = "@class.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = false,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.inner",
        ["]s"] = { query = "@local.scope", query_group = "locals" },
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]A"] = "@parameter.inner",
        ["]S"] = { query = "@local.scope", query_group = "locals" },
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.inner",
        ["[s"] = { query = "@local.scope", query_group = "locals" },
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[A"] = "@parameter.inner",
        ["[S"] = { query = "@local.scope", query_group = "locals" },
      },
    },
  },
})

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
