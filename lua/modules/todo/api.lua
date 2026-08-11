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

---@type number?
local buf = nil

---@type boolean
local collapse_all = true

---@param ubuf number
---@param tasks Task[]
local function update(ubuf, tasks)
  line_ref = renderer.render(ubuf, tasks)
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

function M.delete_shallow()
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

function M.task_create()
  if buf then
    local title = input_task_name("")
    if title ~= nil then
      data.add_task(title)
      update(buf, data.tasks())
    end
  end
end

function M.task_create_child()
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

function M.copy_shallow()
  local id = task_id()
  if id ~= nil then
    data.copy_task(id)
  end
end

function M.paste_to_root_shallow()
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

function M.collapse_toggle()
  local id = task_id()
  if buf and id then
    data.collapse(id)
    update(buf, data.tasks())
  end
end

function M.collapse_recursive()
  local id = task_id()
  if buf and id then
    data.collapse_recursive(id)
    update(buf, data.tasks())
  end
end

---@param collapse boolean
function M.collapse_all(collapse)
  if buf then
    data.collapse_all(collapse)
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

function M.move_paste_to_root()
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

function M.notes_open()
  local id = task_id()
  if buf and id then
    util.open_note(
      data.get_title(id),
      data.get_notes(id),
      opts.keymaps.notes,
      function(text)
        vim.schedule(function()
          data.set_notes(id, text)
          update(buf, data.tasks())
        end)
      end
    )
  end
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
    for key, fun in pairs(opts.keymaps.tasks) do
      if fun then
        vim.keymap.set("n", key, fun, { buf = buf, nowait = true })
      end
    end
    update(buf, data.tasks())
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
      ["c"] = M.collapse_recursive,
      ["C"] = function()
        M.collapse_all(collapse_all)
        collapse_all = not collapse_all
      end,
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
    },
    notes = {
      ["q"] = function()
        vim.cmd("q")
      end,
    },
  },
}

return M
