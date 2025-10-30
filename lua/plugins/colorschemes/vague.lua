return {
  {
    "vague2k/vague.nvim",
    enabled = not vim.g.vscode,
    priority = 1000,
    lazy = true,
    config = function()
      require("vague").setup({
        style = {
          boolean = "italic",
          builtin_constants = "italic",
          builtin_functions = "italic",
          builtin_types = "italic",
          builtin_variables = "italic",
        },
        plugins = {
          lsp = {
            diagnostic_info = "none",
          },
        },
      })
      vim.cmd("colorscheme vague")
      vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = "#3B1F29" })
      -- vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#3B311F" })
      vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#2E2A1F" })
      local colors = require("vague.config.internal").current.colors
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = colors.comment })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = colors.hint })
      vim.api.nvim_set_hl(
        0,
        "DiagnosticUnderlineHint",
        { cterm = { underline = true }, sp = colors.comment, underline = true }
      )
      vim.api.nvim_set_hl(
        0,
        "DiagnosticUnderlineInfo",
        { cterm = { underline = true }, sp = colors.hint, underline = true }
      )
      vim.api.nvim_set_hl(
        0,
        "DiagnosticUnderlineWarn",
        { cterm = { underline = true }, sp = colors.warning, underline = true }
      )
      vim.api.nvim_set_hl(
        0,
        "DiagnosticUnderlineError",
        { cterm = { underline = true }, sp = colors.error, underline = true }
      )
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#282830", fg = "#cdcdcd" }) -- Menu background and text color
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3c3c46", fg = "#cdcdcd" }) -- Selected item background and text color
      vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#3c3c46" }) -- Scrollbar background
      vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#646477" }) -- Scrollbar thumb color
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282830", fg = "#cdcdcd" }) -- Background and text color
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282830", fg = "#646477" }) -- Border color
      vim.api.nvim_set_hl(0, "CmpDocumentation", { bg = "#282830", fg = "#cdcdcd" }) -- Main text
      vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { fg = "#646477" }) -- Border color
      vim.api.nvim_set_hl(0, "CmpDocumentationFunction", { fg = "#a6e3a1" }) -- Green for function name
      vim.api.nvim_set_hl(0, "CmpDocumentationParameter", { fg = "#fab387" }) -- Orange for parameters
      vim.api.nvim_set_hl(0, "CmpDocumentationType", { fg = "#89b4fa" }) -- Blue for return type
      vim.api.nvim_set_hl(0, "CmpDocumentationHint", { fg = "#9399b2", italic = true }) -- Dimmed hints
      vim.api.nvim_set_hl(0, "CmpDocumentationWarning", { fg = "#f9e2af", bold = true }) -- Yellow warnings
      vim.api.nvim_set_hl(0, "CmpDocumentationError", { fg = "#f38ba8", bold = true }) -- Red errors
      local cmp_kinds = {
        Function = "#be8c8c", -- Functions
        Method = "#be8c8c", -- Methods
        Variable = "#c7c7d4", -- Variables
        Field = "#c7c7d4", -- Fields
        Property = "#c7c7d4", -- Properties
        Class = "#bad1ce", -- Classes
        Interface = "#bad1ce", -- Interfaces
        Module = "#bad1ce", -- Modules
        Constant = "#b4b4ce", -- Constants
        String = "#deb896", -- Strings
        Number = "#d2a374", -- Numbers
        Boolean = "#d2a374", -- Booleans
        Array = "#b4b4ce", -- Arrays
        Object = "#b4b4ce", -- Objects
        Key = "#b9a3ba", -- Keys
        Keyword = "#7894ab", -- Keywords
        Snippet = "#878787", -- Snippets
        Color = "#deb896", -- Colors
        File = "#cdcdcd", -- Files
        Reference = "#b4b4ce", -- References
        Folder = "#cdcdcd", -- Folders
        Enum = "#bad1ce", -- Enums
        EnumMember = "#b4b4ce", -- Enum Members
        Struct = "#bad1ce", -- Structs
        Event = "#be8c8c", -- Events
        Operator = "#96a3b2", -- Operators
        TypeParameter = "#b4b4ce", -- Type Parameters
      }
      for kind, color in pairs(cmp_kinds) do
        vim.api.nvim_set_hl(0, "CmpItemKind" .. kind, { fg = color })
      end
      vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#cdcdcd" }) -- Normal text
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#89b4fa", bold = true }) -- Matched text
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#89b4fa", italic = true }) -- Fuzzy match
      vim.api.nvim_set_hl(
        0,
        "CmpItemAbbrDeprecated",
        { fg = "#7f849c", strikethrough = true }
      ) -- Deprecated
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#a0a0a0", bg = "NONE" })
    end,
  },
}
