local M = {}

local hl_ns = vim.api.nvim_create_namespace("todo_hl")
local types = require("modules.todo.types")
local hl = require("modules.todo.highlights")

local state_symbols = {
  open = "○",
  in_progress = "◐",
  done = "●",
}

---@param ancestors boolean[]
---@return string
local function tree_prefix(ancestors)
  if #ancestors == 0 then
    return " "
  end
  local pfx = { " " }
  for i = 1, #ancestors - 1 do
    table.insert(pfx, ancestors[i] and "│  " or "   ")
  end
  table.insert(pfx, ancestors[#ancestors] and "├─ " or "└─ ")
  return table.concat(pfx)
end

---@param tree_highlights table<number,string>
---@param extmarks table
---@param line_nr number
---@param line string
local function tree_highlight(tree_highlights, extmarks, line_nr, line)
  for i, thl in ipairs(tree_highlights) do
    local start_col = 1 + (i - 1) * 3
    table.insert(extmarks, {
      line = line_nr,
      group = thl,
      start_col = vim.str_byteindex(line, "utf-16", start_col),
      end_col = vim.str_byteindex(line, "utf-16", start_col + 3),
      ns = hl_ns,
    })
  end
end

---@param tasks Task[]
---@param buf number
---@return number[]
---@return table<number, number>
function M.render(buf, tasks)
  vim.api.nvim_buf_clear_namespace(buf, hl_ns, 0, -1)

  local lines = {}
  local extmarks = {}
  local tree_highlights = {}
  local refs = {}

  ---@param task Task
  ---@param forced_hl? string
  ---@param ancestors? boolean[]
  local function add_task(task, forced_hl, ancestors)
    ancestors = ancestors or {}
    local line = #lines
    local indent = tree_prefix(ancestors)
    local symbol = state_symbols[task.state] or "?"
    local indicator_children = #task.children > 0 and " /" or ""
    local indicator_note = task.notes and #task.notes > 0 and " *" or ""

    local text = indent
      .. symbol
      .. " "
      .. task.title
      .. indicator_note
      .. indicator_children
    table.insert(lines, text)

    tree_highlight(tree_highlights, extmarks, line, text)

    if task.state == types.TaskState.DONE then
      forced_hl = hl.TaskHighlights.STATE_DONE
    end

    table.insert(extmarks, {
      line = line,
      group = forced_hl or hl.get_priority_hl(task),
      start_col = #indent,
      end_col = #indent + #symbol,
      ns = hl_ns,
    })

    table.insert(extmarks, {
      line = line,
      group = forced_hl or hl.get_priority_hl(task),
      start_col = #indent + #symbol + 1,
      end_col = #text,
      ns = hl_ns,
    })

    refs[#refs + 1] = task.id

    if not task.collapsed then
      table.insert(tree_highlights, forced_hl or hl.get_priority_hl(task))
      for i, child in ipairs(task.children) do
        table.insert(ancestors, i < #task.children)
        add_task(child, forced_hl, ancestors)
        ancestors[#ancestors] = nil
      end
      tree_highlights[#tree_highlights] = nil
    end
  end

  for _, task in ipairs(tasks) do
    add_task(task)
  end

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  for _, em in ipairs(extmarks) do
    vim.api.nvim_buf_set_extmark(buf, em.ns, em.line, em.start_col, {
      end_col = em.end_col,
      hl_group = em.group,
    })
  end

  local task_to_line = {}
  for i, ref in ipairs(refs) do
    task_to_line[ref] = i
  end
  return refs, task_to_line
end

return M
