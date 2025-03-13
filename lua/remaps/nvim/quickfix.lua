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
	vim.cmd("silent cexpr []")
	vim.diagnostic.setqflist({ open = false })
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
		vim.cmd("copen")
	else
		vim.cmd("cclose")
	end
end

vim.keymap.set("n", "<leader>qq", function()
	fill_qflist()
	open_qf()
end)

vim.keymap.set("n", "<leader>qe", function()
	fill_qflist()
	vim.fn.setqflist(filter_type("E"))
	open_qf()
end)

vim.keymap.set("n", "<leader>qw", function()
	fill_qflist()
	vim.fn.setqflist(filter_type("W"))
	open_qf()
end)

vim.keymap.set("n", "<leader>qi", function()
	fill_qflist()
	vim.fn.setqflist(filter_type("I"))
	open_qf()
end)

vim.keymap.set("n", "<leader>qn", function()
	fill_qflist()
	vim.fn.setqflist(filter_type("N"))
	open_qf()
end)

vim.keymap.set("n", "<leader>qft", function()
	vim.fn.setqflist(filter_type(vim.fn.input("filter qflist by type (E/W/I/N): ", "E")))
end)

vim.keymap.set("n", "<leader>qff", function()
	vim.fn.setqflist(filter_file(vim.fn.input("filter qflist by file: ")))
end)

vim.keymap.set("n", "<leader>qfd", function()
	local qf = vim.fn.getqflist()
	local filtered = {}
	local filter_by = vim.fn.input("filter qflist by description: ")
	for _, item in ipairs(qf) do
		if item.text:match(filter_by) then
			table.insert(filtered, item)
		end
	end
	vim.fn.setqflist(filtered)
end)
