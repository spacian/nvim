local M = {}

---@return Node
local create_root = function()
	local root = {
		lnum = 0,
		col = 0,
		bufnr = 0,
		root = true,
		persistent = true,
	}
	root.next = root
	root.prev = root
	return root
end

if M.root == nil then
	M.root = create_root()
	M.cur = M.root
end

---@param persistent boolean
---@return Node
M.create_node = function(persistent)
	local pos = vim.fn.getpos(".")
	return {
		lnum = pos[2],
		col = pos[3],
		bufnr = vim.api.nvim_get_current_buf(),
		root = false,
		prev = M.cur,
		next = M.root,
		persistent = persistent,
	}
end

---@param node Node
M.insert = function(node)
	while node.persistent and not M.cur.persistent do
		M.delete(M.cur)
	end
	M.root.prev.next = M.root.prev
	M.cur.next = node
	node.prev = M.cur
	M.root.prev = node
end

---@param persistent boolean
M.update = function(persistent)
	local pos = vim.fn.getpos(".")
	M.cur.lnum = pos[2]
	M.cur.col = pos[3]
	M.cur.persistent = M.cur.persistent or persistent
end

---@param node Node
M.delete = function(node)
	if node.root then
		return
	end
	node.next.prev = node.prev
	node.prev.next = node.next
	if M.cur == node then
		if not node.prev.root then
			M.cur = node.prev
		else
			M.cur = node.next
		end
	end
	node.prev = node
	node.next = node
end

---@param a Node
---@param b Node
---@return boolean
local nodes_equal_soft = function(a, b)
	return not a.root and not b.root and a.bufnr == b.bufnr and math.abs(a.lnum - b.lnum) < 9
end

---@param a Node
---@param b Node
---@return boolean
local nodes_equal_hard = function(a, b)
	return nodes_equal_soft(a, b) and a.lnum == b.lnum
end

M.setpos = function()
	while not M.cur.root and not vim.api.nvim_buf_is_valid(M.cur.bufnr) do
		M.delete(M.cur)
	end
	if not M.cur.root then
		local current_buf = vim.api.nvim_get_current_buf()
		if M.cur.bufnr ~= current_buf then
			vim.cmd("b" .. M.cur.bufnr)
		end
		vim.fn.setpos(".", { 0, M.cur.lnum, M.cur.col, 0 })
		-- print(M.cur.prev.lnum, M.cur.lnum, M.cur.next.lnum, M.cur.persistent)
	end
end

---@param persistent boolean|nil
M.register = function(persistent)
	if persistent == nil then
		persistent = true
	end
	if BufIsSpecial(vim.api.nvim_buf_get_name(0)) then
		return
	end
	local node = M.create_node(persistent)
	if nodes_equal_soft(M.cur, node) then
		M.update(persistent)
	else
		M.insert(node)
		M.cur = M.cur.next
	end
end

M.jump_back = function()
	if M.cur.root then
		M.register()
	end
	local node = M.create_node(false)
	if nodes_equal_soft(M.cur, node) then
		-- todo
		if not nodes_equal_hard(M.cur, node) then
			M.setpos()
			return
		else
			while (M.cur.persistent and not M.cur.prev.persistent) or nodes_equal_soft(M.cur, M.cur.prev) do
				M.delete(M.cur.prev)
			end
			M.update(false)
			if not M.cur.prev.root then
				M.cur = M.cur.prev
			end
			M.setpos()
			return
		end
	end
	M.insert(node)
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
		local node = M.create_node(false)
		if nodes_equal_soft(node, M.cur) then
			M.update(false)
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
}

return JumpList

---@class Node
---@field lnum number
---@field col number
---@field bufnr number
---@field next Node
---@field prev Node
---@field root boolean
---@field persistent boolean
