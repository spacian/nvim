local path = vim.fs.joinpath(vim.fn.stdpath("data"), "todo", "tasks.json")

local api = require("modules.todo.api")
api.setup(path)
vim.keymap.set("n", "<leader>td", api.open)
