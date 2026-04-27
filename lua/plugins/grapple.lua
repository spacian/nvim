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
        },
      })
      grapple.setup({ scope = "git" })

      vim.keymap.set("n", "<leader>ob", function()
        jumplist.register(1)
        require("grapple").open_tags()
      end, {})

      vim.keymap.set("n", "<leader>h", function()
        if grapple.exists(PREV()) then
          if not BufIsSpecial() then
            vim.cmd("silent noa w")
          end
          local path = grapple.find(PREV()).path
          if path == vim.api.nvim_buf_get_name(0) then
            print("already in previous buffer")
            return
          end
          grapple.select(PREV())
        else
          print("no buffer tagged 'prev'")
        end
      end)

      vim.keymap.set("n", "m", function()
        local c = vim.fn.getcharstr()
        if grapple.exists({ name = c }) then
          if not BufIsSpecial() then
            vim.cmd("silent noa w")
          end
          jumplist.register(1)
          grapple.select({ name = c })
        else
          print("no buffer tagged '" .. c .. "'")
        end
      end, {})

      vim.keymap.set("n", "<leader>m", function()
        local tag = vim.fn.getcharstr()
        local path = vim.api.nvim_buf_get_name(0)
        if grapple.exists({ path = path }) then
          local confirm = vim.fn.input("path is already tagged, overwrite? (y/N): ")
          if confirm:lower() ~= "y" then
            vim.notify("tag cancelled")
            return
          end
        end
        if grapple.exists({ name = tag }) then
          local confirm = vim.fn.input("tag already exists, override? (y/N): ")
          if confirm:lower() ~= "y" then
            vim.notify("tag cancelled")
            return
          end
        end
        grapple.tag({ name = tag })
        vim.notify("tagged with '" .. tag .. "'")
      end, {})

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
            local bufname = vim.api.nvim_buf_get_name(0)
            if last_bufname ~= "" and bufname ~= last_bufname then
              grapple.tag(PREV(last_bufname))
            end
            if not BufIsSpecial() then
              last_bufname = bufname
              vim.o.cursorline = true
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
