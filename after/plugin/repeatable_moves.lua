vim.api.nvim_create_autocmd("User", {
  pattern = "TreesitterTextobjectsSetupDone",
  callback = function()
    local hint = vim.diagnostic.severity.HINT
    local info = vim.diagnostic.severity.INFO
    local warn = vim.diagnostic.severity.WARN
    local error = vim.diagnostic.severity.ERROR

    local get_severity = function()
      local count = vim.diagnostic.count(0)
      for _, s in ipairs({ error, warn, info, hint }) do
        if count[s] ~= nil and count[s] > 0 then
          return s
        end
      end
      return nil
    end

    local jump_diagnostic = function(opts)
      if opts.forward then
        vim.diagnostic.jump({ count = vim.v.count1, severity = get_severity() })
      else
        vim.diagnostic.jump({ count = -vim.v.count1, severity = get_severity() })
      end
    end

    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
    local repeatable_jump_diagnostic =
      ts_repeat_move.make_repeatable_move(jump_diagnostic)

    vim.keymap.set("n", "]d", function()
      repeatable_jump_diagnostic({ forward = true })
    end)

    vim.keymap.set("n", "[d", function()
      repeatable_jump_diagnostic({ forward = false })
    end)
  end,
})
