if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.keymap.set(
    { "t" },
    "<c-e><c-s>",
    [[python -c "import sys; print(sys.executable)"<enter>]]
  )
  vim.keymap.set({ "t" }, "<c-e><c-a>", [[.\.venv\Scripts\activate<enter>]])
  vim.keymap.set({ "t" }, "<c-e><c-d>", [[deactivate<enter>]])
else
  vim.keymap.set(
    { "t" },
    "<c-e><c-s>",
    [[python3 -c "import sys; print(sys.executable)"<enter>]]
  )
  vim.keymap.set({ "t" }, "<c-e><c-a>", [[./.venv/bin/activate<enter>]])
  vim.keymap.set({ "t" }, "<c-e><c-d>", [[deactivate<enter>]])
end

local M = {}

local terms = {}

function M.open(name)
  local project = vim.fn.getcwd()
  terms[project] = terms[project] or {}

  local buf = terms[project][name]

  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.cmd.buffer(buf)
    vim.cmd.startinsert()
    return
  end

  if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.cmd.terminal("pwsh")
  else
    vim.cmd.terminal()
  end
  buf = vim.api.nvim_get_current_buf()
  terms[project][name] = buf

  vim.cmd.startinsert()
end

local jumplist = require("keymaps.nvim.jumplist")
vim.keymap.set("n", "<leader>ot", function()
  jumplist.register()
  M.open("")
end)

vim.keymap.set("n", "<leader>oT", function()
  jumplist.register()
  local get_items = function()
    local items = {}
    for name, bufnr in pairs(terms[vim.fn.getcwd()] or {}) do
      if name ~= "" and vim.api.nvim_buf_is_valid(bufnr) then
        items[#items + 1] = {
          text = name,
          label = name,
          buf = bufnr,
        }
      end
    end
    items[#items + 1] = { text = "<new>", label = "<new>", new = true }
    return items
  end
  require("snacks").picker({
    title = "Terminals",
    layout = "select",
    items = get_items(),
    confirm = function(picker, item)
      picker:close()
      if item.new then
        item.label = vim.fn.input("terminal name: ")
      end
      if item.label and item.label ~= "" then
        vim.schedule(function()
          M.open(item.label)
        end)
      end
    end,
    actions = {
      delete = function(picker, item)
        if item and item.label ~= "new" then
          vim.cmd("silent bd! " .. terms[vim.fn.getcwd()][item.label])
          terms[vim.fn.getcwd()][item.label] = nil
          picker.opts.items = get_items()
          picker:refresh()
        end
      end,
    },
    win = {
      input = {
        keys = {
          ["<c-x>"] = { "delete", mode = { "i", "n" } },
        },
      },
    },
  })
end)
