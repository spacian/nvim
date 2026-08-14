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

local function cursor_down()
  vim.api.nvim_feedkeys("j", "n", true)
end

local function cursor_up()
  vim.api.nvim_feedkeys("k", "n", true)
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

---@param name string
---@return string?
local function validate_name(name)
  if name:match("^%s*$") ~= nil then
    print("invalid name '" .. name .. "'")
    return nil
  end
  return name
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

function M.priority_cycle_increase()
  local id = task_id()
  if id then
    data.cycle_prio_increase(id)
    redraw()
  end
end

function M.priority_cycle_decrease()
  local id = task_id()
  if id then
    data.cycle_prio_decrease(id)
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

function M.sort_offset_set()
  local id = task_id()
  if id then
    local offset = data.sort_offset_get(id)
    local text = offset and tostring(offset) or ""
    util.open_oneline_window(
      "Task Sort Offset",
      text,
      opts.keymaps.floating,
      function(new_offset)
        if #new_offset == 0 then
          data.sort_offset_set(id, 0)
          return
        end
        local value = tonumber(new_offset)
        if value then
          data.sort_offset_set(id, value)
        end
      end
    )
  end
end

function M.task_create()
  if buf then
    util.open_oneline_window("New Task", "", opts.keymaps.floating, function(title)
      local validated = validate_name(title)
      if validated then
        data.add_task(validated)
        redraw()
      end
    end)
  end
end

function M.task_create_child()
  local id = task_id()
  if id then
    util.open_oneline_window(
      "New Child Task",
      "",
      opts.keymaps.floating,
      function(title)
        local validated = validate_name(title)
        if validated then
          data.add_subtask(validated, id)
          redraw()
        end
      end
    )
  end
end

function M.rename()
  local id = task_id()
  if id then
    util.open_oneline_window(
      "Rename Task",
      data.get_title(id),
      opts.keymaps.floating,
      function(title)
        local validated = validate_name(title)
        if validated then
          data.rename(validated, id)
          redraw()
        end
      end
    )
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

function M.collapse_disable_smart()
  local id = task_id()
  if id then
    if data.collapsed(id) then
      data.collapse(id, false)
      redraw()
    else
      local child = data.get_first_child(id)
      if child then
        set_cursor(child)
      else
        cursor_down()
      end
    end
  end
end

function M.collapse_smart()
  local id = task_id()
  if id then
    local new_id = data.collapse_smart(id)
    redraw()
    print(new_id)
    if new_id then
      set_cursor(new_id)
    else
      cursor_up()
    end
  end
end

function M.to_first_child_or_next()
  local id = task_id()
  if id then
    local child = data.get_first_child(id)
    if child then
      data.collapse(id, false)
      redraw()
      set_cursor(child)
    else
      cursor_down()
    end
  end
end

function M.to_parent()
  local id = task_id()
  if id then
    local parent = data.get_parent(id)
    if parent then
      set_cursor(parent)
    else
      cursor_up()
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
      opts.keymaps.floating,
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
    buf = util.open_task_window()
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
      ["p"] = M.priority_cycle_increase,
      ["P"] = M.priority_cycle_decrease,
      ["n"] = M.task_create_child,
      ["N"] = M.task_create,
      ["r"] = M.rename,
      ["<enter>"] = M.collapse_toggle,
      ["l"] = M.collapse_disable_smart,
      ["h"] = M.collapse_smart,
      ["H"] = M.to_parent,
      ["L"] = M.to_first_child_or_next,
      ["J"] = M.to_next_neighbor,
      ["K"] = M.to_prev_neighbor,
      ["c"] = M.collapse_toggle_recursive,
      ["C"] = M.collapse_toggle_level,
      ["y"] = M.copy_shallow,
      ["i"] = M.paste_to_child_shallow,
      ["I"] = M.paste_to_root_shallow,
      ["q"] = function()
        vim.cmd("q")
      end,
      ["o"] = M.notes_open,
      ["O"] = M.sort_offset_set,
      ["d"] = M.delete_shallow,
      ["D"] = M.move_delete,
      ["m"] = M.move_paste_to_child,
      ["M"] = M.move_paste_to_root,
      ["s"] = M.sort,
      ["x"] = M.delete_done,
      ["X"] = M.delete_done_all,
    },
    floating = {
      ["q"] = function()
        vim.cmd("q")
      end,
      ["<esc>"] = function()
        vim.cmd("q")
      end,
    },
  },
}

return M
