local M = {}

local types = require("modules.todo.types")

---@param task Task
---@return number
function M.priority_value(task)
  return (task.important and 2 or 0) + (task.urgent and 4 or 0)
end

---@return number buf
function M.create_window()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = 40
  local height = 20
  local win = vim.api.nvim_open_win(buf, true, {
    title = "Tasks",
    title_pos = "center",
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    border = "rounded",
  })

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].foldcolumn = "0"
  vim.wo[win].wrap = false
  vim.wo[win].cursorline = false
  vim.wo[win].winfixwidth = true
  return buf
end

---@param title string
---@param text string
---@param callback function(string): nil
function M.open_note(title, text, callback)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "text"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n"))

  local width = 60
  local height = 20
  vim.api.nvim_open_win(buf, true, {
    title = title,
    title_pos = "center",
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    border = "rounded",
  })

  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    once = true,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      callback(table.concat(lines, "\n"))
    end,
  })

  vim.keymap.set("n", "q", function()
    vim.cmd("q")
  end, { buf = buf, nowait = true })
end

---@param tasks Task[]
function M.sort_tasks(tasks)
  local state_order = {
    [types.TaskState.IN_PROGRESS] = 1,
    [types.TaskState.OPEN] = 2,
    [types.TaskState.DONE] = 3,
  }
  table.sort(tasks, function(a, b)
    local state_a = state_order[a.state]
    local state_b = state_order[b.state]
    if state_a ~= state_b then
      return state_a < state_b
    end
    local prio_a = M.priority_value(a)
    local prio_b = M.priority_value(b)
    if prio_a ~= prio_b then
      return prio_a > prio_b
    end
    return a.title < b.title
  end)
  for _, task in ipairs(tasks) do
    M.sort_tasks(task.children)
  end
end

---@param title string
---@param id number
---@return Task
function M.create_task(title, id)
  return {
    id = id,
    title = title,
    state = "open",
    important = true,
    urgent = false,
    children = {},
  }
end

return M
