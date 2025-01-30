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
	vim.keymap.set("n", "<leader>oh", function()
		if grapple.exists({ name = "prev", scope = "prev" }) then
			if not BufIsSpecial() then
				vim.cmd("silent noa w")
			end
			vim.cmd("silent Grapple select name=prev scope=prev")
		else
			print("there is no buffer tagged 'prev'")
		end
	end)
	vim.keymap.set("t", "<c-h>", function()
		if grapple.exists({ name = "prev", scope = "prev" }) then
			if not BufIsSpecial() then
				vim.cmd("silent noa w")
			end
			vim.cmd("silent Grapple select name=prev scope=prev")
		else
			print("there is no buffer tagged 'prev'")
		end
	end)
	local tags = { "j", "k", "l" }
	for i = 1, #tags do
		vim.keymap.set("n", "<leader>o" .. tags[i], function()
			if grapple.exists({ name = tags[i] }) then
				vim.cmd("silent noa w")
				vim.cmd("silent Grapple select name=" .. tags[i])
			else
				print("there is no buffer tagged '" .. tags[i] .. "'")
			end
		end)
	end
	vim.keymap.set("n", "<leader>ot", function()
		if not grapple.exists({ name = "term", scope = "term" }) then
			if vim.loop.os_uname().sysname == "Windows_NT" then
				vim.cmd("term powershell")
				vim.fn.feedkeys("a")
				vim.fn.feedkeys("cls" .. vim.api.nvim_replace_termcodes("<enter>", true, true, true))
			else
				vim.cmd("term")
				vim.fn.feedkeys("a")
			end
		else
			vim.cmd("silent Grapple select name=term scope=term")
			vim.fn.feedkeys("a")
		end
	end)
	vim.keymap.set("n", "<leader>tj", ":Grapple tag name=j<enter>")
	vim.keymap.set("n", "<leader>tk", ":Grapple tag name=k<enter>")
	vim.keymap.set("n", "<leader>tl", ":Grapple tag name=l<enter>")

	vim.api.nvim_create_autocmd("TermOpen", {
		callback = function()
			vim.cmd("silent Grapple tag scope=term name=term")
		end,
	})

	vim.api.nvim_create_autocmd("TermClose", {
		callback = function()
			if grapple.exists({ name = "term", scope = "term" }) then
				vim.cmd("silent Grapple untag scope=term name=term")
			end
		end,
	})

	local last_bufname = ""
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			vim.schedule(function()
				local bufname = vim.api.nvim_buf_get_name(0)
				if BufIsSpecial(bufname) then
					return
				end
				if last_bufname ~= "" and bufname ~= last_bufname then
					grapple.tag({ name = "prev", scope = "prev", path = last_bufname })
				end
				last_bufname = bufname
			end)
		end,
	})
	vim.keymap.set({ "" }, "<c-q>", function()
		if vim.fn.winnr("$") > 1 then
			vim.cmd("silent close")
			return
		end
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname == "" then
			vim.cmd("bd")
			return
		elseif bufname:match("^term://") then
			if grapple.exists({ name = "prev", scope = "prev" }) then
				grapple.select({ name = "prev", scope = "prev" })
			else
				vim.cmd("bd!")
			end
			return
		else
			vim.cmd("w|bd")
			return
		end
	end, { noremap = true })
	vim.keymap.set({ "t" }, "<c-q>", function()
		if vim.fn.winnr("$") > 1 then
			vim.cmd("silent close")
			return
		elseif grapple.exists({ name = "prev", scope = "prev" }) then
			grapple.select({ name = "prev", scope = "prev" })
		else
			local keys = vim.api.nvim_replace_termcodes([[<c-\><c-n>:bd!<enter>]], true, false, true)
			vim.api.nvim_feedkeys(keys, "n", false)
			return
		end
	end, { noremap = true })
end
