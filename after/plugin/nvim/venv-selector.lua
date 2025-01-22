if not vim.g.vscode then
	require("venv-selector").setup({
		name = { ".venv", "venv" },
		search_workspace = true,
		search_venv_managers = false,
		search = true,
		parents = 0,
		notify_user_on_activate = false,
	})
	vim.api.nvim_create_user_command("VenvShowCurrent", function()
		print(require("venv-selector").venv())
	end, {})

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
			local cwd = vim.fn.getcwd(-1, -1):gsub("\\", "/"):lower()
			for i = 1, #folders do
				if folders[i]:lower() == cwd then
					found = true
				else
					vim.lsp.buf.remove_workspace_folder(folders[i])
				end
			end
			if not found then
				vim.lsp.buf.add_workspace_folder(vim.fn.getcwd(-1, -1):lower())
			end
		end
	end

	local function venv_update()
		local venv = require("venv-selector")
		if venv == nil then
			return
		end
		if venv.venv() ~= nil then
			venv.deactivate()
		end
		local python_path = vim.fn.getcwd(-1, -1) .. "/.venv/Scripts/python.exe"
		if exists(python_path) then
			venv.activate_from_path(python_path)
		end
	end

	local last_cwd = ""
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			if last_cwd ~= vim.fn.getcwd(-1, -1) then
				last_cwd = vim.fn.getcwd(-1, -1)
				venv_update()
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			if vim.bo.buftype == "python" then
				workspace_update()
			end
		end,
	})
end
