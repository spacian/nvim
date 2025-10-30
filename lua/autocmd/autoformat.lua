vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*.py",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd("silent !isort %:p")
    vim.cmd("silent !black %:p")
    vim.fn.setpos(".", save_cursor)
  end,
})

local function trim_whitespace()
  vim.cmd([[%s/\s\+$//e]])
end

local function delete_empty_lines()
  local last_line = vim.fn.getline("$")
  while last_line == "" and vim.fn.line("$") > 1 do
    vim.cmd("silent $d")
    last_line = vim.fn.getline("$")
  end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo.buftype == "python" or BufIsSpecial() then
      return
    end
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
      if client:supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ async = false })
        break
      end
    end
    if not vim.bo.readonly and vim.bo.modifiable and vim.bo.modified then
      local save_cursor = vim.fn.getpos(".")
      trim_whitespace()
      delete_empty_lines()
      vim.fn.setpos(".", save_cursor)
    end
  end,
})
