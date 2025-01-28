if not vim.g.vscode then
	local jumplist = require("remaps.nvim.jumplist")
	require("neo-tree").setup({
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
					if node.type == "directory" and node:is_expanded() then
						require("neo-tree.sources.filesystem").toggle_directory(state, node)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				["l"] = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" then
						if not node:is_expanded() then
							require("neo-tree.sources.filesystem").toggle_directory(state, node)
						elseif node:has_children() then
							require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
						end
					else
						state.commands["open"](state)
					end
				end,
				["q"] = "close_window",
				["<esc>"] = "close_window",
			},
		},
	})
	vim.keymap.set({ "n" }, "<leader>oE", function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname == "" or not BufIsSpecial(bufname) then
			jumplist.register(false)
			require("neo-tree.command").execute({
				action = "focus",
				position = "current",
				source = "filesystem",
				dir = vim.fn.getcwd(),
				reveal = true,
			})
		end
	end)
end
