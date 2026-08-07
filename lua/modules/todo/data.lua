local M = {}

local util = require("modules.todo.util")

local context = {}
---@type table<number, Task>
context.ref = {}
---@type table<number, number>
context.parent = {}
---@type Task[]
context.tasks = {}

local task_id = 0

local function make_id()
  task_id = task_id + 1
  return task_id
end
---@type Task?
local task_copy = nil

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

---@param tasks Task[]
function M.setup(tasks)
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
  context.ref[task.id] = task
  context.parent[task.id] = parent
end

---@param id number
function M.copy_task(id)
  local orig = context.ref[id]
  task_copy = util.create_task(orig.title, 0)
  task_copy.important = orig.important
  task_copy.urgent = orig.urgent
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
---@return boolean
function M.has_children(id)
  return #context.ref[id].children > 0
end

function M.sort()
  util.sort_tasks(context.tasks)
end

function M.toggle_urgent(id)
  local task = context.ref[id]
  task.urgent = not task.urgent
end

function M.toggle_important(id)
  local task = context.ref[id]
  task.important = not task.important
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

---@return Task[]
function M.tasks()
  return context.tasks
end

return M
