local M = {}
---@return Node
local create_root = function()
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

if M.root == nil then
	M.root = create_root()
	M.cur = M.root
end

---@return Node
M.create_node = function()
	local pos = vim.fn.getpos(".")
	return {
		lnum = pos[2],
		col = pos[3],
		bufnr = vim.api.nvim_get_current_buf(),
		root = false,
		prev = M.cur,
		next = M.root,
	}
end

---@param node Node
M.insert = function(node)
	M.cur.next = node
end

M.update = function()
	local pos = vim.fn.getpos(".")
	M.cur.lnum = pos[2]
	M.cur.col = pos[3]
end

M.delete = function()
	if M.cur.root then
		M.cur.prev.next = M.cur.next
		M.cur.next.prev = M.cur.prev
		if M.cur.prev.root then
			M.cur = M.cur.next
		else
			M.cur = M.cur.prev
		end
	end
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
	return nodes_equal_soft(a, b) and a.col == b.col and a.lnum == b.lnum
end

M.setpos = function()
	if not M.cur.root then
		local current_buf = vim.api.nvim_get_current_buf()
		if M.cur.bufnr ~= current_buf then
			vim.cmd("b" .. M.cur.bufnr)
		end
		vim.fn.setpos(".", { 0, M.cur.lnum, M.cur.col, 0 })
	end
end

M.register = function()
	if BufIsSpecial(vim.api.nvim_buf_get_name(0)) then
		return
	end
	local node = M.create_node()
	if nodes_equal_soft(M.cur, node) then
		M.update()
	else
		M.insert(node)
		M.cur = M.cur.next
	end
end

M.jump_back = function()
	if M.cur.root then
		M.register()
	end
	local node = M.create_node()
	if nodes_equal_soft(M.cur, node) then
		if not nodes_equal_hard(M.cur, node) then
			M.setpos()
			return
		else
			while nodes_equal_soft(M.cur, M.cur.prev) do
				M.delete()
			end
			M.update()
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
	M.cur = M.root
	M.cur.next = M.root
	M.cur.prev = M.root
end

M.jump_forward = function()
	if M.cur.root then
		M.register()
	end
	if not M.cur.next.root then
		local node = M.create_node()
		if nodes_equal_soft(node, M.cur) then
			M.update()
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
