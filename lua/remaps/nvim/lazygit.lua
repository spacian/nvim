local lazygit = function(args)
  local nvim_pane = vim.env.WEZTERM_PANE

  local lazygit_cmd = { "lazygit" }
  vim.list_extend(lazygit_cmd, args or {})
  local command = table.concat(lazygit_cmd, " ")

  vim.fn.jobstart({
    "wezterm",
    "cli",
    "spawn",
    "--cwd",
    vim.fn.getcwd(),
    "--",
    "cmd",
    "/d",
    "/c",
    ("%s & wezterm cli activate-pane --pane-id %s"):format(command, nvim_pane),
  })
end

vim.keymap.set({ "n" }, "<leader>gg", function()
  lazygit()
end)

vim.keymap.set({ "n" }, "<leader>gl", function()
  lazygit({ "log" })
end)

vim.keymap.set({ "n" }, "<leader>gf", function()
  lazygit({ "--filter", vim.fn.expand("%:p") })
end)
