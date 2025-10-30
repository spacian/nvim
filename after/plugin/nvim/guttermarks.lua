vim.keymap.set("n", "M", function()
  local c = vim.fn.getcharstr()
  if c:match("%l") then
    c = c:upper()
  end
  vim.cmd("normal! m" .. c)
  vim.schedule(function()
    require("guttermarks").refresh()
  end)
end, {})

vim.keymap.set("n", "m", function()
  local c = vim.fn.getcharstr()
  if c:match("%l") then
    c = c:upper()
  end
  local ok, pos = pcall(vim.api.nvim_get_mark, c, {})
  if ok and pos[1] ~= 0 then
    vim.cmd("normal! `" .. c .. "zz")
  else
    vim.notify("E20: Mark " .. c .. " not set", vim.log.levels.ERROR)
  end
end, {})

vim.keymap.set({ "n" }, "<Leader>md", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local cur_line = vim.fn.line(".")
  local all_marks_local = vim.fn.getmarklist(bufnr)
  for _, mark in ipairs(all_marks_local) do
    if mark.pos[2] == cur_line and string.match(mark.mark, "'[a-z]") then
      vim.notify("Deleting mark: " .. string.sub(mark.mark, 2, 2))
      vim.api.nvim_buf_del_mark(bufnr, string.sub(mark.mark, 2, 2))
    end
  end
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local all_marks_global = vim.fn.getmarklist()
  for _, mark in ipairs(all_marks_global) do
    local expanded_file_name = vim.fn.fnamemodify(mark.file, ":p")
    if
      bufname == expanded_file_name
      and mark.pos[2] == cur_line
      and string.match(mark.mark, "'[A-Z]")
    then
      vim.notify("Deleting mark: " .. string.sub(mark.mark, 2, 2))
      vim.api.nvim_del_mark(string.sub(mark.mark, 2, 2))
    end
  end
  vim.schedule(function()
    require("guttermarks").refresh()
  end)
end, {})
