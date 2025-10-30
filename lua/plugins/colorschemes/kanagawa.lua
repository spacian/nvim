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
            ["@keyword.return"] = { italic = false, bold = true },
            -- ["@function.method"] = { italic = false, bold = true },
            -- ["@function.call"] = { italic = false, bold = true },
            ["@string.escape"] = { italic = true, bold = true },
            Function = { italic = false, bold = true },
            Visual = { bg = colors.palette.winterGreen },
            String = { italic = true, bold = false },
            Boolean = { italic = true, bold = false },
          }
        end,
        theme = "wave",
        background = {
          dark = "wave",
          light = "lotus",
        },
      })
      kanagawa.load("dragon")
      vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = "#43243B" }) -- kanagawa:winterRed
      vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#49443C" }) -- kanagawa:winterYellow
    end,
  },
}
