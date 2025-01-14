if not vim.g.vscode then
    require('neo-tree').setup({
        position = "right",
        filesystem = {
            filtered_items = {
                visible = true,
            },
        },
        window = {
            mappings = {
                ["h"] = function(state)
                    local node = state.tree:get_node()
                    if node.type == 'directory' and node:is_expanded() then
                        require('neo-tree.sources.filesystem').toggle_directory(state, node)
                    else
                        require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
                    end
                end,
                ["l"] = function(state)
                    local node = state.tree:get_node()
                    if node.type == 'directory' then
                        if not node:is_expanded() then
                            require('neo-tree.sources.filesystem').toggle_directory(state, node)
                        elseif node:has_children() then
                            require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
                        end
                    else
                        state.commands['open'](state)
                    end
                end,
                -- ["<esc>"] = "close_window",
                ["<esc>"] = function() vim.cmd('bd') end,
                ["q"] = function() vim.cmd('bd') end,
            },
        },
    })
    vim.keymap.set({ 'n' }, '<leader>oE', function()
        require("neo-tree.command").execute({
            action = "focus",
            position = "right",
            dir = vim.fn.getcwd(),
        })
    end)
    vim.keymap.set({ 'n' }, '<leader>oD', function()
        require("neo-tree.command").execute({
            action = "focus",
            position = "right",
            source = "filesystem",
            dir = vim.fn.getcwd(),
        })
    end)
end
