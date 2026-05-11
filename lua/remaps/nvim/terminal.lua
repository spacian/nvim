if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.keymap.set(
    { "t" },
    "<c-e><c-s>",
    [[python -c "import sys; print(sys.executable)"<enter>]]
  )
  vim.keymap.set({ "t" }, "<c-e><c-a>", [[.\.venv\Scripts\activate<enter>]])
  vim.keymap.set({ "t" }, "<c-e><c-d>", [[deactivate<enter>]])
else
  vim.keymap.set(
    { "t" },
    "<c-e><c-s>",
    [[python3 -c "import sys; print(sys.executable)"<enter>]]
  )
  vim.keymap.set({ "t" }, "<c-e><c-a>", [[./.venv/bin/activate<enter>]])
  vim.keymap.set({ "t" }, "<c-e><c-d>", [[deactivate<enter>]])
end
