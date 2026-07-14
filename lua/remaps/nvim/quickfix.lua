local jumplist = require("remaps.nvim.jumplist")
local function filter_file(filter_by)
  if filter_by == nil then
    filter_by = vim.fn.getcwd():lower():gsub("\\", "/")
  end
  local qf = vim.fn.getqflist()
  local filtered = {}
  for _, item in ipairs(qf) do
    local bufnr = tonumber(item.bufnr)
    if bufnr ~= nil then
      local name = vim.api.nvim_buf_get_name(bufnr):lower():gsub("\\", "/")
      if name:match(filter_by) then
        table.insert(filtered, item)
      end
    end
  end
  return filtered
end

local function fill_qflist()
  local items = vim.diagnostic.toqflist(vim.diagnostic.get())
  vim.fn.setqflist({}, "r", { items = items })
  vim.fn.setqflist(filter_file())
end

local function filter_type(filter_by)
  local qf = vim.fn.getqflist()
  local filtered = {}
  for _, item in ipairs(qf) do
    if item.type:match(filter_by) then
      table.insert(filtered, item)
    end
  end
  return filtered
end

local function open_qf()
  if #vim.fn.getqflist() > 0 then
    jumplist.register()
    vim.cmd("copen")
  else
    vim.cmd("cclose")
  end
end

vim.api.nvim_create_user_command("QOpen", function()
  open_qf()
end, {})

vim.api.nvim_create_user_command("QDiagnostic", function()
  fill_qflist()
  open_qf()
end, {})

vim.api.nvim_create_user_command("QClose", function()
  vim.cmd("cclose")
end, {})

vim.api.nvim_create_user_command("QError", function()
  fill_qflist()
  vim.fn.setqflist(filter_type("E"))
  open_qf()
end, {})

vim.api.nvim_create_user_command("QWarn", function()
  fill_qflist()
  vim.fn.setqflist(filter_type("W"))
  open_qf()
end, {})

vim.api.nvim_create_user_command("QInfo", function()
  fill_qflist()
  vim.fn.setqflist(filter_type("I"))
  open_qf()
end, {})

vim.api.nvim_create_user_command("QNote", function()
  fill_qflist()
  vim.fn.setqflist(filter_type("N"))
  open_qf()
end, {})

vim.api.nvim_create_user_command("QFilterType", function()
  vim.fn.setqflist(filter_type(vim.fn.input("filter qflist by type (E/W/I/N): ", "E")))
end, {})

vim.api.nvim_create_user_command("QFilterFile", function()
  vim.fn.setqflist(filter_file(vim.fn.input("filter qflist by file: ")))
end, {})

vim.api.nvim_create_user_command("QFilterDescription", function()
  local qf = vim.fn.getqflist()
  local filtered = {}
  local filter_by = vim.fn.input("filter qflist by description: ")
  for _, item in ipairs(qf) do
    if item.text:match(filter_by) then
      table.insert(filtered, item)
    end
  end
  vim.fn.setqflist(filtered)
end, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args)
    vim.keymap.set("n", "<c-l>", function()
      Feedkeys("<enter>")
      vim.schedule(function()
        vim.cmd("wincmd p")
      end)
    end, { buf = args.buf })

    vim.keymap.set("n", "<c-o>", "<nop>", { buf = args.buf })
    vim.keymap.set("n", "<c-i>", "<nop>", { buf = args.buf })

    vim.keymap.set("n", "<c-e>", function()
      vim.cmd("Refresh")
    end, { buf = args.buf })

    vim.api.nvim_buf_create_user_command(args.buf, "Edit", function()
      vim.cmd("Refresh")
    end, {})

    vim.api.nvim_buf_create_user_command(args.buf, "E", function()
      vim.cmd("Refresh")
    end, {})

    vim.api.nvim_buf_create_user_command(args.buf, "Quit", function()
      vim.cmd("cclose")
    end, {})

    vim.api.nvim_buf_create_user_command(args.buf, "Q", function()
      vim.cmd("cclose")
    end, {})
  end,
})
