return {
	{
		"cbochs/grapple.nvim",
		enabled = not vim.g.vscode,
		lazy = false,
		config = function()
			local jumplist = require("remaps.nvim.jumplist")
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
			grapple.setup({ scope = "git" })

			vim.api.nvim_create_user_command("GrappleTags", function()
				require("grapple").open_tags()
			end, {})

			vim.keymap.set("n", "<leader>mh", function()
				if grapple.exists({ name = "prev", scope = "prev" }) then
					if not BufIsSpecial() then
						vim.cmd("silent noa w")
					end
					grapple.select({ name = "prev", scope = "prev" })
				else
					print("there is no buffer tagged 'prev'")
				end
			end)

			local tags = { "j", "k", "l" }
			for i = 1, #tags do
				vim.keymap.set("n", "<leader>m" .. tags[i], function()
					if grapple.exists({ name = tags[i] }) then
						if not BufIsSpecial() then
							vim.cmd("silent noa w")
						end
						jumplist.register(1)
						grapple.select({ name = tags[i] })
					else
						print("there is no buffer tagged '" .. tags[i] .. "'")
					end
				end)
				vim.keymap.set("n", "<leader>t" .. tags[i], function()
					grapple.tag({ name = tags[i] })
				end)
			end

			vim.keymap.set("n", "<leader>oT", function()
				if not grapple.exists({ name = "term" }) then
					local folder = vim.fn.expand("%:h")
					local enter = vim.api.nvim_replace_termcodes("<enter>", true, true, true)
					if vim.loop.os_uname().sysname == "Windows_NT" then
						vim.cmd("term pwsh")
						vim.fn.feedkeys("a")
						vim.fn.feedkeys("cd " .. folder .. enter)
						vim.fn.feedkeys("cls" .. enter)
					else
						vim.cmd("term")
						vim.fn.feedkeys("a")
						vim.fn.feedkeys("cd " .. folder .. enter)
					end
				else
					grapple.select({ name = "term" })
					vim.fn.feedkeys("a")
				end
			end)
			vim.keymap.set("n", "<leader>ot", function()
				if not grapple.exists({ name = "term" }) then
					if vim.loop.os_uname().sysname == "Windows_NT" then
						vim.cmd("term pwsh")
						vim.fn.feedkeys("a")
						vim.fn.feedkeys("cls" .. vim.api.nvim_replace_termcodes("<enter>", true, true, true))
					else
						vim.cmd("term")
						vim.fn.feedkeys("a")
					end
				else
					grapple.select({ name = "term" })
					vim.fn.feedkeys("a")
				end
			end)

			local last_bufname = ""
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				callback = function()
					local bufname = vim.api.nvim_buf_get_name(0)
					if last_bufname ~= "" and bufname ~= last_bufname then
						grapple.tag({ name = "prev", scope = "prev", path = last_bufname })
					end
					if not BufIsSpecial(bufname) then
						last_bufname = bufname
						vim.o.cursorline = true
					end
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

			local is_lazygit_buffer = function()
				return vim.api.nvim_buf_get_name(0):match("lazygit") == "lazygit"
			end

			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "*",
				callback = function()
					if is_lazygit_buffer() then
						return
					end
					vim.opt_local.statuscolumn = ""
					grapple.tag({ name = "term" })
					vim.keymap.set({ "n" }, "<c-u>", "", { buffer = true, silent = true })
					vim.keymap.set({ "n" }, "<c-d>", "", { buffer = true, silent = true })
					vim.keymap.set({ "t", "n" }, "<c-u><c-i>", function()
						vim.cmd("silent bd!")
					end, { buffer = true })
					vim.keymap.set({ "t", "n" }, "<c-u><c-u>", function()
						if vim.fn.winnr("$") > 1 then
							vim.cmd("silent close")
							return
						elseif grapple.exists({ name = "prev", scope = "prev" }) then
							grapple.select({ name = "prev", scope = "prev" })
						end
					end, { buffer = true })
				end,
			})

			vim.api.nvim_create_autocmd("TermClose", {
				callback = function()
					if is_lazygit_buffer() then
						return
					end
					if grapple.exists({ name = "term" }) then
						grapple.untag({ name = "term" })
					end
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistedStart",
				callback = function(_)
					require("remaps.nvim.jumplist").reset()
					vim.cmd("clearjumps")
					vim.cmd("silent Grapple reset scope=prev")
				end,
			})
		end,
	},
}
