local M = {}

local persistence_jump = 1
local soft_equal_line_count = 6

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
		prev = M.cur,
		next = M.root,
		persistence = persistence,
	}
end

---@param node Node
M.insert = function(node)
	while node.persistence < M.cur.persistence do
		M.delete(M.cur)
	end
	M.root.prev.next = M.root.prev
	M.cur.next = node
	node.prev = M.cur
	M.root.prev = node
end

---@param persistence number
M.update = function(persistence)
	local pos = vim.fn.getpos(".")
	M.cur.lnum = pos[2]
	M.cur.col = pos[3]
	M.cur.persistence = math.min(M.cur.persistence, persistence)
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
	node.next.prev = node.prev
	node.prev.next = node.next
	node.prev = node
	node.next = node
end

---@param node Node
---@return Node
local validate_lnum_col = function(node)
	local lnum = vim.api.nvim_buf_line_count(node.bufnr)
	lnum = math.max(1, math.min(node.lnum, lnum))
	local line = vim.api.nvim_buf_get_lines(node.bufnr, lnum - 1, lnum, false)[1] or ""
	local col = math.max(1, math.min(node.col, #line + 1))
	node.lnum = lnum
	node.col = col
	return node
end

---@param a Node
---@param b Node
---@return boolean
local nodes_equal_soft = function(a, b)
	if a.root or b.root or a.bufnr ~= b.bufnr then
		return false
	end
	a = validate_lnum_col(a)
	b = validate_lnum_col(b)
	return math.abs(a.lnum - b.lnum) < soft_equal_line_count
end

---@param a Node
---@param b Node
---@return boolean
local nodes_equal_hard = function(a, b)
	return nodes_equal_soft(a, b) and a.lnum == b.lnum
end

M.setpos = function()
	while not (M.cur.root or vim.api.nvim_buf_is_valid(M.cur.bufnr)) do
		M.delete(M.cur)
	end
	if not M.cur.root then
		local current_buf = vim.api.nvim_get_current_buf()
		if M.cur.bufnr ~= current_buf then
			vim.cmd("b" .. M.cur.bufnr)
		end
		M.cur = validate_lnum_col(M.cur)
		vim.fn.setpos(".", { 0, M.cur.lnum, M.cur.col, 0 })
	end
end

---@param persistence number|nil
M.register = function(persistence)
	if persistence == nil or M.cur.root then
		persistence = 0
	end
	if BufIsSpecial() then
		return
	end
	local node = M.create_node(persistence)
	if nodes_equal_soft(M.cur, node) then
		M.update(persistence)
	else
		M.insert(node)
		M.cur = M.cur.next
	end
end

M.jump_back = function()
	if M.cur.root then
		M.register()
	end
	local node = M.create_node(persistence_jump)
	if nodes_equal_soft(M.cur, node) then
		while
			(math.min(M.cur.persistence, node.persistence) < M.cur.prev.persistence)
			or nodes_equal_soft(M.cur, M.cur.prev)
		do
			M.delete(M.cur.prev)
		end
		M.update(M.cur.persistence)
		if not M.cur.prev.root then
			M.cur = M.cur.prev
		end
	else
		M.insert(node)
	end
	M.setpos()
end

M.reset = function()
	local next = M.root.next
	local prev = M.root.prev
	next.prev = next
	prev.next = prev
	M.cur = M.root
	M.cur.next = M.root
	M.cur.prev = M.root
end

M.jump_forward = function()
	if M.cur.root then
		M.register()
	end
	if not M.cur.next.root then
		local node = M.create_node(persistence_jump)
		if nodes_equal_soft(node, M.cur) then
			M.update(persistence_jump)
		end
		M.cur = M.cur.next
	end
	M.setpos()
end

local JumpList = {
	reset = M.reset,
	register = M.register,
	jump_back = M.jump_back,
	jump_forward = M.jump_forward,
	delete = function()
		M.delete(M.cur)
	end,
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
