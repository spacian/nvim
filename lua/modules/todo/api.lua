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

local function set_keymaps(buf)
  vim.keymap.set("n", "<space>", function()
    local id = task_id()
    if id ~= nil then
      data.cycle_state(id)
      update(buf, data.tasks())
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "u", function()
    local id = task_id()
    if id ~= nil then
      data.toggle_urgent(id)
      update(buf, data.tasks())
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "i", function()
    local id = task_id()
    if id ~= nil then
      data.toggle_important(id)
      update(buf, data.tasks())
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "q", function()
    vim.cmd("q")
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "d", function()
    local id = task_id()
    if id ~= nil then
      if data.has_children(id) then
        if vim.fn.confirm("delete task and all children?", "&Yes\n&No", 2) ~= 1 then
          return
        end
      end
      data.copy_task(id)
      data.delete(id)
      update(buf, data.tasks())
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "s", function()
    data.sort()
    update(buf, data.tasks())
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "n", function()
    local title = input_task_name("")
    if title ~= nil then
      data.add_task(title)
      update(buf, data.tasks())
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "N", function()
    local id = task_id()
    if id ~= nil then
      local title = input_task_name("")
      if title ~= nil then
        data.add_subtask(title, id)
        update(buf, data.tasks())
      end
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "r", function()
    local id = task_id()
    if id ~= nil then
      local title = input_task_name(data.get_title(id))
      if title ~= nil then
        data.rename(title, id)
        update(buf, data.tasks())
      end
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "y", function()
    local id = task_id()
    if id ~= nil then
      data.copy_task(id)
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "p", function()
    data.paste()
    update(buf, data.tasks())
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "P", function()
    local id = task_id()
    if id ~= nil then
      data.paste_to_child(id)
      update(buf, data.tasks())
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "c", function()
    local id = task_id()
    if id ~= nil then
      data.collapse(id)
      update(buf, data.tasks())
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "D", function()
    local id = task_id()
    if id ~= nil then
      data.move_delete(id)
      update(buf, data.tasks())
    end
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "m", function()
    data.move()
    update(buf, data.tasks())
  end, { buf = buf, nowait = true })

  vim.keymap.set("n", "M", function()
    local id = task_id()
    if id ~= nil then
      data.move_to_child(id)
      update(buf, data.tasks())
    end
  end)

  vim.keymap.set("n", "o", function()
    local id = task_id()
    if id ~= nil then
      util.open_note(data.get_notes(id), function(text)
        vim.schedule(function()
          data.set_notes(id, text)
          update(buf, data.tasks())
        end)
      end)
    end
  end, { buf = buf, nowait = true })

  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    once = true,
    callback = function()
      if filepath ~= nil then
        persistence.write(filepath, data.tasks())
      end
    end,
  })
end

function M.open()
  local buf = util.create_window()
  update(buf, data.tasks())
  set_keymaps(buf)
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
