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
			vim.diagnostic.goto_next({ severity = { min = hint, max = error } })
		end, {})
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev({ severity = { min = hint, max = error } })
		end, {})
	end
	local severity = letter_to_level[letter]
	if severity == nil then
		print(letter .. " is not a valid option")
		return
	end
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next({ severity = { min = severity, max = severity } })
	end, {})
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev({ severity = { min = severity, max = severity } })
	end, {})
end

vim.keymap.set("n", "<leader>dj", filter_diagnostic)
vim.keymap.set("n", "<leader>dk", vim.diagnostic.open_float)
