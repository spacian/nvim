local M = {}

---@param path string
---@param tasks Task[]
function M.write(path, tasks)
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  local fd = vim.uv.fs_open(path, "w", 420)
  if fd ~= nil then
    vim.uv.fs_write(fd, vim.json.encode(tasks))
    vim.uv.fs_close(fd)
  end
end

---@param path string
---@return Task[]?
function M.read(path)
  local fd = vim.uv.fs_open(path, "r", 438)

  if fd == nil then
    return {}
  end

  local stat = vim.uv.fs_fstat(fd)
  if stat == nil then
    vim.uv.fs_close(fd)
    print("file does not exist")
    return nil
  end

  local content = vim.uv.fs_read(fd, stat.size, 0)
  vim.uv.fs_close(fd)

  if content == nil then
    print("content is nil")
    return nil
  end

  local ok, tasks = pcall(vim.json.decode, content)

  if not ok or not vim.islist(tasks) then
    print("failed decode")
    return nil
  end

  return tasks
end

return M
