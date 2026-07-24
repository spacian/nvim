return {
  {
    "cbochs/grapple.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
      local jumplist = require("keymaps.nvim.jumplist")
      local grapple = require("grapple")
      local enter = vim.api.nvim_replace_termcodes("<enter>", true, true, true)

      local PREV1 = function(path)
        return { name = "prev1", scope = "prev", path = path }
      end

      local PREV2 = function(path)
        return { name = "prev2", scope = "prev", path = path }
      end

      grapple.setup({
        scope = "prev",
        scopes = {
          {
            name = "prev",
            resolver = function()
              return "prev", nil
            end,
          },
        },
      })
      grapple.setup({ scope = "cwd" })

      vim.keymap.set("n", "<leader>h", function()
        if grapple.exists(PREV1()) then
          if not BufIsSpecial() then
            vim.cmd("silent noa w")
          end
          local path = grapple.find(PREV1()).path
          local bufname = vim.api.nvim_buf_get_name(0)
          if path == bufname and grapple.exists(PREV2()) then
            grapple.select(PREV2())
          else
            grapple.select(PREV1())
          end
        end
      end)

      vim.keymap.set("n", "<leader>ob", function()
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
        grapple.cycle_tags("next")
      end)

      vim.keymap.set("n", "<c-h>", function()
        grapple.cycle_tags("prev")
      end)

      vim.keymap.set("n", "<c-j>", function()
        local index = 1
        if grapple.exists({ index = index }) then
          grapple.select({ index = index })
        end
      end)

      vim.keymap.set("n", "<c-k>", function()
        local index = 2
        if grapple.exists({ index = index }) then
          grapple.select({ index = index })
        end
      end)

      local last_bufname = ""
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
          vim.defer_fn(function()
            local is_float = vim.api.nvim_win_get_config(0).relative ~= ""
            if is_float then
              return
            end
            local bufname = vim.api.nvim_buf_get_name(0)
            if last_bufname ~= "" and bufname ~= last_bufname then
              if grapple.exists(PREV1()) then
                local prev_path = grapple.find(PREV1()).path
                if last_bufname ~= prev_path then
                  grapple.tag(PREV2(prev_path))
                end
              end
              grapple.tag(PREV1(last_bufname))
            end
            if not BufIsSpecial() then
              last_bufname = bufname
              vim.o.cursorline = true
            else
              last_bufname = ""
            end
          end, 100)
        end,
      })

      local is_lazygit_buffer = function()
        return vim.api.nvim_buf_get_name(0):match("lazygit") == "lazygit"
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
          if is_lazygit_buffer() then
            return
          end
          vim.opt_local.statuscolumn = ""
          vim.keymap.set({ "n", "v" }, "<c-u>", "", { buffer = true, silent = true })
          vim.keymap.set({ "n", "v" }, "<c-d>", "", { buffer = true, silent = true })
          vim.keymap.set({ "t", "n", "v" }, "<c-u><c-y>", function()
            vim.fn.feedkeys('cd "' .. vim.fn.getcwd() .. '"' .. enter)
          end, { buffer = true })
          vim.keymap.set({ "t", "n", "v" }, "<c-u><c-o>", function()
            if not grapple.exists(PREV1()) then
              return
            end
            local folder = grapple.find(PREV1()).path:match("(.*)\\.*")
            if folder ~= nil then
              vim.fn.feedkeys('cd "' .. folder .. '"' .. enter)
            end
          end, { buffer = true })
          vim.keymap.set({ "t", "n", "v" }, "<c-u><c-i>", function()
            vim.cmd("silent bd!")
          end, { buffer = true })
          vim.keymap.set({ "t", "n", "v" }, "<c-u><c-u>", function()
            if vim.fn.winnr("$") > 1 then
              vim.cmd("silent close")
              return
            elseif grapple.exists(PREV1()) then
              grapple.select(PREV1())
            end
          end, { buffer = true })
        end,
      })

      vim.api.nvim_create_autocmd("SessionLoadPost", {
        callback = function(_)
          vim.defer_fn(function()
            jumplist.reset()
            jumplist.register()
            vim.cmd("clearjumps")
            vim.cmd("silent Grapple reset scope=prev")
          end, 250)
        end,
      })
    end,
  },
}
