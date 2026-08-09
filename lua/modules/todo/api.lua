local M = {}
require("modules.todo.highlights")
local renderer = require("modules.todo.renderer")
local data = require("modules.todo.data")
local util = require("modules.todo.util")
local persistence = require("modules.todo.persistence")

---@type string?
local filepath = nil

---@type number[]
local line_ref = {}

---@type number?
local buf = nil

---@param buf number
---@param tasks Task[]
local function update(buf, tasks)
  line_ref = renderer.render(buf, tasks)
end

---@return number?
local function task_id()
  if #line_ref == 0 then
    return nil
  end
  return line_ref[vim.api.nvim_win_get_cursor(0)[1]]
end

---@param text string
---@return string?
local function input_task_name(text)
  local title = vim.fn.input("task name: ", text)
  if title:match("^%s*$") ~= nil then
    print("invalid task name '" .. title .. "'")
    return nil
  end
  return title
end

function M.cycle_state()
  local id = task_id()
  if buf and id then
    data.cycle_state(id)
    update(buf, data.tasks())
  end
end

function M.toggle_urgent()
  local id = task_id()
  if buf and id then
    data.toggle_urgent(id)
    update(buf, data.tasks())
  end
end

function M.toggle_important()
  local id = task_id()
  if buf and id then
    data.toggle_important(id)
    update(buf, data.tasks())
  end
end

function M.delete()
  local id = task_id()
  if buf and id then
    if data.has_children(id) then
      if vim.fn.confirm("delete task and all children?", "&Yes\n&No", 2) ~= 1 then
        return
      end
    end
    data.copy_task(id)
    data.delete(id)
    update(buf, data.tasks())
  end
end

function M.sort()
  if buf then
    data.sort()
    update(buf, data.tasks())
  end
end

function M.create_task()
  if buf then
    local title = input_task_name("")
    if title ~= nil then
      data.add_task(title)
      update(buf, data.tasks())
    end
  end
end

function M.create_subtask()
  local id = task_id()
  if buf and id then
    local title = input_task_name("")
    if title ~= nil then
      data.add_subtask(title, id)
      update(buf, data.tasks())
    end
  end
end

function M.rename()
  local id = task_id()
  if buf and id then
    local title = input_task_name(data.get_title(id))
    if title ~= nil then
      data.rename(title, id)
      update(buf, data.tasks())
    end
  end
end

function M.shallow_copy()
  local id = task_id()
  if id ~= nil then
    data.copy_task(id)
  end
end

function M.paste_shallow()
  if buf then
    data.paste()
    update(buf, data.tasks())
  end
end

function M.paste_to_child_shallow()
  local id = task_id()
  if buf and id then
    data.paste_to_child(id)
    update(buf, data.tasks())
  end
end

function M.toggle_collapse()
  local id = task_id()
  if buf and id then
    data.collapse(id)
    update(buf, data.tasks())
  end
end

function M.move_delete()
  local id = task_id()
  if buf and id then
    data.move_delete(id)
    update(buf, data.tasks())
  end
end

function M.move_paste()
  if buf then
    data.move()
    update(buf, data.tasks())
  end
end

function M.move_paste_to_child()
  local id = task_id()
  if buf and id then
    data.move_to_child(id)
    update(buf, data.tasks())
  end
end

function M.notes()
  local id = task_id()
  if buf and id then
    util.open_note(data.get_title(id), data.get_notes(id), function(text)
      vim.schedule(function()
        data.set_notes(id, text)
        update(buf, data.tasks())
      end)
    end)
  end
end

local function set_keymaps()
  vim.keymap.set("n", "<space>", function()
    M.cycle_state()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "u", function()
    M.toggle_urgent()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "i", function()
    M.toggle_important()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "q", function()
    vim.cmd("q")
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "d", function()
    M.delete()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "s", function()
    M.sort()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "N", function()
    M.create_task()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "n", function()
    M.create_subtask()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "r", function()
    M.rename()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "y", function()
    M.shallow_copy()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "P", function()
    M.paste_shallow()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "p", function()
    M.paste_to_child_shallow()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "<enter>", function()
    M.toggle_collapse()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "D", function()
    M.move_delete()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "M", function()
    M.move_paste()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "m", function()
    M.move_paste_to_child()
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "o", function()
    M.notes()
  end, { buf = buf, nowait = true })
end

function M.open()
  if buf == nil then
    buf = util.create_window()
    vim.api.nvim_create_autocmd("BufWipeout", {
      buffer = buf,
      once = true,
      callback = function()
        if filepath ~= nil then
          persistence.write(filepath, data.tasks())
        end
        buf = nil
        line_ref = {}
      end,
    })
    update(buf, data.tasks())
    set_keymaps()
  end
end

---@param path string
function M.setup(path)
  filepath = path
  local tasks = persistence.read(filepath)
  if tasks ~= nil then
    data.setup(tasks)
  else
    vim.print("invalid input file for todo")
  end
end

return M
