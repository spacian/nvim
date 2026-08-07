local M = {}
local util = require("modules.todo.util")

---@param path string
---@param tasks Task[]
function M.write(path, tasks)
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  local fd = assert(vim.uv.fs_open(path, "w", 420))
  vim.uv.fs_write(fd, vim.json.encode(tasks))
  vim.uv.fs_close(fd)
end

---@param path string
---@return Task[]?
function M.read(path)
  local fd = vim.uv.fs_open(path, "r", 438)

  if not fd then
    return {}
  end

  local stat = assert(vim.uv.fs_fstat(fd))
  local content = assert(vim.uv.fs_read(fd, stat.size, 0))
  vim.uv.fs_close(fd)

  local ok, tasks = pcall(vim.json.decode, content)

  if not ok or not vim.islist(tasks) then
    print("failed decode")
    return nil
  end

  for _, task in ipairs(tasks) do
    if not util.is_task(task) then
      print("not a task")
      return nil
    end
  end

  return tasks
end

return M
