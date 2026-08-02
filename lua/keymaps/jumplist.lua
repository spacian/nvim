local M = {}
local roots = {}
local currents = {}

local soft_equal_line_count = 6
local max_node_count = 100

---@return Node
local function create_root()
  local root = {
    lnum = 0,
    col = 0,
    bufnr = 0,
    root = true,
  }
  root.next = root
  root.prev = root
  return root
end

---@param node Node
local function validate_lnum_col(node)
  local lnum = vim.api.nvim_buf_line_count(node.bufnr)
  lnum = math.max(1, math.min(node.lnum, lnum))
  local line = vim.api.nvim_buf_get_lines(node.bufnr, lnum - 1, lnum, false)[1] or ""
  local col = math.max(1, math.min(node.col, #line + 1))
  node.lnum = lnum
  node.col = col
end

---@param a Node
---@param b Node
---@return boolean
local function nodes_equal_soft(a, b)
  if a.root or b.root or a.bufnr ~= b.bufnr then
    return false
  end
  validate_lnum_col(a)
  validate_lnum_col(b)
  return math.abs(a.lnum - b.lnum) < soft_equal_line_count
end

---@param a Node
---@param b Node
---@return boolean
local function nodes_equal_hard(a, b)
  return nodes_equal_soft(a, b) and a.lnum == b.lnum
end

---@param node Node
---@param after_node Node
local function insert_after(node, after_node)
  local prev = after_node
  local next = after_node.next
  prev.next = node
  node.prev = prev
  node.next = next
  next.prev = node
end

---@param old Node
---@param new Node
local function update(old, new)
  old.lnum = new.lnum
  old.col = new.col
end

---@param node Node
local function setpos(node)
  if not node.root then
    local current_buf = vim.api.nvim_get_current_buf()
    if node.bufnr ~= current_buf then
      vim.cmd("b " .. node.bufnr)
    end
    validate_lnum_col(node)
    vim.fn.setpos(".", { 0, node.lnum, node.col, 0 })
  end
end

---@return string
M.key = function()
  return vim.fn.getcwd()
end

---@return Node
M.root = function()
  local key = M.key()
  if not roots[key] then
    roots[key] = create_root()
    currents[key] = roots[key]
  end
  return roots[key]
end

---@return Node
M.get_cur = function()
  local key = M.key()
  if not currents[key] then
    M.root()
  end
  return currents[key]
end

---@param node Node
M.set_cur = function(node)
  currents[M.key()] = node
end

---@return Node
M.create_node = function()
  local pos = vim.fn.getpos(".")
  return {
    lnum = pos[2],
    col = pos[3],
    bufnr = vim.api.nvim_get_current_buf(),
    root = false,
    prev = M.root(),
    next = M.root(),
  }
end

---@param node Node
M.delete = function(node)
  if node.root then
    return
  end
  if M.get_cur() == node then
    if not node.prev.root then
      M.set_cur(node.prev)
    else
      M.set_cur(node.next)
    end
  end
  local prev = node.prev
  local next = node.next
  prev.next = next
  next.prev = prev
  node.next = node
  node.prev = node
end

M.register = function()
  if BufIsSpecial() then
    return
  end
  local node = M.create_node()
  if nodes_equal_soft(M.get_cur(), node) then
    update(M.get_cur(), node)
  else
    insert_after(node, M.get_cur())
    M.set_cur(M.get_cur().next)
    while not M.get_cur().next.root do
      M.delete(M.get_cur().next)
    end
  end
end

M.cleanup = function()
  local node = M.root().prev
  if node.root then
    return
  end

  while not node.root do
    local prev = node.prev
    if
      (not vim.fn.bufexists(node.bufnr))
      or BufIsSpecial(node.bufnr)
    then
      M.delete(node)
    end
    node = prev
  end

  node = M.root().prev
  if node.root then
    return
  end

  local node_count = 1
  while not node.prev.root do
    if nodes_equal_soft(node, node.prev) then
      M.delete(node.prev)
    else
      node = node.prev
      node_count = node_count + 1
    end
  end
  while node_count > max_node_count do
    node_count = node_count - 1
    M.delete(M.root().next)
  end
end

M.jump_back = function()
  if M.get_cur().root then
    M.register()
  end
  local node = M.create_node()
  if nodes_equal_soft(M.get_cur(), node) then
    update(M.get_cur(), node)
    if not M.get_cur().prev.root then
      M.set_cur(M.get_cur().prev)
    end
  elseif not BufIsSpecial() then
    insert_after(node, M.get_cur())
    local next = M.get_cur().next
    while not next.next.root do
      M.delete(next.next)
    end
  end
  M.cleanup()
  setpos(M.get_cur())
end

M.jump_forward = function()
  if M.get_cur().root then
    M.register()
  end
  M.cleanup()
  local node = M.create_node()
  if nodes_equal_soft(node, M.get_cur()) then
    update(M.get_cur(), node)
  elseif not BufIsSpecial() then
    insert_after(node, M.get_cur())
    M.set_cur(M.get_cur().next)
  end
  if not M.get_cur().next.root then
    M.set_cur(M.get_cur().next)
  end
  setpos(M.get_cur())
end

---@return Position[]
M.get_positions = function()
  M.cleanup()
  local node = M.root()
  ---@type Position[]
  local positions = {}
  while not node.prev.root do
    node = node.prev
    positions[#positions + 1] = { lnum = node.lnum, col = node.col, bufnr = node.bufnr }
  end
  return positions
end

M.insert = function()
  local node = M.create_node()
  if nodes_equal_soft(M.get_cur(), node) then
    update(M.get_cur(), node)
  else
    insert_after(node, M.get_cur())
    M.set_cur(M.get_cur().next)
  end
end

local JumpList = {
  get_positions = M.get_positions,
  insert = M.insert,
  jump_back = M.jump_back,
  jump_forward = M.jump_forward,
  register = M.register,
  reset = M.reset,
}

return JumpList

---@class Node
---@field lnum number
---@field col number
---@field bufnr number
---@field next Node
---@field prev Node
---@field root boolean

---@class Position
---@field bufnr number
---@field lnum number
---@field col number
