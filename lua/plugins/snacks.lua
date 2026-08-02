return {
  {
    "folke/snacks.nvim",
    lazy = false,
    config = function()
      local snacks = require("snacks")
      snacks.setup({
        scope = {
          keys = {
            textobject = {
              ii = false,
              ia = false,
              ib = {
                cursor = false,
                desc = "inner scope",
                edge = false,
                min_size = 2,
                treesitter = {
                  blocks = {
                    enabled = false,
                  },
                },
              },
              ab = {
                cursor = false,
                desc = "full scope",
                edge = true,
                min_size = 2,
                treesitter = {
                  blocks = {
                    enabled = false,
                  },
                },
              },
            },
            jump = {
              ["[i"] = false,
              ["]i"] = false,
              ["[b"] = {
                min_size = 2,
                bottom = false,
                cursor = false,
                edge = true,
                treesitter = { blocks = { enabled = false } },
                desc = "jump to top edge of scope",
              },
              ["]b"] = {
                min_size = 2,
                bottom = true,
                cursor = false,
                edge = true,
                treesitter = { blocks = { enabled = false } },
                desc = "jump to bottom edge of scope",
              },
            },
          },
        },
        indent = {
          enabled = true,
          char = "│",
          indent = {
            enabled = false,
          },
          scope = {
            enabled = true,
            cursor = false,
          },
          animate = {
            enabled = false,
            duration = {
              step = 5,
              total = 50,
            },
          },
        },
        scratch = {
          ft = "markdown",
        },
        picker = {
          layout = {
            fullscreen = false,
            cycle = false,
          },
          sources = {
            explorer = {
              include = { "build" },
              auto_close = true,
              diagnostics = false,
              git_status = false,
              layout = {
                preset = "default",
                fullscreen = true,
              },
            },
          },
          win = {
            preview = {
              wo = {
                signcolumn = "no",
                number = false,
                statuscolumn = "",
              },
            },
          },
        },
      })

      vim.keymap.set("n", "<leader>of", function()
        Jumplist.register()
        snacks.picker.smart({
          multi = { "files" },
          layout = "select",
          watch = true,
          hidden = true,
          filter = { cwd = true },
        })
      end)

      vim.keymap.set("n", "<leader>oB", function()
        Jumplist.register()
        snacks.picker.buffers({ layout = "select" })
      end)

      vim.keymap.set("n", "<leader>ff", function()
        Jumplist.register()
        snacks.picker.grep()
      end)

      vim.keymap.set("n", "<leader>og", function()
        Jumplist.register()
        snacks.picker.git_diff()
      end)

      vim.keymap.set({ "n", "v" }, "<leader>fw", function()
        Jumplist.register()
        snacks.picker.grep_word()
      end)

      vim.keymap.set("n", "gr", function()
        Jumplist.register()
        snacks.picker.lsp_references()
      end)

      vim.keymap.set("n", "gR", function()
        Jumplist.register()
        snacks.picker.lsp_incoming_calls()
      end)

      vim.keymap.set("n", "gd", function()
        Jumplist.register()
        snacks.picker.lsp_definitions()
      end)

      vim.keymap.set("n", "gD", function()
        Jumplist.register()
        snacks.picker.lsp_type_definitions()
      end)

      vim.keymap.set("n", "<leader>oR", function()
        Jumplist.register()
        snacks.picker.resume()
      end)

      vim.keymap.set("n", "<leader>od", function()
        Jumplist.register()
        snacks.picker.diagnostics({
          sort = {
            fields = { "severity:asc", "is_current:asc", "file:asc", "lnum:asc" },
          },
        })
      end)

      vim.keymap.set("n", "<leader>oD", function()
        Jumplist.register()
        snacks.picker.diagnostics_buffer({
          sort = {
            fields = { "severity:asc", "lnum:asc" },
          },
        })
      end)

      vim.keymap.set("n", "<leader>oq", function()
        Jumplist.register()
        snacks.picker.qflist()
      end)

      vim.keymap.set("n", "<leader>oE", function()
        Jumplist.register()
        snacks.explorer()
      end)

      vim.keymap.set("n", "<leader>os", function()
        Jumplist.register()
        snacks.picker.lsp_symbols({ layout = { preset = "select" } })
      end)

      vim.keymap.set("n", "<leader>om", function()
        Jumplist.register()
        snacks.picker.marks()
      end)

      vim.keymap.set("n", "<leader>ou", function()
        Jumplist.register()
        snacks.picker.undo()
      end)

      local function scratch(title, path)
        local buf = vim.fn.bufadd(path)
        vim.fn.bufload(buf)
        snacks.win({
          buf = buf,
          width = 0.6,
          height = 0.6,
          border = "rounded",
          title = title,
        })
      end

      vim.keymap.set("n", "<leader>on", function()
        scratch("Notes", vim.fn.getcwd() .. "/notes.txt")
      end)

      vim.keymap.set("n", "<leader>oN", function()
        scratch("Global Notes", vim.fn.stdpath("data") .. "/notes.txt")
      end)
    end,
  },
}
