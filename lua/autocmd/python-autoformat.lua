vim.api.nvim_create_autocmd(
    {
        'BufWritePost',
    },
    {
        pattern = '*.py',
        callback = function()
            vim.cmd('silent !isort %:p')
            vim.cmd('silent !black %:p')
        end,
    }
)
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
    if venv == nil then return end
    local venv_path = vim.fn.getcwd():gsub('\\', '/') .. '/.venv'
    print('venv.venv()', venv.venv())
    print('venv path', venv_path)
    if venv.venv() ~= nil and not venv.venv():gsub('\\', '/') == venv_path then
        print('deactivating')
        venv.deactivate()
    end
    if venv.venv() == nil and exists(venv_path) then
        print('activating', venv_path)
        venv.activate_from_path(venv_path)
    end
end

vim.api.nvim_create_autocmd(
    { 'BufEnter', 'SessionLoadPost', 'VimEnter' },
    {
        pattern = '*.py',
        callback = function()
            update_workspace()
            update_venv()
        end
    }
)
