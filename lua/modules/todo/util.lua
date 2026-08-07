local M = {}

local types = require("modules.todo.types")

---@param task Task
---@return integer
function M.priority_value(task)
  return (task.important and 2 or 0) + (task.urgent and 4 or 0)
end

---@return number buf
function M.create_window()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = 40
  local height = 20
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    border = "rounded",
  })

  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].foldcolumn = "0"
  vim.wo[win].wrap = false
  vim.wo[win].cursorline = false
  vim.wo[win].winfixwidth = true
  return buf
end

---@param task any
---@return boolean
function M.is_task(task)
  if
    type(task) == "table"
    and type(task.title) == "string"
    and type(task.important) == "boolean"
    and type(task.urgent) == "boolean"
    and vim.islist(task.children)
  then
    for _, child in ipairs(task.children) do
      if not M.is_task(child) then
        return false
      end
    end
    return true
  else
    return false
  end
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
    important = false,
    urgent = false,
    children = {},
  }
end

return M
