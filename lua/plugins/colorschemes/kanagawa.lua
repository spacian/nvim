return {
  {
    "rebelot/kanagawa.nvim",
    enabled = not vim.g.vscode,
    priority = 1000,
    lazy = false,
    config = function()
      local kanagawa = require("kanagawa")
      kanagawa.setup({
        commentStyle = { bold = false },
        functionStyle = { bold = false },
        keywordStyle = { italic = false, bold = false },
        statementStyle = { bold = false },
        typeStyle = { bold = false },
        transparent = false,
        dimInactive = false,
        terminalColors = false,
        colors = {
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
          return {
            ["@variable.builtin"] = { italic = false, bold = false },
            ["@keyword.operator"] = { italic = false, bold = false },
            ["@keyword.return"] = { italic = false, bold = false },
            -- ["@function.method"] = merge_hl("@function", {bold = false}),
            -- ["@function.method"] = merge_hl("@function", { bold = false }),
            -- ["@function.call"] = { italic = false, bold = false },
            -- ["@function.call"] = merge_hl("@function", { bold = false }),
            ["@string.escape"] = { italic = false, bold = false },
            ["@attribute.builtin.python"] = { link = "@attribute.python" },
            -- ["@function.method.call.python"] = { link = "@function.method" },
            ["@constructor.python"] = { link = "Function" },
            ["@property.lua"] = { link = "@variable" },
            Function = {
              italic = false,
              bold = false,
              fg = colors.palette.surimiOrange,
            },
            Visual = { bg = colors.palette.winterGreen },
            String = { italic = false, bold = false, fg = colors.palette.springGreen },
            Boolean = { italic = false, bold = false },
          }
        end,
        theme = "wave",
        background = {
          dark = "wave",
          light = "lotus",
        },
      })
      kanagawa.load("dragon")
      local default = { link = "@keyword" }
      local palette = require("kanagawa.colors").setup().palette
      vim.api.nvim_set_hl(0, "@comment", { fg = palette.roninYellow })
      vim.api.nvim_set_hl(0, "Comment", { fg = palette.roninYellow })
      vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = palette.winterRed })
      vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = palette.winterYellow })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = palette.dragonBlack5 })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.dragonBlack4 })
      vim.api.nvim_set_hl(0, "@function.method", MergeHL("@function", { bold = false }))
      vim.api.nvim_set_hl(0, "@function.call", MergeHL("normal"))
      vim.api.nvim_set_hl(0, "@function.method.call", MergeHL("normal"))
      vim.api.nvim_set_hl(0, "@variable.builtin", MergeHL("@variable.parameter"))
      vim.api.nvim_set_hl(0, "@variable.member", MergeHL("@variable"))
      vim.api.nvim_set_hl(0, "@keyword.operator", default)
      vim.api.nvim_set_hl(0, "Special", default)
      vim.api.nvim_set_hl(0, "Operator", default)
      vim.api.nvim_set_hl(0, "Number", default)
      vim.api.nvim_set_hl(0, "Boolean", default)
      vim.api.nvim_set_hl(0, "@string.escape", default)
      vim.api.nvim_set_hl(0, "Type", default)
      vim.api.nvim_set_hl(0, "Constant", default)
      vim.api.nvim_set_hl(0, "OilDirHidden", MergeHL("Directory"))
    end,
  },
}
