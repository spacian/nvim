local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			return true
		end
	end
	return ok, err
end

local function workspace_update()
	if vim.lsp.buf.list_workspace_folders ~= nil then
		local folders = vim.lsp.buf.list_workspace_folders()
		local found = false
		local cwd = vim.fn.getcwd():gsub("\\", "/"):lower()
		for i = 1, #folders do
			if folders[i]:lower() == cwd then
				found = true
			else
				vim.lsp.buf.remove_workspace_folder(folders[i])
			end
		end
		if not found then
			vim.lsp.buf.add_workspace_folder(vim.fn.getcwd():lower())
		end
	end
end

local function deactivate()
	local system_paths = vim.fn.getenv("PATH")
	local paths = {}
	for p in string.gmatch(system_paths, "[^;]+") do
		if p:find(".venv") == nil then
			table.insert(paths, p)
		end
	end
	local new_path = table.concat(paths, ";")
	vim.fn.setenv("PATH", new_path)
	vim.fn.setenv("VIRTUAL_ENV", nil)
end

local function activate(python_path)
	local system_paths = vim.fn.getenv("PATH")
	local head = vim.fn.fnamemodify(python_path, ":h")
	local new_path = head .. ";" .. system_paths
	vim.fn.setenv("PATH", new_path)
	vim.fn.setenv("VIRTUAL_ENV", python_path)
	for _, client in pairs(vim.lsp.get_clients()) do
		if client.name == "basedpyright" then
			client:notify("workspace/didChangeConfigration", {
				settings = {
					python = { pythonPath = python_path },
				},
			})
		end
	end
end

local venv = nil
local function venv_update()
	if venv ~= nil then
		deactivate()
		venv = nil
	end
	local python_path = vim.fn.getcwd() .. "/.venv/Scripts/python.exe"
	if exists(python_path) then
		venv = python_path
		activate(python_path)
	end
end

local last_cwd = nil
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		if BufIsSpecial() then
			return
		end
		local cwd = vim.fn.getcwd():gsub("\\", "/"):lower()
		if last_cwd ~= cwd then
			last_cwd = cwd
			venv_update()
			if vim.bo.buftype == "python" then
				workspace_update()
			end
		end
	end,
})
