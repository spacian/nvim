vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    callback = function()
        local bufname = vim.fn.expand("%")
        if string.sub(bufname, 1, 3) ~= "oil" then
            require('lazygit.utils').project_root_dir()
        end
    end,
})
