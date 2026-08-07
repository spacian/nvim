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
---@field id integer
---@field title string
---@field state TaskStateValue
---@field important boolean
---@field urgent boolean
---@field children Task[]

return {
  TaskState = TaskState,
}
