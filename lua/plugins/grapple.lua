return {
  {
    "cbochs/grapple.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
      local jumplist = require("remaps.nvim.jumplist")
      local grapple = require("grapple")
      local enter = vim.api.nvim_replace_termcodes("<enter>", true, true, true)

      local PREV = function(path)
        return { name = "prev", scope = "prev", path = path }
      end

      local PREV2 = function(path)
        return { name = "prev2", scope = "prev", path = path }
      end

      local TERM = function()
        return { name = "term" }
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
          {
            name = "prev2",
            resolver = function()
              return "prev2", nil
            end,
          },
        },
      })
      grapple.setup({ scope = "git" })

      vim.keymap.set("n", "<leader>h", function()
        if grapple.exists(PREV()) then
          if not BufIsSpecial() then
            vim.cmd("silent noa w")
          end
          local path = grapple.find(PREV()).path
          if path == vim.api.nvim_buf_get_name(0) and grapple.exists(PREV2()) then
            grapple.select(PREV2())
            return
          else
            grapple.select(PREV())
          end
        end
      end)

      local open_term = function()
        if not grapple.exists(TERM()) then
          if vim.loop.os_uname().sysname == "Windows_NT" then
            vim.cmd("term pwsh")
            vim.fn.feedkeys("a")
            vim.fn.feedkeys("cls" .. enter)
          else
            vim.cmd("term")
            vim.fn.feedkeys("a")
          end
        else
          grapple.select(TERM())
          vim.fn.feedkeys("a")
        end
      end

      vim.keymap.set("n", "<leader>ot", open_term)
      vim.keymap.set("n", "<leader>oT", function()
        local folder = vim.fn.expand("%:p:h")
        if vim.loop.os_uname().sysname == "Windows_NT" then
          open_term()
          vim.fn.feedkeys("cd " .. folder .. enter)
        else
          open_term()
          vim.fn.feedkeys("cd " .. folder .. enter)
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
              if grapple.exists(PREV()) then
                local prev_path = grapple.find(PREV()).path
                if last_bufname ~= prev_path then
                  grapple.tag(PREV2(prev_path))
                end
              end
              grapple.tag(PREV(last_bufname))
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
          grapple.tag(TERM())
          vim.keymap.set({ "n", "v" }, "<c-u>", "", { buffer = true, silent = true })
          vim.keymap.set({ "n", "v" }, "<c-d>", "", { buffer = true, silent = true })
          vim.keymap.set({ "t", "n", "v" }, "<c-u><c-y>", function()
            vim.fn.feedkeys("cd " .. vim.fn.getcwd() .. enter)
          end, { buffer = true })
          vim.keymap.set({ "t", "n", "v" }, "<c-u><c-o>", function()
            if not grapple.exists(PREV()) then
              return
            end
            local folder = last_bufname:match("(.*)\\.*")
            if folder ~= nil then
              vim.fn.feedkeys("cd " .. folder .. enter)
            end
          end, { buffer = true })
          vim.keymap.set({ "t", "n", "v" }, "<c-u><c-i>", function()
            vim.cmd("silent bd!")
          end, { buffer = true })
          vim.keymap.set({ "t", "n", "v" }, "<c-u><c-u>", function()
            if vim.fn.winnr("$") > 1 then
              vim.cmd("silent close")
              return
            elseif grapple.exists(PREV()) then
              grapple.select(PREV())
            end
          end, { buffer = true })
        end,
      })

      vim.api.nvim_create_autocmd("TermClose", {
        callback = function()
          if is_lazygit_buffer() then
            return
          end
          if grapple.exists(TERM()) then
            grapple.untag(TERM())
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedStart",
        callback = function(_)
          vim.defer_fn(function()
            jumplist.reset()
            vim.cmd("clearjumps")
            vim.cmd("silent Grapple reset scope=prev")
          end, 250)
        end,
      })
    end,
  },
}
