local M = {}

local files = {}
local count = 0

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local project = vim.fn.getcwd()
    files[project] = files[project] or {}
    if not BufIsSpecial(args.buf) then
      files[project][vim.api.nvim_buf_get_name(args.buf)] = count
      count = count + 1
    end
  end,
})

local jumplist = require("keymaps.nvim.jumplist")

vim.keymap.set("n", "<leader>or", function()
  jumplist.register()
  local get_items = function()
    local items = {}
    for bufname, nr in pairs(files[vim.fn.getcwd()] or {}) do
      local bufnr = vim.fn.bufnr(bufname)
      if bufnr ~= -1 and not BufIsSpecial(bufnr) then
        items[#items + 1] = {
          text = bufname,
          file = bufname,
          nr = nr,
        }
      end
    end
    table.sort(items, function(a, b)
      return a.nr > b.nr
    end)
    return items
  end
  require("snacks").picker({
    title = "Recent",
    layout = "select",
    items = get_items(),
    actions = {
      delete = function(picker, item)
        if item then
          files[vim.fn.getcwd()][item.file] = nil
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
