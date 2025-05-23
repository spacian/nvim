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
local enabled = { virtual_lines = { current_line = true } }
local disabled = { virtual_lines = false }
vim.keymap.set("n", "<leader>D", filter_diagnostic)
vim.keymap.set("n", "<leader>d", function()
	if vim.diagnostic.config().virtual_lines then
		vim.diagnostic.config(disabled)
	else
		vim.diagnostic.config(enabled)
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = vim.api.nvim_create_augroup("diagnostic-virtual-lines-disable", { clear = true }),
			callback = function()
				if vim.diagnostic.config().virtual_lines then
					vim.diagnostic.config(disabled)
				end
			end,
			once = true,
		})
	end
end, {})
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float)
vim.keymap.set("n", "<esc>", function()
	vim.diagnostic.config(disabled)
end)

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
	update_in_insert = false,
})
