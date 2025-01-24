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
		if not BufIsSpecial(vim.api.nvim_buf_get_name(0)) then
			vim.cmd("silent noa w")
		end
		vim.cmd("silent Grapple select name=prev scope=prev")
	end)
	vim.keymap.set("t", "<c-h>", function()
		if not BufIsSpecial(vim.api.nvim_buf_get_name(0)) then
			vim.cmd("silent noa w")
		end
		vim.cmd("silent Grapple select name=prev scope=prev")
	end)
	vim.keymap.set("n", "<leader>j", function()
		vim.cmd("silent noa w")
		vim.cmd("silent Grapple select name=j")
	end)
	vim.keymap.set("n", "<leader>k", function()
		vim.cmd("silent noa w")
		vim.cmd("silent Grapple select name=k")
	end)
	vim.keymap.set("n", "<leader>l", function()
		vim.cmd("silent noa w")
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
			vim.cmd("silent Grapple tag scope=term name=term")
		end,
	})

	vim.api.nvim_create_autocmd("TermClose", {
		callback = function()
			vim.cmd("silent Grapple tag scope=term name=term")
			vim.cmd("silent Grapple untag scope=term name=term")
		end,
	})

	local last_bufname = ""
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			local bufname = vim.api.nvim_buf_get_name(0)
			if last_bufname ~= "" and bufname ~= last_bufname then
				vim.cmd("silent Grapple tag name=prev scope=prev path=" .. last_bufname)
			end
			if not BufIsSpecial(bufname) then
				last_bufname = bufname
			end
		end,
	})
end
