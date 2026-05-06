return {
  {
    "olimorris/persisted.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
      local persisted = require("persisted")

      local function path_is_in_workspace()
        local cwd = vim.loop.fs_realpath(vim.fn.getcwd())
        local file = vim.loop.fs_realpath(vim.fn.expand("%:p"))
        if not cwd or not file then
          return false
        end
        cwd = cwd:gsub("\\", "/")
        file = file:gsub("\\", "/")
        if vim.loop.os_uname().version:match("Windows") then
          cwd = cwd:lower()
          file = file:lower()
        end
        return file == cwd or file:sub(1, #cwd + 1) == cwd .. "/"
      end

      persisted.setup({
        autostart = true,
        silent = true,
        ignored_dirs = { "oil://" },
        should_save = path_is_in_workspace,
      })

      vim.keymap.set({ "n" }, "<leader>oP", function()
        vim.cmd("Telescope persisted")
      end)

      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          if vim.api.nvim_buf_get_name(0) == "" then
            vim.cmd("Telescope persisted")
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedTelescopeLoadPre",
        callback = function(_)
          local buffer_name = vim.api.nvim_buf_get_name(0)
          if
            not buffer_name == ""
            and not BufIsSpecial()
            and path_is_in_workspace()
          then
            persisted.save({ session = vim.g.persisted_loaded_session })
          end
          local bufs = {}
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].buftype == "" then
              bufs[#bufs + 1] = buf
            end
          end
          vim.cmd("silent bd! " .. table.concat(bufs, " "))
          vim.diagnostic.reset()
        end,
      })

      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
          vim.cmd("set nohls")
          vim.schedule(function()
            if not BufIsSpecial() and path_is_in_workspace() then
              persisted.save({ force = true })
            end
          end)
        end,
      })
    end,
  },
}
