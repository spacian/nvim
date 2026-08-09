require("vimconf")
require("utils")
Jumplist = require("modules.jumplist")
local todo = require("modules.todo")

local std_path = vim.fs.joinpath(vim.fn.stdpath("data"), "todo", "tasks.json")
todo.setup({
  filepath = std_path,
  keymaps = {
    todo_open = false,
  },
})
local last_path = std_path

vim.keymap.set("n", "<leader>tD", function()
  local path = vim.fs.joinpath(vim.fn.getcwd(), "tasks.json")
  if path ~= last_path then
    last_path = path
    todo.update_config({ filepath = path })
    todo.reload_from_file()
  end
  todo.open()
end)

vim.keymap.set("n", "<leader>td", function()
  if std_path ~= last_path then
    last_path = std_path
    todo.update_config({ filepath = last_path })
    todo.reload_from_file()
  end
  todo.open()
end)
