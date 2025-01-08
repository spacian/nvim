if not vim.g.vscode then
    require('venv-selector').setup({
        name = {".venv", "venv"},
        search_workspace = true,
        search_venv_managers = false,
        search = true,
        parents = 0,
        notify_user_on_activate = false,
    })
    vim.keymap.set('n', '<leader>vs', function() vim.cmd('VenvSelect') end)
    vim.keymap.set('n', '<leader>vc', function()
        print(require('venv-selector').venv())
    end)


    local function exists(file)
        local ok, err, code = os.rename(file, file)
        if not ok then
            if code == 13 then
                return true
            end
        end
        return ok, err
    end

    local function update_workspace()
        if vim.lsp.buf.list_workspace_folders ~= nil then
            folders = vim.lsp.buf.list_workspace_folders()
            found = false
            cwd = vim.fn.getcwd():gsub("\\", "/"):lower()
            for i = 1, #folders do
                if folders[i]:lower() == cwd then
                    found = true
                else
                    print(folders[i], cwd)
                    vim.lsp.buf.remove_workspace_folder(folders[i])
                end
            end
            if not found then
                vim.lsp.buf.add_workspace_folder(vim.fn.getcwd():lower())
            end
        end
    end

    local function update_venv()
        local venv = require('venv-selector')
        if venv ~= nil then
            venv_path = vim.fn.getcwd() .. '/.venv'
            if venv.venv() ~= nil and not venv.venv() == venv_path then
                venv.deactivate()
            end
            python_path = vim.fn.getcwd() .. '/.venv/Scripts/python'
            if venv.venv() == nil and exists(python_path) then
                venv.activate_from_path(python_path)
            end
        end
    end

    vim.api.nvim_create_autocmd(
        { 'BufEnter' },
        {
            pattern = '*.py',
            callback = function()
                update_workspace()
                update_venv()
            end
      }
    )
end
