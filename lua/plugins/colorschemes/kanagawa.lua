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
            Function = { italic = false, bold = true },
            Visual = { bg = colors.palette.winterGreen },
            String = { italic = false, bold = false },
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
      local palette = require("kanagawa.colors").setup().palette
      vim.api.nvim_set_hl(0, "@comment", { fg = palette.roninYellow })
      vim.api.nvim_set_hl(0, "Comment", { fg = palette.roninYellow })
      vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = palette.winterRed })
      vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = palette.winterYellow })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = palette.dragonBlack5 })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.dragonBlack4 })
      vim.api.nvim_set_hl(
        0,
        "@function.method",
        MergeHL("@function", { bold = false })
      )
      vim.api.nvim_set_hl(0, "@function.call", MergeHL("normal"))
      vim.api.nvim_set_hl(0, "@function.method.call", MergeHL("normal"))
      vim.api.nvim_set_hl(0, "@variable.builtin", MergeHL("@variable.parameter"))
      vim.api.nvim_set_hl(0, "@variable.member", MergeHL("@variable"))
      vim.api.nvim_set_hl(0, "@keyword.operator", MergeHL("@keyword"))
      vim.api.nvim_set_hl(0, "Number", MergeHL("Boolean"))
      vim.api.nvim_set_hl(0, "OilDirHidden", MergeHL("Directory"))
      vim.api.nvim_set_hl(0, "TreesitterContext", { bg = MergeHL("Normal").bg })
    end,
  },
}
