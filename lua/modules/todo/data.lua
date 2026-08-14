local M = {}

local util = require("modules.todo.util")
local types = require("modules.todo.types")

local context = {}
---@type table<number, Task>
context.ref = {}
---@type table<number, number>
context.parent = {}
---@type Task[]
context.tasks = {}
---@type Task?
local task_copy = nil
---@type Task?
local task_move = nil
---@type number
local task_id = 0

local function make_id()
  task_id = task_id + 1
  return task_id
end

---@param tasks Task[]
local function update_ids(tasks)
  ---@param task Task
  local function visit(task)
    task.id = make_id()
    for _, child in ipairs(task.children) do
      visit(child)
    end
  end
  for _, task in ipairs(tasks) do
    visit(task)
  end
end

---@param task Task
---@param collapse boolean
local function collapse_recursive(task, collapse)
  if task.state == types.TaskState.DONE then
    collapse = true
  end
  if #task.children > 0 then
    task.collapsed = collapse
    for _, child in ipairs(task.children) do
      collapse_recursive(child, collapse)
    end
  end
end

---@param id number
function M.collapse_recursive(id)
  local task = context.ref[id]
  collapse_recursive(task, not task.collapsed)
end

---@param id number
function M.collapse_level(id)
  local neighbors = id
      and context.parent[id]
      and context.ref[context.parent[id]].children
    or context.tasks
  local collapse = nil
  local ref_task = context.ref[id]
  if
    ref_task.state ~= types.TaskState.DONE
    and #ref_task.children > 0
    and ref_task.collapsed ~= nil
  then
    collapse = not ref_task.collapsed
  end
  for _, task in ipairs(neighbors) do
    local done = task.state == types.TaskState.DONE
    if #task.children > 0 then
      if not done then
        if collapse == nil then
          collapse = not task.collapsed
        end
        task.collapsed = collapse
        for _, child in ipairs(task.children) do
          collapse_recursive(child, true)
        end
      else
        task.collapsed = true
      end
    end
  end
end

---@param tasks Task[]
function M.setup(tasks)
  context.parent = {}
  context.ref = {}
  context.tasks = {}
  task_copy = nil
  task_move = nil
  task_id = 0

  ---@param task Task
  local function visit(task)
    context.ref[task.id] = task
    for _, child in ipairs(task.children) do
      context.parent[child.id] = task.id
      visit(child)
    end
  end

  update_ids(tasks)
  context.tasks = tasks
  for _, task in ipairs(tasks) do
    visit(task)
  end
end

---@param title string
function M.add_task(title)
  local task = util.create_task(title, make_id())
  table.insert(context.tasks, task)
  context.ref[task.id] = task
end

---@param title string
---@param parent number
function M.add_subtask(title, parent)
  local task = util.create_task(title, make_id())
  table.insert(context.ref[parent].children, task)
  context.ref[parent].collapsed = nil
  context.ref[task.id] = task
  context.parent[task.id] = parent
end

---@param id number
function M.copy_task(id)
  task_copy = vim.deepcopy(context.ref[id])
end

function M.paste()
  if task_copy ~= nil then
    task_copy = vim.deepcopy(task_copy)
    task_copy.id = make_id()
    table.insert(context.tasks, task_copy)
    context.ref[task_copy.id] = task_copy
  else
    print("no task copied")
  end
end

---@param parent number
function M.paste_to_child(parent)
  if task_copy ~= nil then
    task_copy = vim.deepcopy(task_copy)
    task_copy.id = make_id()
    table.insert(context.ref[parent].children, task_copy)
    context.ref[parent].collapsed = nil
    context.ref[task_copy.id] = task_copy
    context.parent[task_copy.id] = parent
  else
    print("no task copied")
  end
end

---@param title string
---@param id number
function M.rename(title, id)
  context.ref[id].title = title
end

---@param id number
---@return string
function M.get_title(id)
  return context.ref[id].title
end

---@param id number
---@return number?
function M.get_parent(id)
  return context.parent[id]
end

---@param id number
---@return number?
function M.get_first_child(id)
  return #context.ref[id].children > 0 and context.ref[id].children[1].id or nil
end

---@param id number
---@return boolean
function M.has_children(id)
  return #context.ref[id].children > 0
end

function M.sort()
  util.sort_tasks(context.tasks)
end

---@param id number
---@param offset number?
function M.sort_offset_set(id, offset)
  local task = context.ref[id]
  task.sort_offset = offset
