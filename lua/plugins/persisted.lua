local function escape_pattern(str, pattern, replace, n)
  pattern = pattern:gsub("[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1")
  replace = replace:gsub("%%", "%%%%")
  return str:gsub(pattern, replace, n)
end

local function list_sessions()
  local sep = require("persisted.utils").dir_pattern()
  local sessions = {}

  for _, session in pairs(require("persisted").list()) do
    local session_name =
      escape_pattern(session, require("persisted.config").save_dir, "")
        :gsub("%%", sep)
        :gsub(vim.fn.expand("~"), sep)
        :gsub("//", "")
        :sub(1, -5)

    if vim.fn.has("win32") == 1 then
      session_name = escape_pattern(session_name, sep, ":", 1)
      session_name = escape_pattern(session_name, sep, "\\")
    end

    local branch, dir_path

    if session_name:find("@@", 1, true) then
      local splits = vim.split(session_name, "@@", { plain = true })
      branch = table.remove(splits)
      dir_path = table.concat(splits, "@@")
    else
      dir_path = session_name
    end

    sessions[#sessions + 1] = {
      text = session_name,
      name = session_name,
      dir_path = dir_path,
      branch = branch,
      file_path = session,
    }
  end

  return sessions
end

local function load(item)
  vim.api.nvim_exec_autocmds("User", { pattern = "PersistedTelescopeLoadPre" })

  vim.schedule(function()
    require("persisted").load({ session = item.file_path })
  end)

  vim.api.nvim_exec_autocmds("User", { pattern = "PersistedTelescopeLoadPost" })
end

local function delete(item)
  if vim.fn.confirm(("Delete [%s]?"):format(item.name), "&Yes\n&No") == 1 then
    vim.fn.delete(vim.fn.expand(item.file_path))
    return true
  end
  return false
end

local pick_session = function(opts)
  opts = opts or {}
  local sessions = function()
    return vim
      .iter(list_sessions())
      :filter(function(item)
        return item.file_path ~= vim.v.this_session
      end)
      :totable()
  end

  local function refresh(picker)
    picker.opts.items = sessions()
    picker:refresh()
  end

  require("snacks").picker({

    title = "Sessions",
    layout = "select",

    items = sessions(),

    format = function(item)
      return { { item.dir_path } }
    end,

    confirm = function(picker, item)
      picker:close()
      load(item)
    end,

    actions = {
      delete = function(picker, item)
        if delete(item) then
          refresh(picker)
        end
      end,
    },

    win = {
      input = {
        keys = {
          ["<c-x>"] = { "delete", mode = { "n", "i" } },
        },
      },
    },
  })
end

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

      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          vim.schedule(function()
            if vim.api.nvim_buf_get_name(0) == "" and vim.bo[0].buftype == "" then
              pick_session()
            end
          end)
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

      vim.keymap.set("n", "<leader>oP", pick_session)
    end,
  },
}
