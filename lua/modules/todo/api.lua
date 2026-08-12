local M = {}

local opts = {}

local data = require("modules.todo.data")
local persistence = require("modules.todo.persistence")
local renderer = require("modules.todo.renderer")
local util = require("modules.todo.util")

---@type string?
local filepath = nil

---@type number[]
local line_ref = {}

---@type table<number, number>
local task_ref = {}

---@type number?
local buf = nil

local function redraw()
  if buf then
    line_ref, task_ref = renderer.render(buf, data.tasks())
  end
end

---@return number?
local function task_id()
  return line_ref[vim.api.nvim_win_get_cursor(0)[1]]
end

---@param id number
local function set_cursor(id)
  local line = task_ref[id]
  if line then
    vim.api.nvim_win_set_cursor(0, { line, 0 })
  end
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

function M.reload_from_file()
  if filepath then
    local tasks = persistence.read(filepath)
    if tasks ~= nil then
      data.setup(tasks)
    else
      data.setup({})
      print("invalid input file for todo")
    end
  else
    print("no path set")
  end
end

function M.state_cycle()
  local id = task_id()
  if id then
    data.cycle_state(id)
    redraw()
  end
end

function M.toggle_urgent()
  local id = task_id()
  if id then
    data.toggle_urgent(id)
    redraw()
  end
end

function M.toggle_important()
  local id = task_id()
  if id then
    data.toggle_important(id)
    redraw()
  end
end

function M.delete_shallow()
  local id = task_id()
  if id then
    if data.has_children(id) then
      if vim.fn.confirm("delete task and all children?", "&Yes\n&No", 2) ~= 1 then
        return
      end
    end
    data.copy_task(id)
    data.delete(id)
    redraw()
  end
end

function M.delete_done()
  local id = task_id()
  if id then
    data.delete_done(id)
    redraw()
  end
end

function M.delete_done_all()
  local id = task_id()
  if id then
    data.delete_done_all()
    redraw()
    set_cursor(id)
  end
end

function M.sort()
  local id = task_id()
  if id then
    data.sort()
    redraw()
    set_cursor(id)
  end
end

function M.task_create()
  if buf then
    local title = input_task_name("")
    if title ~= nil then
      data.add_task(title)
      redraw()
    end
  end
end

function M.task_create_child()
  local id = task_id()
  if id then
    local title = input_task_name("")
    if title ~= nil then
      data.add_subtask(title, id)
      redraw()
    end
  end
end

function M.rename()
  local id = task_id()
  if id then
    local title = input_task_name(data.get_title(id))
    if title ~= nil then
      data.rename(title, id)
      redraw()
    end
  end
end

function M.copy_shallow()
  local id = task_id()
  if id ~= nil then
    data.copy_task(id)
  end
end

function M.paste_to_root_shallow()
  if buf then
    data.paste()
    redraw()
  end
end

function M.paste_to_child_shallow()
  local id = task_id()
  if id then
    data.paste_to_child(id)
    redraw()
  end
end

function M.collapse_toggle()
  local id = task_id()
  if id then
    data.collapse_toggle(id)
    redraw()
  end
end

function M.collapse_enable()
  local id = task_id()
  if id then
    data.collapse(id, true)
    redraw()
    set_cursor(id)
  end
end

function M.collapse_disable()
  local id = task_id()
  if id then
    data.collapse(id, false)
    redraw()
  end
end

function M.collapse_smart()
  local id = task_id()
  if id then
    local parent = data.collapse_smart(id)
    redraw()
    if parent then
      set_cursor(parent)
    end
  end
end

function M.to_first_child()
  local id = task_id()
  if id then
    local child = data.get_first_child(id)
    if child then
      data.collapse(id, false)
      redraw()
      set_cursor(child)
    end
  end
end

function M.to_parent()
  local id = task_id()
  if id then
    local parent = data.get_parent(id)
    if parent then
      set_cursor(parent)
    end
  end
end

function M.to_next_neighbor()
  local id = task_id()
  if id then
    local _, next = data.get_neighbors(id)
    if next then
      set_cursor(next)
    end
  end
end

function M.to_prev_neighbor()
  local id = task_id()
  if id then
    local prev, _ = data.get_neighbors(id)
    if prev then
      set_cursor(prev)
    end
  end
end

function M.collapse_toggle_recursive()
  local id = task_id()
  if id then
    data.collapse_recursive(id)
    redraw()
  end
end

function M.collapse_toggle_level()
  local id = task_id()
  if id then
    data.collapse_level(id)
    redraw()
    set_cursor(id)
  end
end

function M.move_delete()
  local id = task_id()
  if id then
    data.move_delete(id)
    redraw()
  end
end

function M.move_paste_to_root()
  if buf then
    data.move()
    redraw()
  end
end

function M.move_paste_to_child()
  local id = task_id()
  if id then
    data.move_to_child(id)
    redraw()
  end
end

function M.notes_open()
  local id = task_id()
  if id then
    util.open_note(
      data.get_title(id),
      data.get_notes(id),
      opts.keymaps.notes,
      function(text)
        vim.schedule(function()
          data.set_notes(id, text)
          redraw()
        end)
      end
    )
  end
end

function M.open()
  if not buf then
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
    for key, fun in pairs(opts.keymaps.tasks) do
      if fun then
        vim.keymap.set("n", key, fun, { buf = buf, nowait = true })
      end
    end
    redraw()
  end
end

function M.update_config(user_opts)
  opts = vim.tbl_deep_extend("force", opts, user_opts)
  filepath = opts.filepath
end

function M.setup(user_opts)
  user_opts = user_opts or {}
  M.update_config(user_opts)
  M.reload_from_file()
  if opts.keymaps.todo_open then
    vim.keymap.set("n", opts.keymaps.todo_open, M.open)
  end
end

opts = {
  filepath = vim.fs.joinpath(vim.fn.stdpath("data"), "todo", "tasks.json"),
  keymaps = {
    todo_open = "<leader>td",
    tasks = {
      ["<space>"] = M.state_cycle,
      ["n"] = M.task_create_child,
      ["N"] = M.task_create,
      ["r"] = M.rename,
      ["<enter>"] = M.collapse_toggle,
      ["l"] = M.collapse_disable,
      ["h"] = M.collapse_smart,
      ["H"] = M.to_parent,
      ["L"] = M.to_first_child,
      ["J"] = M.to_next_neighbor,
      ["K"] = M.to_prev_neighbor,
      ["c"] = M.collapse_toggle_recursive,
      ["C"] = M.collapse_toggle_level,
      ["y"] = M.copy_shallow,
      ["p"] = M.paste_to_child_shallow,
      ["P"] = M.paste_to_root_shallow,
      ["q"] = function()
        vim.cmd("q")
      end,
      ["u"] = M.toggle_urgent,
      ["i"] = M.toggle_important,
      ["o"] = M.notes_open,
      ["d"] = M.delete_shallow,
      ["D"] = M.move_delete,
      ["m"] = M.move_paste_to_child,
      ["M"] = M.move_paste_to_root,
      ["s"] = M.sort,
      ["x"] = M.delete_done,
      ["X"] = M.delete_done_all,
    },
    notes = {
      ["q"] = function()
        vim.cmd("q")
      end,
    },
  },
}

return M
