return {
  {
    "cbochs/grapple.nvim",
    lazy = false,
    config = function()
      local jumplist = require("keymaps.nvim.jumplist")
      local grapple = require("grapple")

      grapple.setup({ scope = "cwd" })

      vim.keymap.set("n", "<leader>ob", function()
        jumplist.register()
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

      vim.keymap.set("n", "<c-l>", function()
        jumplist.register()
        grapple.cycle_tags("next")
      end)

      vim.keymap.set("n", "<c-h>", function()
        jumplist.register()
        grapple.cycle_tags("prev")
      end)

      vim.keymap.set("n", "<c-j>", function()
        jumplist.register()
        local index = 1
        if grapple.exists({ index = index }) then
          grapple.select({ index = index })
        end
      end)

      vim.keymap.set("n", "<c-k>", function()
        jumplist.register()
        local index = 2
        if grapple.exists({ index = index }) then
          grapple.select({ index = index })
        end
      end)

      vim.api.nvim_create_autocmd("SessionLoadPost", {
        callback = function(_)
          vim.defer_fn(function()
            jumplist.reset()
            jumplist.register()
            vim.cmd("clearjumps")
          end, 250)
        end,
      })
    end,
  },
}
