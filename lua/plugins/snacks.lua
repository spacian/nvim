return {
  {
    "folke/snacks.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
      local jumplist = require("keymaps.nvim.jumplist")
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
        jumplist.register()
        snacks.picker.smart({
          multi = { "files" },
          layout = "select",
          watch = true,
          hidden = true,
          filter = { cwd = true },
        })
      end)

      vim.keymap.set("n", "<leader>oB", function()
        jumplist.register()
        snacks.picker.buffers({ layout = "select" })
      end)

      vim.keymap.set("n", "<leader>ff", function()
        jumplist.register()
        snacks.picker.grep()
      end)

      vim.keymap.set("n", "<leader>og", function()
        jumplist.register()
        snacks.picker.git_diff()
      end)

      vim.keymap.set({ "n", "v" }, "<leader>fw", function()
        jumplist.register()
        snacks.picker.grep_word()
      end)

      vim.keymap.set("n", "gr", function()
        jumplist.register()
        snacks.picker.lsp_references()
      end)

      vim.keymap.set("n", "gd", function()
        jumplist.register()
        snacks.picker.lsp_definitions()
      end)

      vim.keymap.set("n", "gD", function()
        jumplist.register()
        snacks.picker.lsp_type_definitions()
      end)

      vim.keymap.set("n", "<leader>or", function()
        jumplist.register()
        snacks.picker.recent({
          layout = "select",
          filter = { paths = { [vim.fn.getcwd()] = true } },
        })
      end)

      vim.keymap.set("n", "<leader>oR", function()
        jumplist.register()
        snacks.picker.resume()
      end)

      vim.keymap.set("n", "<leader>od", function()
        jumplist.register()
        snacks.picker.diagnostics({
          sort = {
            fields = { "severity:asc", "is_current:asc", "file:asc", "lnum:asc" },
          },
        })
      end)

      vim.keymap.set("n", "<leader>oD", function()
        jumplist.register()
        snacks.picker.diagnostics_buffer({
          sort = {
            fields = { "severity:asc", "lnum:asc" },
          },
        })
      end)

      vim.keymap.set("n", "<leader>oq", function()
        jumplist.register()
        snacks.picker.qflist()
      end)

      vim.keymap.set("n", "<leader>oE", function()
        jumplist.register()
        snacks.explorer()
      end)

      vim.keymap.set("n", "<leader>os", function()
        jumplist.register()
        snacks.picker.lsp_symbols({ layout = { preset = "select" } })
      end)

      vim.keymap.set("n", "<leader>om", function()
        jumplist.register()
        snacks.picker.marks()
      end)

      vim.keymap.set("n", "<leader>ou", function()
        jumplist.register()
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
