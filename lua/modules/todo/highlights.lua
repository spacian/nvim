local M = {}

---@class TaskHighlights
M.TaskHighlights = {
  NORMAL = "TaskNormal",
  PRIORITY_NORMAL = "TaskPriorityNormal",
  PRIORITY_IMPORTANT = "TaskPriorityImportant",
  PRIORITY_URGENT = "TaskPriorityUrgent",
  PRIORITY_IMPORTANT_URGENT = "TaskPriorityImportantUrgent",
  STATE_OPEN = "TaskStateOpen",
  STATE_IN_PROGRESS = "TaskStateinProgress",
  STATE_DONE = "TaskStateDone",
}

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("TaskHighlights", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, M.TaskHighlights.NORMAL, { fg = MergeHL("Normal").fg })
    vim.api.nvim_set_hl(
      0,
      M.TaskHighlights.PRIORITY_NORMAL,
      { link = "DiagnosticInfo" }
    )
    vim.api.nvim_set_hl(
      0,
      M.TaskHighlights.PRIORITY_IMPORTANT,
      { fg = MergeHL("Normal").fg }
    )
    vim.api.nvim_set_hl(
      0,
      M.TaskHighlights.PRIORITY_URGENT,
      { link = "DiagnosticWarn" }
    )
    vim.api.nvim_set_hl(
      0,
      M.TaskHighlights.PRIORITY_IMPORTANT_URGENT,
      { link = "DiagnosticError" }
    )
    vim.api.nvim_set_hl(0, M.TaskHighlights.STATE_OPEN, { fg = MergeHL("Normal").fg })
    vim.api.nvim_set_hl(
      0,
      M.TaskHighlights.STATE_IN_PROGRESS,
      { link = "DiagnosticError" }
    )
    vim.api.nvim_set_hl(0, M.TaskHighlights.STATE_DONE, { link = "DiagnosticHint" })
  end,
})

return M
