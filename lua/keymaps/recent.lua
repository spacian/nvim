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

vim.keymap.set("n", "<leader>or", function()
  Jumplist.register()
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

vim.keymap.set("n", "<c-h>", function()
  Jumplist.register()
  local bufname = vim.api.nvim_buf_get_name(0)
  for _, item in ipairs(get_items()) do
    if item.file ~= bufname then
      vim.cmd.edit(item.file)
      break
    end
  end
end)

local function is_lazygit_buffer()
  return vim.api.nvim_buf_get_name(0):match("lazygit") == "lazygit"
end

local enter = vim.api.nvim_replace_termcodes("<enter>", true, true, true)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    if is_lazygit_buffer() then
      return
    end
    vim.opt_local.statuscolumn = ""
    vim.keymap.set({ "n", "x" }, "<c-u>", "", { buffer = true, silent = true })
    vim.keymap.set({ "n", "x" }, "<c-d>", "", { buffer = true, silent = true })
    vim.keymap.set({ "t", "n", "x" }, "<c-u><c-y>", function()
      vim.fn.feedkeys('cd "' .. vim.fn.getcwd() .. '"' .. enter)
    end, { buffer = true })
    vim.keymap.set({ "t", "n", "x" }, "<c-u><c-o>", function()
      local folder = get_items()[1].file:match("(.*)\\.*")
      if folder ~= nil then
        vim.fn.feedkeys('cd "' .. folder .. '"' .. enter)
      end
    end, { buffer = true })
    vim.keymap.set({ "t", "n", "x" }, "<c-u><c-i>", function()
      vim.cmd("silent bd!")
    end, { buffer = true })
    vim.keymap.set({ "t", "n", "x" }, "<c-u><c-u>", function()
      if vim.fn.winnr("$") > 1 then
        vim.cmd("silent close")
        return
      else
        vim.cmd.edit(get_items()[1].file)
      end
    end, { buffer = true })
  end,
})
