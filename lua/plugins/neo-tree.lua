return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        position = "current",
        filesystem = {
          filtered_items = {
            visible = false,
            hide_gitignored = false,
            hide_dotfiles = false,
            hide_hidden = false,
            hide_by_name = {
              "__pycache__",
              ".git",
              ".pytest_cache",
              ".vscode",
              ".exe",
            },
            hide_by_pattern = {},
          },
        },
        window = {
          mappings = {
            ["h"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" and node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node)
              else
                require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
              end
            end,
            ["l"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" then
                if not node:is_expanded() then
                  require("neo-tree.sources.filesystem").toggle_directory(state, node)
                elseif node:has_children() then
                  require("neo-tree.ui.renderer").focus_node(
                    state,
                    node:get_child_ids()[1]
                  )
                end
              else
                state.commands["open"](state)
              end
            end,
            ["q"] = "close_window",
            ["<esc>"] = "close_window",
          },
        },
      })
      local jumplist = require("remaps.nvim.jumplist")
      vim.keymap.set({ "n" }, "<leader>oE", function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname == "" or not BufIsSpecial() then
          jumplist.register(1)
          require("neo-tree.command").execute({
            action = "focus",
            position = "current",
            source = "filesystem",
            dir = vim.fn.getcwd(),
            reveal = true,
          })
        end
      end)
    end,
  },
}
