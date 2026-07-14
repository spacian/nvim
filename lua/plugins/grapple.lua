return {
  {
    "cbochs/grapple.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
      local jumplist = require("remaps.nvim.jumplist")
      local grapple = require("grapple")
      local enter = vim.api.nvim_replace_termcodes("<enter>", true, true, true)

      local PREV1 = function(path)
        return { name = "prev1", scope = "prev", path = path }
      end

      local PREV2 = function(path)
        return { name = "prev2", scope = "prev", path = path }
      end

      local TERM1 = function()
        return { name = "term1" }
      end

      local TERM2 = function()
        return { name = "term2" }
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

      vim.keymap.set("n", "<leader>ob", function()
        jumplist.register()
        local get_items = function(scope, refresh)
          return vim
            .iter(grapple.tags({ scope = scope }))
            :map(function(tag)
              if #tag.name > 1 then
                return nil
              end
              local item = {
                label = tag.name,
                text = tag.name .. tag.path,
                file = tag.path,
              }
              if not refresh and tag.path == vim.api.nvim_buf_get_name(0) then
                item.pos = { vim.fn.line("."), vim.fn.col(".") }
              elseif tag.cursor then
                item.pos = { tag.cursor[1], tag.cursor[2] }
              end
              return item
            end)
            :filter(function(item)
              return item ~= nil
            end)
            :totable()
        end
        local items = get_items()
        local scope = "cwd"
        require("snacks").picker.pick({
          title = "Grapple",
          items = get_items(scope),
          confirm = function(picker, item)
            if not item then
              return
            end
            picker:close()
            grapple.select({ scope = scope, name = item.label })
          end,
          actions = {
            delete = function(picker, item)
              if not item then
                return
              end
              grapple.untag({ path = item.file, scope = scope })
              local items = get_items(scope, true)
              if #items == 0 then
                picker:close()
              else
                picker.opts.items = items
                picker:refresh()
              end
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-x>"] = {
                  "delete",
                  mode = { "n", "i" },
                },
              },
            },
          },
        })
      end, {})

      vim.keymap.set("n", "<leader>h", function()
        if grapple.exists(PREV1()) then
          if not BufIsSpecial() then
            vim.cmd("silent noa w")
          end
          local path = grapple.find(PREV1()).path
          if path == vim.api.nvim_buf_get_name(0) and grapple.exists(PREV2()) then
            grapple.select(PREV2())
            return
          else
            grapple.select(PREV1())
          end
        end
      end)

      vim.keymap.set("n", "m", function()
        local c = vim.fn.getcharstr()
        if not c:match("[a-zA-Z]") then
          return
        end
        if not grapple.exists({ name = c }) then
          print("no buffer tagged '" .. c .. "' or already in buffer")
          return
        end
        if
          grapple.find({ name = c }).path
          == vim.api.nvim_buf_get_name(0):gsub("/", "\\")
        then
          print("already in buffer '" .. c .. "'")
          return
        end
        if not BufIsSpecial() then
          vim.cmd("silent noa w")
        end
        jumplist.register()
        grapple.select({ name = c })
      end, {})

      vim.keymap.set("n", "<leader>m", function()
        local tag = vim.fn.getcharstr()
        if not tag:match("[a-zA-Z]") then
          return
        end
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

      local last_term_tag = nil
      local open_term = function(opts)
        last_term_tag = { name = opts.name }
        if not grapple.exists(opts) then
          if vim.loop.os_uname().sysname == "Windows_NT" then
            vim.cmd("term pwsh")
            vim.fn.feedkeys("a")
            vim.fn.feedkeys("cls" .. enter)
          else
            vim.cmd("term")
            vim.fn.feedkeys("a")
          end
        else
          grapple.select(opts)
          vim.fn.feedkeys("a")
        end
      end

      vim.keymap.set("n", "<leader>ot", function()
        open_term(TERM1())
      end)

      vim.keymap.set("n", "<leader>oT", function()
        open_term(TERM2())
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
          if last_term_tag ~= nil then
            grapple.tag(last_term_tag)
            last_term_tag = nil
          end
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

      vim.api.nvim_create_autocmd("TermClose", {
        callback = function(args)
          if is_lazygit_buffer() then
            return
          end
          local name = vim.api.nvim_buf_get_name(args.buf)
          if grapple.exists({ path = name }) then
            grapple.untag({ path = name })
          end
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
