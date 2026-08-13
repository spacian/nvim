return {
  {
    "cbochs/grapple.nvim",
    lazy = false,
    config = function()
      local grapple = require("grapple")

      grapple.setup({ scope = "cwd" })

      vim.keymap.set("n", "<leader>ob", function()
        Jumplist.register()
        grapple.toggle_tags()
      end, {})

      vim.keymap.set("n", "<leader>m", function()
        local m = { path = vim.api.nvim_buf_get_name(0) }
        if grapple.find(m) then
          grapple.untag(m)
          vim.notify("removed")
        else
          grapple.tag(m)
          vim.notify("tagged")
        end
      end, {})

      vim.keymap.set("n", "<c-j>", function()
        Jumplist.register()
        grapple.cycle_tags("next")
      end)

      vim.keymap.set("n", "<c-k>", function()
        Jumplist.register()
        grapple.cycle_tags("prev")
      end)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "Grapple",
        callback = function()
          vim.schedule(function()
            local win = vim.api.nvim_get_current_win()
            local config = vim.api.nvim_win_get_config(win)
            if config.relative == "" then
              return
            end

            local buf = vim.api.nvim_win_get_buf(win)
            local max_width = 78
            for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
              max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
            end

            config.width = math.min(max_width + 2, vim.o.columns - 8)
            config.col = math.floor((vim.o.columns - config.width) / 2)
            config.border = "rounded"

            vim.api.nvim_win_set_config(win, config)
          end)
        end,
      })
    end,
  },
}
