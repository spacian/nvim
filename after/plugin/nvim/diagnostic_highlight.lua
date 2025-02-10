if not vim.g.vscode then
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
				[vim.diagnostic.severity.WARN] = "DiagnosticWarnLn",
			},
		},
	})
end
