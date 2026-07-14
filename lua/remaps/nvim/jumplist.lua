local M = {}

local persistence_jump = 1
local soft_equal_line_count = 6
local max_node_count = 100

---@return Node
local create_root = function()
  local root = {
    lnum = 0,
    col = 0,
    bufnr = 0,
    root = true,
    persistence = 0,
  }
  root.next = root
  root.prev = root
  return root
end

if M.root == nil then
  M.root = create_root()
  M.cur = M.root
end

---@param persistence number
---@return Node
M.create_node = function(persistence)
  local pos = vim.fn.getpos(".")
  return {
    lnum = pos[2],
    col = pos[3],
    bufnr = vim.api.nvim_get_current_buf(),
    root = false,
    prev = M.root,
    next = M.root,
    persistence = persistence,
  }
end

---@param node Node
---@param after_node Node
M.insert_after = function(node, after_node)
  local prev = after_node
  local next = after_node.next
  prev.next = node
  node.prev = prev
  node.next = next
  next.prev = node
end

---@param old Node
---@param new Node
---@param force boolean
M.update = function(old, new, force)
  old.lnum = new.lnum
  old.col = new.col
  if force then
    old.persistence = math.min(old.persistence, new.persistence)
  end
end

---@param node Node
M.delete = function(node)
  if node.root then
    return
  end
  if M.cur == node then
    if not node.prev.root then
      M.cur = node.prev
    else
      M.cur = node.next
    end
  end
  local prev = node.prev
  local next = node.next
  prev.next = next
  next.prev = prev
  node.next = node
  node.prev = node
end

---@param node Node
local validate_lnum_col = function(node)
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
local nodes_equal_soft = function(a, b)
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
local nodes_equal_hard = function(a, b)
  return nodes_equal_soft(a, b) and a.lnum == b.lnum
end

---@param node Node
M.setpos = function(node)
  if not node.root then
    local current_buf = vim.api.nvim_get_current_buf()
    if node.bufnr ~= current_buf then
      vim.cmd("b " .. M.cur.bufnr)
    end
    validate_lnum_col(node)
    vim.fn.setpos(".", { 0, node.lnum, node.col, 0 })
  end
end

---@param persistence number|nil
M.register = function(persistence)
  persistence = persistence or 0
  if BufIsSpecial() then
    return
  end
  local node = M.create_node(persistence)
  if nodes_equal_soft(M.cur, node) then
    M.update(M.cur, node, true)
  else
    M.insert_after(node, M.cur)
    M.cur = M.cur.next
    while not M.cur.next.root do
      M.delete(M.cur.next)
    end
  end
end

M.cleanup = function()
  local node = M.root.prev
  if node.root then
    return
  end

  while not node.root do
    local prev = node.prev
    if not (vim.bo[node.bufnr].buflisted and vim.api.nvim_buf_is_valid(node.bufnr)) then
      M.delete(node)
    end
    node = prev
  end

  local node = M.root.prev
  if node.root then
    return
  end
  local node_count = 1
  while not node.prev.root do
    if
      nodes_equal_soft(node, node.prev) or node.persistence < node.prev.persistence
    then
      M.delete(node.prev)
    else
      node = node.prev
      node_count = node_count + 1
    end
  end
  while node_count > max_node_count do
    node_count = node_count - 1
    M.delete(M.root.next)
  end
end

M.jump_back = function()
  if M.cur.root then
    M.register()
  end
  local node = M.create_node(persistence_jump)
  if nodes_equal_soft(M.cur, node) then
    M.update(M.cur, node, false)
    if not M.cur.prev.root then
      M.cur = M.cur.prev
    end
  elseif not BufIsSpecial() then
    M.insert_after(node, M.cur)
  end
  M.cleanup()
  M.setpos(M.cur)
end

M.reset = function()
  local next = M.root.next
  local prev = M.root.prev
  next.prev = next
  prev.next = prev
  M.cur = M.root
  M.root.next = M.root
  M.root.prev = M.root
end

M.jump_forward = function()
  if M.cur.root then
    M.register()
  end
  M.cleanup()
  local node = M.create_node(persistence_jump)
  if nodes_equal_soft(node, M.cur) then
    M.update(M.cur, node, false)
  elseif not BufIsSpecial() then
    M.insert_after(node, M.cur)
    M.cur = M.cur.next
  end
  if not M.cur.next.root then
    M.cur = M.cur.next
  end
  M.setpos(M.cur)
end

---@return Position[]
M.get_positions = function()
  M.cleanup()
  local node = M.root
  ---@type Position[]
  local positions = {}
  while not node.prev.root do
    node = node.prev
    positions[#positions + 1] = { lnum = node.lnum, col = node.col, bufnr = node.bufnr }
  end
  return positions
end

---@param persistence number|nil
M.insert = function(persistence)
  persistence = persistence or 0
  local node = M.create_node(persistence)
  if nodes_equal_soft(M.cur, node) then
    M.update(M.cur, node, false)
  else
    M.insert_after(node, M.cur)
    M.cur = M.cur.next
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
---@field persistence number

---@class Position
---@field bufnr number
---@field lnum number
---@field col number
