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
            ["@constructor.python"] = { link = "Normal" },
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
      local blue = { link = "@keyword" }
      local palette = require("kanagawa.colors").setup().palette
      local orange = { link = "Function" }
      local white = { link = "Normal" }
      local green = { link = "String" }
      vim.api.nvim_set_hl(0, "@comment", { fg = palette.roninYellow })
      vim.api.nvim_set_hl(0, "Comment", { fg = palette.roninYellow })
      vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = palette.winterRed })
      vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = palette.winterYellow })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = palette.dragonBlack5 })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.dragonBlack4 })
      vim.api.nvim_set_hl(0, "OilDirHidden", MergeHL("Directory"))
      vim.api.nvim_set_hl(0, "@function.method", orange)
      vim.api.nvim_set_hl(0, "@function.call", white)
      vim.api.nvim_set_hl(0, "@function.method.call", white)
      vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable.parameter" })
      vim.api.nvim_set_hl(0, "@variable.member", white)
      vim.api.nvim_set_hl(0, "@keyword.operator", blue)
      vim.api.nvim_set_hl(0, "Special", blue)
      vim.api.nvim_set_hl(0, "Operator", blue)
      vim.api.nvim_set_hl(0, "Number", green)
      vim.api.nvim_set_hl(0, "Boolean", blue)
      vim.api.nvim_set_hl(0, "@string.escape", blue)
      vim.api.nvim_set_hl(0, "Type", blue)
      vim.api.nvim_set_hl(0, "Constant", white)
      vim.api.nvim_set_hl(0, "@magic", green)
      vim.api.nvim_set_hl(0, "@class.name", orange)
      vim.api.nvim_set_hl(0, "@function.definition", orange)
      vim.api.nvim_set_hl(0, "@import.name", blue)
      vim.api.nvim_set_hl(0, "@import.target", blue)
      vim.api.nvim_set_hl(0, "@class.expression", white)
      vim.api.nvim_set_hl(0, "@attribute", white)
      vim.api.nvim_set_hl(0, "@decorator", orange)
      vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "IncSearch" })
      vim.api.nvim_set_hl(
        0,
        "MultiCursorDisabledCursor",
        { fg = MergeHL("Normal").bg, bg = palette.springGreen }
      )
    end,
  },
}
