return {
	{
		"linux-cultist/venv-selector.nvim",
		enabled = not vim.g.vscode,
		lazy = false,
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python",
		},
		branch = "regexp",
		config = function()
			local venv = require("venv-selector")
			venv.setup({})

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

			local function venv_update()
				if venv.venv() ~= nil then
					venv.deactivate()
				end
				local python_path = vim.fn.getcwd() .. "/.venv/Scripts/python.exe"
				if exists(python_path) then
					venv.activate_from_path(python_path)
				end
			end

			local last_cwd = ""
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

			vim.api.nvim_create_user_command("VenvCurrent", function()
				print(venv.python())
			end, {})
		end,
	},
}
