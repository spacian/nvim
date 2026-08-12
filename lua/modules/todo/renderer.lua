local M = {}

local hl_ns = vim.api.nvim_create_namespace("todo_hl")
local ref_ns = vim.api.nvim_create_namespace("todo_ref")
local types = require("modules.todo.types")
local util = require("modules.todo.util")

local state_symbols = {
  open = "○",
  in_progress = "◐",
  done = "●",
}

local state_groups = {
  [types.TaskState.OPEN] = "TaskStateOpen",
  [types.TaskState.IN_PROGRESS] = "TaskStateInProgress",
  [types.TaskState.DONE] = "TaskStateDone",
}

local priority_groups = {
  [0] = "TaskPriorityNormal",
  [2] = "TaskPriorityImportant",
  [4] = "TaskPriorityUrgent",
  [6] = "TaskPriorityImportantUrgent",
}

---@param tasks Task[]
---@param buf number
---@return number[]
---@return table<number, number>
function M.render(buf, tasks)
  vim.api.nvim_buf_clear_namespace(buf, ref_ns, 0, -1)
  vim.api.nvim_buf_clear_namespace(buf, hl_ns, 0, -1)

  local lines = {}
  local extmarks = {}
  local refs = {}

  ---@param task Task
  ---@param depth number
  ---@param forced_hl? string
  local function add_task(task, depth, forced_hl)
    local line = #lines
    local indent = " " .. string.rep("  ", depth)
    local symbol = state_symbols[task.state] or "?"
    local indicator_children = #task.children > 0 and " /" or ""
    local indicator_note = task.notes and #task.notes > 0 and " *" or ""

    local text = indent
      .. symbol
      .. " "
      .. task.title
      .. indicator_note
      .. indicator_children
    table.insert(lines, text)

    if task.state == types.TaskState.DONE then
      forced_hl = state_groups[task.state]
    end

    table.insert(extmarks, {
      line = line,
      group = forced_hl or state_groups[task.state],
      start_col = #indent,
      end_col = #indent + #symbol,
      ns = hl_ns,
    })

    table.insert(extmarks, {
      line = line,
      group = forced_hl or priority_groups[util.priority_value(task)],
      start_col = #indent + #symbol + 1,
      end_col = #text,
      ns = hl_ns,
    })

    refs[#refs + 1] = task.id

    if not task.collapsed then
      for _, child in ipairs(task.children) do
        add_task(child, depth + 1, forced_hl)
      end
    end
  end

  for _, task in ipairs(tasks) do
    add_task(task, 0)
  end

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  for _, em in ipairs(extmarks) do
    vim.api.nvim_buf_set_extmark(buf, em.ns, em.line, em.start_col, {
      end_col = em.end_col,
      hl_group = em.group,
    })
  end

  local task_to_line = {}
  for i, ref in ipairs(refs) do
    task_to_line[ref] = i
  end
  return refs, task_to_line
end

return M
