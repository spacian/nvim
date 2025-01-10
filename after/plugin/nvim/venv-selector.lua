if not vim.g.vscode then
    require('venv-selector').setup({
        name = { ".venv", "venv" },
        search_workspace = true,
        search_venv_managers = false,
        search = true,
        parents = 0,
        notify_user_on_activate = false,
    })
    vim.keymap.set('n', '<leader>Es', function() vim.cmd('VenvSelect') end)
    vim.keymap.set('n', '<leader>Ec', function()
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

    local function update_venv()
        local venv = require('venv-selector')
        if venv ~= nil then
            local venv_path = vim.fn.getcwd():lower() .. '/.venv'
            if venv.venv() == nil or not (venv.venv():lower() == venv_path) then
                if venv.venv() ~= nil then
                    venv.deactivate()
                end
                local python_path = vim.fn.getcwd() .. '/.venv/Scripts/python.exe'
                if exists(python_path) then
                    venv.activate_from_path(python_path)
                end
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
    if vim.loop.os_uname().sysname == "Windows_NT" then
        vim.keymap.set({ 'n' }, '<leader>otp',
            function()
                vim.cmd('vsplit')
                vim.cmd('term')
                vim.fn.feedkeys('a')
                vim.fn.feedkeys(
                    vim.api.nvim_replace_termcodes(
                        '.venv/Scripts/activate<enter>' ..
                        'cls<enter>'
                        , true, true, true)
                )
            end, { noremap = true })
    else
        vim.keymap.set({ 'n' }, '<leader>otp',
            function()
                vim.cmd('vsplit')
                vim.cmd('term')
                vim.fn.feedkeys('a')
                vim.fn.feedkeys(
                    vim.api.nvim_replace_termcodes(
                        '.venv/bin/activate<enter>'
                        , true, true, true)
                )
            end,
            -- ':vsplit term://<enter>a',
            { noremap = true })
    end
end