end

---@param id number
---@return number?
function M.sort_offset_get(id)
  return context.ref[id].sort_offset
end

---@param id number
function M.toggle_urgent(id)
  local task = context.ref[id]
  task.urgent = not task.urgent
end

---@param id number
function M.toggle_important(id)
  local task = context.ref[id]
  task.important = not task.important
end

---@param id number
function M.collapse_toggle(id)
  local task = context.ref[id]
  if #task.children > 0 then
    task.collapsed = not task.collapsed
  end
end

---@param id number
---@param value boolean
function M.collapse(id, value)
  local task = context.ref[id]
  if #task.children > 0 then
    task.collapsed = value
  end
end

---@param id number
---@return boolean
function M.collapsed(id)
  return context.ref[id].collapsed or false
end

---@param id number
---@return number?
function M.collapse_smart(id)
  local task = context.ref[id]
  if #task.children > 0 and not task.collapsed then
    task.collapsed = true
    return task.id
  end
  local parent = context.parent[id] or id
  task = context.ref[parent]
  if not task.collapsed then
    task.collapsed = true
    return parent
  end
  return nil
end

---@param id number
function M.cycle_state(id)
  local task = context.ref[id]
  local states = require("modules.todo.types").TaskState
  if task.state == states.OPEN then
    task.state = states.IN_PROGRESS
  elseif task.state == states.IN_PROGRESS then
    task.state = states.DONE
  elseif task.state == states.DONE then
    task.state = states.OPEN
  end
end

---@param id number
function M.delete(id)
  local children = context.ref[id].children
  for i = #children, 1, -1 do
    M.delete(children[i].id)
  end
  local parent = context.parent[id]
  if parent ~= nil then
    for i, neighbor in pairs(context.ref[parent].children) do
      if neighbor.id == id then
        table.remove(context.ref[parent].children, i)
        break
      end
    end
  else
    for i, neighbor in pairs(context.tasks) do
      if neighbor.id == id then
        table.remove(context.tasks, i)
        break
      end
    end
  end
  context.ref[id] = nil
  context.parent[id] = nil
end

---@param id number
function M.move_delete(id)
  local parent = context.parent[id]
  if parent ~= nil then
    local children = context.ref[parent].children
    for i, neighbor in pairs(children) do
      if neighbor.id == id then
        table.remove(children, i)
        break
      end
    end
  else
    for i, neighbor in pairs(context.tasks) do
      if neighbor.id == id then
        table.remove(context.tasks, i)
        break
      end
    end
  end
  task_move = context.ref[id]
  context.ref[id] = nil
  context.parent[id] = nil
end

function M.move()
  if task_move ~= nil then
    table.insert(context.tasks, task_move)
    context.ref[task_move.id] = task_move
    task_move = nil
  else
    print("not moving anything")
  end
end

---@param id number
function M.move_to_child(id)
  if task_move ~= nil then
    local task = context.ref[id]
    table.insert(task.children, task_move)
    task.collapsed = nil
    context.parent[task_move.id] = id
    context.ref[task_move.id] = task_move
    task_move = nil
  else
    print("not moving anything")
  end
end

---@param id number
---@return string
function M.get_notes(id)
  local task = context.ref[id]
  return task.notes or ""
end

---@param id number
---@param text string
function M.set_notes(id, text)
  local task = context.ref[id]
  task.notes = text
end

---@return boolean
function M.moving()
  return task_move ~= nil
end

---@return Task[]
function M.tasks()
  return context.tasks
end

---@param id number
---@return number?
---@return number?
function M.get_neighbors(id)
  local prev = nil
  local next = nil
  local neighbors = id
      and context.parent[id]
      and context.ref[context.parent[id]].children
    or context.tasks
  for i, task in ipairs(neighbors) do
    if task.id == id then
      prev = neighbors[i - 1] and neighbors[i - 1].id or nil
      next = neighbors[i + 1] and neighbors[i + 1].id or nil
      break
    end
  end
  return prev, next
end

---@param id number
function M.delete_done(id)
  local task = context.ref[id]
  if task.state == types.TaskState.DONE then
    M.delete(id)
  else
    for i = #task.children, 1, -1 do
      M.delete_done(task.children[i].id)
    end
  end
end

function M.delete_done_all()
  for i = #context.tasks, 1, -1 do
    M.delete_done(context.tasks[i].id)
  end
end

return M
