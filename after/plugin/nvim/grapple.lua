if not vim.g.vscode then
	local grapple = require("grapple")
	grapple.setup({
		scope = "prev",
		scopes = {
			{
				name = "prev",
				resolver = function()
					return "prev", nil
				end,
			},
		},
	})
	grapple.setup({
		scope = "term",
		scopes = {
			{
				name = "term",
				resolver = function()
					return "term", nil
				end,
			},
		},
	})
	grapple.setup({ icons = true, scope = "cwd" })
	vim.api.nvim_create_user_command("GrappleTags", function()
		require("grapple").open_tags()
	end, {})
	vim.keymap.set("n", "<leader>h", function()
		vim.cmd("silent Grapple select name=prev scope=prev")
	end)
	vim.keymap.set("n", "<leader>j", function()
		vim.cmd("silent Grapple select name=j")
	end)
	vim.keymap.set("n", "<leader>k", function()
		vim.cmd("silent Grapple select name=k")
	end)
	vim.keymap.set("n", "<leader>l", function()
		vim.cmd("silent Grapple select name=l")
	end)
	vim.keymap.set("n", "<leader>t", function()
		vim.cmd("silent Grapple select name=term scope=term")
	end)
	vim.keymap.set("n", "<leader>J", ":Grapple tag name=j<enter>")
	vim.keymap.set("n", "<leader>K", ":Grapple tag name=k<enter>")
	vim.keymap.set("n", "<leader>L", ":Grapple tag name=l<enter>")

	vim.api.nvim_create_autocmd("TermOpen", {
		callback = function()
			vim.cmd("Grapple tag scope=term name=term")
		end,
	})

	vim.api.nvim_create_autocmd("TermLeave", {
		callback = function()
			vim.cmd("silent Grapple untag scope=term name=term")
		end,
	})

	local last_bufname = ""
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			local bufname = vim.api.nvim_buf_get_name(0)
			if
				string.find(bufname, "^oil://") == nil
				and string.find(bufname, "^replacer://") == nil
				and string.find(bufname, "^term://") == nil
			then
				if last_bufname ~= "" then
					vim.cmd("silent Grapple tag name=prev scope=prev path=" .. last_bufname)
				end
				last_bufname = bufname
			end
		end,
	})
end
