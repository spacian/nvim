local items = {}

local open = function(item)
  vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
      local success = pcall(vim.api.nvim_win_set_cursor, 0, item.real_pos)
      if not success then
        vim.defer_fn(function()
          pcall(vim.api.nvim_win_set_cursor, 0, item.real_pos)
        end, 50)
      end
    end,
  })
  vim.cmd.edit(item.file)
end

local workspace_file = function()
  local cwd = vim.fn.getcwd()
  local name = vim.fs.basename(cwd)
  local id = vim.fn.sha256(cwd)
  local filename = string.format("%s-%s.mpack", name, id)
  return vim.fs.joinpath(vim.fn.stdpath("data"), "persistent_marks", filename)
end

local get_items = function()
  local list = {}
  for _, v in pairs(items) do
    list[#list + 1] = v
  end
  table.sort(items, function(a, b)
    return a.label > b.label
  end)
  return list
end

local M = {}
local jumplist = require("remaps.nvim.jumplist")

M.save = function()
  local path = workspace_file()
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  local f = assert(io.open(path, "wb"))
  f:write(vim.mpack.encode(items))
  f:close()
end

M.load = function()
  local path = workspace_file()
  local f = io.open(path, "rb")
  if not f then
    items = {}
    return
  end
  items = vim.mpack.decode(f:read("*a"))
  f:close()
end

M.open = function()
  local label = vim.fn.getcharstr()
  if not label:match("^[a-zA-Z]$") then
    return
  end
  local item = items[label]
  if item == nil then
    vim.notify("no mark labelled '" .. label .. "'", vim.diagnostic.severity.INFO)
    return
  end
  jumplist.register(1)
  open(item)
end

M.mark = function()
  local label = vim.fn.getcharstr()
  if not label:match("[a-zA-Z]") then
    return
  end
  items[label] = {
    text = label,
    label = label,
    file = vim.api.nvim_buf_get_name(0),
    pos = { vim.fn.line("."), 0 },
    real_pos = { vim.fn.line("."), vim.fn.col(".") - 1 },
  }
  print("buffer marked '" .. label .. "'")
  M.save()
end

M.picker = function()
  local item_list = get_items()
  jumplist.register(1)
  require("snacks").picker({
    title = "marks",
    preview = "file",
    items = item_list,
    confirm = function(picker, item)
      picker:close()
      open(item)
    end,
    actions = {
      delete = function(picker)
        local item = picker:current()
        items[item.label] = nil
        picker.opts.items = get_items()
        picker:find()
        M.save()
      end,
    },
    win = {
      input = {
        keys = {
          ["<c-x>"] = { "delete", mode = { "n", "i" } },
        },
      },
    },
  })
end

vim.api.nvim_create_autocmd({ "SessionLoadPost", "VimEnter" }, {
  callback = function()
    M.load()
  end,
})

vim.keymap.set("n", "m", M.open)
vim.keymap.set("n", "<leader>m", M.mark)
vim.keymap.set("n", "<leader>om", M.picker)
