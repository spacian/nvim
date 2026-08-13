return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      local oil = require("oil")
      oil.setup({
        keymaps = {
          ["<enter>"] = { "actions.select", mode = "n" },
          ["<c-p>"] = { "actions.preview", mode = "n" },
          ["<c-h>"] = { "actions.toggle_hidden", mode = "n" },
          ["-"] = { "actions.parent", mode = "n" },
          ["<leader>r"] = { "actions.refresh", mode = "n" },
          ["q"] = { "actions.close", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
        },
        use_default_keymaps = false,
        view_options = {
          show_hidden = false,
          is_hidden_file = function(name, bufnr)
            local m = name:match("^%.") or name:match("__pycache__")
            return m ~= nil and name ~= ".." and name ~= ".gitignore"
          end,
        },
        lsp_file_methods = { enabled = false },
      })

      vim.keymap.set("n", "<leader>oe", function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname == "" then
          Jumplist.register()
          vim.cmd("silent Oil .")
        elseif BufIsSpecial() then
          return
        end
        Jumplist.register()
        local file = vim.fn.expand("%:t")
        oil.open(vim.fn.expand("%:h"), {}, function()
          vim.cmd("silent! call search('\\V' . escape(' " .. file .. "', '\\') , 'w')")
        end)
      end)

      vim.api.nvim_create_user_command("ChangeWorkingDirectory", function()
        local cwd = oil.get_current_dir()
        if cwd ~= nil then
          vim.cmd("cd " .. cwd)
        elseif not BufIsSpecial() then
          vim.cmd("cd %:p:h")
        else
          return
        end
        print("new working directory: " .. vim.fn.getcwd())
        require("persisted").save({ session = require("persisted").current() })
      end, {})

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.opt_local.statuscolumn = ""
        end,
      })
    end,
  },
}
