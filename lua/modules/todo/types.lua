---@class TaskState
local TaskState = {
  OPEN = "open",
  IN_PROGRESS = "in_progress",
  DONE = "done",
}

---@alias TaskStateValue
---| "open"
---| "in_progress"
---| "done"

---@class Task
---@field children Task[]
---@field collapsed boolean?
---@field id number
---@field important boolean
---@field notes string?
---@field sort_offset number?
---@field state TaskStateValue
---@field title string
---@field urgent boolean

return {
  TaskState = TaskState,
}
