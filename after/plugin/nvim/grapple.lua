if not vim.g.vscode then
	local grapple = require("grapple")
	grapple.setup({ icons = true })
	vim.api.nvim_create_user_command("GrappleTags", function()
		require("grapple").open_tags()
	end, {})
	vim.keymap.set("n", "<leader>j", ":Grapple select index=1<enter>")
	vim.keymap.set("n", "<leader>k", ":Grapple select index=2<enter>")
	vim.keymap.set("n", "<leader>l", ":Grapple select index=3<enter>")
	vim.keymap.set("n", "<leader>J", ":Grapple tag index=1<enter>")
	vim.keymap.set("n", "<leader>K", ":Grapple tag index=2<enter>")
	vim.keymap.set("n", "<leader>L", ":Grapple tag index=3<enter>")
end
