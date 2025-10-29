return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			-- "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
			preset = "powerline",
			options = {
				add_messages = {
					display_count = true,
					show_multiple_glyphs = false,
				},
				multilines = {
					enabled = true,
					always_show = true,
				},
				show_all_diags_on_cursorline = true,
				show_related = {
					enabled = true,
					max_count = 100,
				},
				format = function(diag)
					if diag.code ~= nil then
						local code = diag.code
						if type(code) == "string" then
							code = code:gsub("^report", "")
						end
						return diag.message .. " [" .. code .. "]"
					else
						return diag.message
					end
				end,
			},
		})

		vim.diagnostic.config({
			virtual_text = false,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
			},
		})
	end,
}
