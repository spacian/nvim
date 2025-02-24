local function highlight_exists(name)
	local hl = vim.api.nvim_get_hl(0, { name = name })
	return hl and next(hl) ~= nil
end

if not highlight_exists("DiagnosticErrorLn") then
	vim.api.nvim_set_hl(
		0,
		"DiagnosticErrorLn",
		{ bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError", link = false }).bg }
	)
end

if not highlight_exists("DiagnosticWarnLn") then
	vim.api.nvim_set_hl(
		0,
		"DiagnosticWarnLn",
		{ bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextWarn", link = false }).bg }
	)
end

vim.api.nvim_set_hl(0, "MatchParen", {
	fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError" }).fg,
})

for _, name in ipairs({ "Error", "Warn", "Info", "Hint" }) do
	vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. name, {
		fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualText" .. name }).fg,
	})
	vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. name, {
		cterm = { underline = true },
		sp = vim.api.nvim_get_hl(0, { name = "DiagnosticUnderline" .. name }).sp,
		underline = true,
	})
end
