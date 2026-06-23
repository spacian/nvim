local enabled = {
  virtual_lines = {
    current_line = true,
  },
}

local disabled = {
  virtual_lines = false,
}

vim.keymap.set("n", "<leader>D", function()
  if vim.diagnostic.config().virtual_lines then
    vim.diagnostic.config(disabled)
  else
    vim.diagnostic.config(enabled)
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = vim.api.nvim_create_augroup(
        "diagnostic-virtual-lines-disable",
        { clear = true }
      ),
      callback = function()
        if vim.diagnostic.config().virtual_lines then
          vim.diagnostic.config(disabled)
        end
      end,
      once = true,
    })
  end
end, {})

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { border = "rounded" })
end)

vim.keymap.set("n", "<esc>", function()
  vim.diagnostic.config(disabled)
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end)

vim.keymap.set("n", "<s-k>", function()
  vim.lsp.buf.hover({
    border = "rounded",
    close_events = { "CursorMoved", "BufHidden", "LspDetach", "InsertEnter" },
  })
end)

vim.diagnostic.config({
  virtual_text = {
    prefix = "▶",
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

vim.api.nvim_create_user_command("ToggleDiagnostics", function(args)
  local enabled = vim.diagnostic.is_enabled({ bufnr = 0 })
  vim.diagnostic.enable(not enabled, { bufnr = 0 })
end, {})
