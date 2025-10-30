local function highlight_exists(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  return hl and next(hl) ~= nil
end

if not highlight_exists("DiagnosticErrorLn") then
  vim.api.nvim_set_hl(
    0,
    "DiagnosticErrorLn",
    { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false }).bg }
  )
end

if not highlight_exists("DiagnosticWarnLn") then
  vim.api.nvim_set_hl(
    0,
    "DiagnosticWarnLn",
    { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false }).bg }
  )
end

vim.api.nvim_set_hl(0, "MatchParen", {
  fg = vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false }).fg,
})

for _, name in ipairs({ "Error", "Warn", "Info", "Hint" }) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. name, {
    fg = vim.api.nvim_get_hl(0, { name = "Diagnostic" .. name, link = false }).fg
      or vim.api.nvim_get_hl(0, { name = "Diagnostic" .. name, link = false }).sp,
  })
  vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. name, {
    cterm = { underline = true },
    sp = vim.api.nvim_get_hl(0, { name = "Diagnostic" .. name, link = false }).sp
      or vim.api.nvim_get_hl(0, { name = "Diagnostic" .. name, link = false }).fg,
    underline = true,
  })
end

vim.api.nvim_set_hl(0, "DiffChange", {
  bg = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false }).bg,
})

vim.api.nvim_set_hl(0, "DiffText", {
  fg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg,
  bg = vim.api.nvim_get_hl(0, { name = "DiagnosticHint", link = false }).fg,
})

local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
for _, name in ipairs({
  "SignColumn",
  "CursorLineNr",
  "LineNr",
  "GitSignsAdd",
  "GitSignsChange",
  "GitSignsDelete",
  "GitSignsStagedAdd",
  "GitSignsStagedChange",
  "GitSignsStagedDelete",
}) do
  vim.api.nvim_set_hl(0, name, {
    bg = normal_bg,
    fg = vim.api.nvim_get_hl(0, { name = name, link = false }).fg,
    default = false,
  })
end
