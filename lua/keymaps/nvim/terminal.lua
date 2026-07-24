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
    vim.cmd("silent buffer " .. buf)
    vim.cmd("silent startinsert")
    return
  end

  if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.cmd("silent terminal pwsh")
  else
    vim.cmd("silent terminal")
  end
  buf = vim.api.nvim_get_current_buf()
  terms[project][name] = buf

  vim.cmd("silent startinsert")
end

vim.keymap.set("n", "<leader>ot", function()
  M.open("")
end)

vim.keymap.set("n", "<leader>oT", function()
  local name = vim.fn.input("terminal name: ")
  if name and #name > 0 then
    M.open(name)
  end
end)
