---@param file string?
local function path_is_in_workspace(file)
  local cwd = vim.loop.fs_realpath(vim.fn.getcwd())
  if not file then
    file = vim.loop.fs_realpath(vim.fn.expand("%:p"))
  end
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

return {
  {
    "olimorris/persisted.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
      local persisted = require("persisted")

      persisted.setup({
        autostart = false,
        follow_cwd = false,
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
          if buffer_name ~= "" and not BufIsSpecial() and path_is_in_workspace() then
            persisted.save({ session = persisted.current() })
          end
          local bufs = {}
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].buftype == "" then
              bufs[#bufs + 1] = buf
            end
          end
          if #bufs > 0 then
            vim.cmd("silent bd! " .. table.concat(bufs, " "))
          end
        end,
      })

      local buf_valid = function(buf)
        return vim.bo[buf].buftype == ""
          and vim.bo[buf].buflisted
          and vim.api.nvim_buf_is_valid(buf)
      end

      local path_valid = function(bufname)
        return bufname ~= ""
          and path_is_in_workspace(bufname)
          and vim.loop.fs_stat(bufname)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedTelescopeLoadPost",
        callback = function(_)
          vim.defer_fn(function()
            local bufs = {}
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if buf_valid(buf) then
                local bufname = vim.api.nvim_buf_get_name(buf)
                if not path_valid(bufname) then
                  bufs[#bufs + 1] = buf
                end
              end
            end
            if #bufs > 0 then
              vim.cmd("silent bd! " .. table.concat(bufs, " "))
            end
          end, 100)
        end,
      })

      vim.api.nvim_create_autocmd({ "BufEnter", "VimLeavePre" }, {
        callback = function()
          vim.cmd("set nohls")
          vim.schedule(function()
            if not BufIsSpecial() and path_is_in_workspace() then
              persisted.save({ force = true, session = persisted.current() })
            end
          end)
        end,
      })
    end,
  },
}
