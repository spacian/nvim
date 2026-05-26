local timer = vim.uv.new_timer()

if timer ~= nil then
  local function schedule_clear()
    timer:stop()
    timer:start(
      3000,
      0,
      vim.schedule_wrap(function()
        vim.api.nvim_echo({ { "" } }, false, {})
      end)
    )
  end

  vim.api.nvim_create_autocmd(
    { "BufEnter", "InsertEnter", "TextChanged", "CmdlineLeave" },
    {
      callback = schedule_clear,
    }
  )
end
