local hint = vim.diagnostic.severity.HINT
local info = vim.diagnostic.severity.INFO
local warn = vim.diagnostic.severity.WARN
local error = vim.diagnostic.severity.ERROR

local letter_to_level = {
	E = error,
	W = warn,
	I = info,
	N = hint,
	e = error,
	w = warn,
	i = info,
	n = hint,
}

local filter_diagnostic = function()
	local letter = vim.fn.input("filter diagnostic jumps by type ([E]rror,[W]arning, [I]nfo, [N]ote) or [R]eset: ")
	if letter == "R" or letter == "r" then
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ severity = { min = hint, max = error }, count = 1, float = false })
		end, {})
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ severity = { min = hint, max = error }, count = 1, float = false })
		end, {})
		return
	end
	local severity = letter_to_level[letter]
	if severity == nil then
		print(letter .. " is not a valid option")
		return
	end
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ severity = { min = severity, max = severity }, count = 1, float = false })
	end, {})
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ severity = { min = severity, max = severity }, count = 1, float = false })
	end, {})
end

vim.keymap.set("n", "<leader>D", filter_diagnostic)
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end, {})

vim.diagnostic.config({
	virtual_text = {
		severity_sort = true,
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticErrorLn",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})
