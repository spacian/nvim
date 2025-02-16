if not vim.g.vscode then
	local persisted = require("persisted")
	local grapple = require("grapple")
	vim.api.nvim_create_autocmd("User", {
		pattern = "PersistedStart",
		callback = function(_)
			require("remaps.nvim.jumplist").reset()
			vim.cmd("clearjumps")
			vim.cmd("silent Grapple reset scope=prev")
		end,
	})
end
