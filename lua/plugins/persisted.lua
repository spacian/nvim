return {
  {
    "olimorris/persisted.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
      local persisted = require("persisted")
      persisted.setup({
        autosave = false,
        silent = true,
        ignored_dirs = { "oil://", "replacer://" },
      })
      vim.keymap.set({ "n" }, "<leader>oP", function()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        if not buffer_name == "" and BufIsSpecial() then
          print("cannot open new session from this buffer")
          return
        end
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
          persisted.save({ session = vim.g.persisted_loaded_session })
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
          if not BufIsSpecial() then
            vim.schedule(function()
              persisted.save({ force = true })
            end)
          end
        end,
      })
    end,
  },
}
