require("remaps.code.utils")
require("remaps.code.jumps")

vim.keymap.set({ "n" }, "<c-o>", Jump_back, { noremap = true })
vim.keymap.set({ "n" }, "<c-i>", Jump_forw, { noremap = true })

local do_wrap = true

local function wrap_jk()
  vim.keymap.set({ "n" }, "I", function()
    Vsc_notify("cursorMove", {
      args = { to = "wrappedLineStart" },
    })
    Nvim_feedkeys("i")
  end)
  vim.keymap.set({ "n" }, "A", function()
    Vsc_notify("cursorMove", {
      args = { to = "wrappedLineEnd" },
    })
    Nvim_feedkeys("a")
  end)
  vim.keymap.set({ "n" }, "H", function()
    Vsc_notify("cursorMove", {
      args = { to = "wrappedLineStart" },
    })
  end)
  vim.keymap.set({ "n" }, "L", function()
    Vsc_notify("cursorMove", {
      args = { to = "wrappedLineEnd" },
    })
  end)
  vim.keymap.set({ "n" }, "j", function()
    Vsc_notify("cursorMove", {
      args = { to = "down", by = "wrappedLine", value = vim.v.count + 1 },
    })
  end)
  vim.keymap.set({ "n" }, "k", function()
    Vsc_notify("cursorMove", {
      args = { to = "up", by = "wrappedLine", value = vim.v.count },
    })
  end)
end

local function unwrap_jk()
  vim.keymap.set({ "n" }, "j", "j")
  vim.keymap.set({ "n" }, "k", "k")
  vim.keymap.set({ "n" }, "L", "$")
  vim.keymap.set({ "n" }, "H", "^")
  vim.keymap.set({ "n" }, "A", "A")
  vim.keymap.set({ "n" }, "I", "I")
end

vim.keymap.set({ "n" }, "gwrap", function()
  if do_wrap then
    print("wrapped line navigation: enabled ")
    wrap_jk()
  else
    print("wrapped line navigation: disabled")
    unwrap_jk()
  end
  do_wrap = not do_wrap
end)

vim.keymap.set({ "n" }, "gi", function()
  Register_jump()
  Jump_forw(1)
end)

vim.keymap.set({ "n" }, "go", function()
  Register_jump()
  Jump_back(1)
end)

vim.keymap.set({ "n" }, "<c-d>", function()
  Nvim_feedkeys("10j")
  Center()
end)

vim.keymap.set({ "n" }, "<c-u>", function()
  Nvim_feedkeys("10k")
  Center()
end)

vim.keymap.set({ "n" }, "}", function()
  Nvim_feedkeys("}")
  Center()
end)

vim.keymap.set({ "n" }, "{", function()
  Nvim_feedkeys("{")
  Center()
end)

for i = 1, 26 do
  local upper = string.char(i + 64)
  local lower = string.char(i + 96)
  vim.keymap.set({ "n" }, "M" .. upper, function()
    Vsc_notify("vim-marks.create_mark_" .. upper)
  end)
  vim.keymap.set({ "n" }, "M" .. lower, function()
    Vsc_notify("vim-marks.create_mark_" .. lower)
  end)
  vim.keymap.set({ "n" }, "m" .. upper, function()
    Register_jump()
    Vsc_notify("vim-marks.jump_to_mark_" .. upper)
  end)
  vim.keymap.set({ "n" }, "m" .. lower, function()
    Register_jump()
    Vsc_notify("vim-marks.jump_to_mark_" .. lower)
  end)
end

vim.keymap.set({ "n" }, "<leader>ah", function()
  Vsc_notify("vscode-harpoon.addEditor")
end)

vim.keymap.set({ "n" }, "<leader>aj", function()
  Vsc_notify("vscode-harpoon.addEditor1")
end)

vim.keymap.set({ "n" }, "<leader>ak", function()
  Vsc_notify("vscode-harpoon.addEditor2")
end)

vim.keymap.set({ "n" }, "<leader>al", function()
  Vsc_notify("vscode-harpoon.addEditor3")
end)

vim.keymap.set({ "n" }, "<leader>oh", function()
  Register_jump()
  Vsc_notify("vscode-harpoon.editEditors")
end)

vim.keymap.set({ "n" }, "<leader>j", function()
  Register_jump()
  Vsc_notify("vscode-harpoon.gotoEditor1")
  Center()
end)

vim.keymap.set({ "n" }, "<leader>k", function()
  Register_jump()
  Vsc_notify("vscode-harpoon.gotoEditor2")
  Center()
end)

vim.keymap.set({ "n" }, "<leader>l", function()
  Register_jump()
  Vsc_notify("vscode-harpoon.gotoEditor3")
  Center()
end)
